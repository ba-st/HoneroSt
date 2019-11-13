Class {
	#name : #ChallengeSelectionFormPresenter,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'token',
		'labeledToken',
		'submitButton',
		'modelBuilder',
		'labeledChallengeIdentifier',
		'challengeIdentifier'
	],
	#category : #'Hornero-View'
}

{ #category : #specs }
ChallengeSelectionFormPresenter class >> defaultSpec [

	^ SpBoxLayout newVertical
		add: #labeledToken
			withConstraints: [ :constraints | constraints height: self labelledPresenterHeight ];
		add: #labeledChallengeIdentifier
			withConstraints: [ :constraints | constraints height: self labelledPresenterHeight ];
		add: #submitButton
			withConstraints: [ :constraints | constraints height: self labelledPresenterHeight ];
		yourself
]

{ #category : #initialization }
ChallengeSelectionFormPresenter >> connectPresenters [

	submitButton action: [ self submit ]
]

{ #category : #initialization }
ChallengeSelectionFormPresenter >> initialize [

	modelBuilder := StartChallengeRequestBuilder new.
	super initialize
]

{ #category : #initialization }
ChallengeSelectionFormPresenter >> initializePresenters [

	token := self newTextInput autoAccept: true.
	labeledToken := self
		instantiate:
			( SpLabelledPresenter
				label: 'Token'
				input: token
				description: 'Copiar el token que te identifica en la plataforma.' ).

	challengeIdentifier := self newNumberInput autoAccept: true.
	labeledChallengeIdentifier := self
		instantiate: ( SpLabelledPresenter label: 'Desafío Nº' input: challengeIdentifier ).

	submitButton := self newButton label: 'Comenzar'
]

{ #category : #submiting }
ChallengeSelectionFormPresenter >> submit [

	modelBuilder
		token: token text;
		challenge: challengeIdentifier number;
		yourself.

	[ self setAnnouncingObject: modelBuilder build ]
		on: AssertionFailure
		do: [ :signal | signal halt ]
]
