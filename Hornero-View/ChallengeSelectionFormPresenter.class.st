Class {
	#name : #ChallengeSelectionFormPresenter,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'token',
		'submitButton',
		'challengeIdentifier',
		'labelledToken',
		'labelledChallengeIdentifier'
	],
	#category : #'Hornero-View'
}

{ #category : #specs }
ChallengeSelectionFormPresenter class >> defaultSpec [

	^ SpBoxLayout newVertical
		add: #labelledToken
			withConstraints: [ :constraints | constraints height: self labelledPresenterHeight ];
		add: #labelledChallengeIdentifier
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
ChallengeSelectionFormPresenter >> initializePresenters [

	token := self newTextInput autoAccept: true.
	labelledToken := self
		instantiate:
			( SpLabelledPresenter
				label: 'Token'
				input: token
				description: 'Copiar el token que te identifica en la plataforma.' ).

	challengeIdentifier := self newNumberInput autoAccept: true.
	labelledChallengeIdentifier := self
		instantiate: ( SpLabelledPresenter label: 'Desafío Nº' input: challengeIdentifier ).

	submitButton := self newButton label: 'Comenzar'.

	self focusOrder
		add: token;
		add: challengeIdentifier;
		add: submitButton
]

{ #category : #submiting }
ChallengeSelectionFormPresenter >> submit [

	[ | request response |

	request := StartChallengeRequest starting: challengeIdentifier number for: token text.
	response := request apply.
	self model: response.
	owner informSubmition.
	submitButton
		icon: ( self iconNamed: #thumbsUp );
		label: nil
	]
		on: AssertionFailure
		do: [ :signal | signal halt ]
]
