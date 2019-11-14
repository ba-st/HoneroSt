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
		'labelledArguments'
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

{ #category : #specs }
CodingContestEvaluatorPresenter class >> menuCommandOn: aBuilder [

	<worldMenu>
	( aBuilder item: #Hornero )
		parent: #Tools;
		action: [ self new openWithSpec ];
		order: 20;
		help: 'Open Hornero';
		icon: self taskbarIcon.
	aBuilder withSeparatorAfter
]

{ #category : #accessing }
CodingContestEvaluatorPresenter >> argumentos [

	^ form model arguments substrings: ','
]

{ #category : #initialization }
CodingContestEvaluatorPresenter >> argumentsLabel [

	^ 'Parametros:'
]

{ #category : #initialization }
CodingContestEvaluatorPresenter >> challengeNameLabel [

	^ 'Desafio:'
]

{ #category : #updating }
CodingContestEvaluatorPresenter >> informSubmition [

	self updateInformativeLabelsWith: form model
]

{ #category : #initialization }
CodingContestEvaluatorPresenter >> initializePresenters [

	form := self instantiate: ChallengeSelectionFormPresenter.
	actionBar := self newActionBar
		addLast:
			( self newButton
				label: 'Enviar';
				icon: ( self iconNamed: #smallOk );
				help: 'Evaluar y enviar la respuesta al server';
				action: [ self submitSolution ];
				yourself );
		yourself.
	labelledChallengeName := self newLabel label: self challengeNameLabel.
	labelledArguments := self newLabel label: self argumentsLabel.
	code := self newCode autoAccept: true; doItContext:  self
]

{ #category : #initialization }
CodingContestEvaluatorPresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Hornero';
		initialExtent: 400 @ 700
]

{ #category : #accessing }
CodingContestEvaluatorPresenter >> startedChallenge [

	^ form model
]

{ #category : #submitting }
CodingContestEvaluatorPresenter >> submitSolution [

	| solution submitionResponse |

	solution := Smalltalk compiler source: code text; receiver: self; evaluate.

	submitionResponse := ( SubmitChallengeSolutionRequest
		submitting: solution
		for: self startedChallenge ) apply.

	self
		inform:
			( submitionResponse
				at: 'mensaje'
				ifAbsent: [ submitionResponse at: 'error' ifAbsent: [ self halt ] ] )
]

{ #category : #updating }
CodingContestEvaluatorPresenter >> updateInformativeLabelsWith: aChallengeStarted [

	labelledChallengeName
		label: ( '<1s> <2s>' expandMacrosWith: self challengeNameLabel with: aChallengeStarted challengeName ).
	labelledArguments
		label: ( '<1s> <2s>' expandMacrosWith: self argumentsLabel with: aChallengeStarted arguments )
]
