Class {
	#name : #CodingContestEvaluatorPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'actionBar',
		'code',
		'token',
		'labeledToken',
		'exerciseNumber',
		'labeledExerciseNumber',
		'form',
		'labelledChallengeName',
		'labelledArguments',
		'submitionResponse'
	],
	#category : #'Hornero-View'
}

{ #category : #specs }
CodingContestEvaluatorPresenter class >> defaultSpec [

	^ SpBoxLayout newVertical
		add: #form
			withConstraints: [ :constraints | constraints height: self labelledPresenterHeight * 3.5 ];
		add: #labelledChallengeName
			withConstraints: [ :constraints | constraints height: self labelledPresenterHeight ];
		add: #labelledArguments
			withConstraints: [ :constraints | constraints height: self labelledPresenterHeight ];
		add: #code withConstraints: [ :c | c fill: true ];
		addLast: #actionBar
			expand: false
			fill: false
			padding: 0;
		yourself
]

{ #category : #initialization }
CodingContestEvaluatorPresenter >> argumentsLabel [

	^ 'Parametros:'
]

{ #category : #initialization }
CodingContestEvaluatorPresenter >> challengeNameLabel [

	^ 'Desafio:'
]

{ #category : #Updating }
CodingContestEvaluatorPresenter >> informSubmition [

	self updateInformativeLabelsWith: form model
]

{ #category : #initialization }
CodingContestEvaluatorPresenter >> initializePresenters [

	form := self instantiate: ChallengeSelectionFormPresenter on: 2.
	actionBar := self newActionBar
		addLast:
			( self newButton
				label: 'Enviar';
				icon: ( self iconNamed: #smallOk );
				help: 'Evaluar y enviar la respuesta al server';
				action: [ self submitSolution.
					self
						inform:
							( submitionResponse
								at: 'mensaje'
								ifAbsent: [ submitionResponse at: 'error' ifAbsent: [ self halt ] ] )
					];
				yourself );
		yourself.
	labelledChallengeName := self newLabel label: self challengeNameLabel.
	labelledArguments := self newLabel label: self argumentsLabel.
	code := self newCode autoAccept: true
]

{ #category : #initialization }
CodingContestEvaluatorPresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Hornero';
		initialExtent: 400 @ 700
]

{ #category : #Submitting }
CodingContestEvaluatorPresenter >> submitSolution [

	| solution |

	solution := Smalltalk compiler evaluate: code text.

	submitionResponse := STONJSON
		fromString:
			( ZnClient new
				get:
					( 'http://hornero.fi.uncoma.edu.ar/index.php?r=juego/respuesta&tokenSolicitud=<1s>&solucion=<2p>'
						expandMacrosWith: form model token
						with: solution ) )
]

{ #category : #Updating }
CodingContestEvaluatorPresenter >> updateInformativeLabelsWith: aChallengeStarted [

	labelledChallengeName
		label: ( '<1s> <2s>' expandMacrosWith: self challengeNameLabel with: aChallengeStarted challengeName ).
	labelledArguments
		label: ( '<1s> <2s>' expandMacrosWith: self argumentsLabel with: aChallengeStarted arguments )
]
