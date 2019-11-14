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
			withConstraints: [ :constraints | constraints height: self labelledPresenterHeight * 2 ];
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
CodingContestEvaluatorPresenter >> arguments [

	^ self startedChallenge arguments substrings: ','
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
				action: [ self submit ];
				yourself );
		yourself.

	code := self newCode autoAccept: true.
	
	self focusOrder
		add: form;
		add: code;
		add: actionBar
]

{ #category : #initialization }
CodingContestEvaluatorPresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Hornero';
		initialExtent: 400 @ 500
]

{ #category : #submitting }
CodingContestEvaluatorPresenter >> requestChallenge [

	form submit
]

{ #category : #accessing }
CodingContestEvaluatorPresenter >> startedChallenge [

	^ form model
]

{ #category : #submitting }
CodingContestEvaluatorPresenter >> submit [

	self
		requestChallenge;
		submitSolution
]

{ #category : #submitting }
CodingContestEvaluatorPresenter >> submitSolution [

	| solution submitionResponse |

	solution := Smalltalk compiler
		source: code text;
		receiver: self;
		evaluate.

	submitionResponse := ( SubmitChallengeSolutionRequest
		submitting: solution
		for: self startedChallenge ) apply.

	self
		inform:
			( submitionResponse
				at: 'mensaje'
				ifAbsent: [ submitionResponse at: 'error' ifAbsent: [ self halt ] ] )
]
