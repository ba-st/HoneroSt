Class {
	#name : #ChallengeSelectionFormPresenter,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'token',
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
		yourself
]

{ #category : #initialization }
ChallengeSelectionFormPresenter >> initializeLabelledChallengeIdentifierInput [

	challengeIdentifier := self newNumberInput autoAccept: true.
	labelledChallengeIdentifier := self
		instantiate: ( SpLabelledPresenter label: 'Desafío Nº' input: challengeIdentifier )
]

{ #category : #initialization }
ChallengeSelectionFormPresenter >> initializeLabelledTokenInput [

	token := self newTextInput autoAccept: true.
	labelledToken := self
		instantiate:
			( SpLabelledPresenter
				label: 'Token'
				input: token
				description: 'Copiar el token que te identifica en la plataforma.' )
]

{ #category : #initialization }
ChallengeSelectionFormPresenter >> initializePresenters [

	self initializeLabelledTokenInput.
	self initializeLabelledChallengeIdentifierInput.

	self focusOrder
		add: token;
		add: challengeIdentifier
]

{ #category : #submiting }
ChallengeSelectionFormPresenter >> submit [

	| request |

	request := StartChallengeRequest starting: challengeIdentifier number for: token text.
	self model: request apply
]
