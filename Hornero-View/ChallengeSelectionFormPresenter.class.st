Class {
	#name : #ChallengeSelectionFormPresenter,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'token',
		'labeledToken',
		'submitButton',
		'labeledChallengeIdentifier',
		'challengeIdentifier',
		'requestBuilder'
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

	requestBuilder := StartChallengeRequestBuilder new.
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

	submitButton := self newButton label: 'Comenzar'.

	self focusOrder
		add: token;
		add: challengeIdentifier;
		add: submitButton
]

{ #category : #submiting }
ChallengeSelectionFormPresenter >> submit [

	requestBuilder
		token: token text;
		challenge: challengeIdentifier number;
		yourself.

	[ | request response |

	request := requestBuilder build.
	response := request apply.
	self model: response.
	submitButton
		icon: ( self iconNamed: #thumbsUp );
		label: nil
	]
		on: AssertionFailure
		do: [ :signal | signal halt ]
]
