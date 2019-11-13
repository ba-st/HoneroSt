Class {
	#name : #StartChallengeRequestBuilder,
	#superclass : #Object,
	#instVars : [
		'token',
		'challenge'
	],
	#category : #Hornero
}

{ #category : #building }
StartChallengeRequestBuilder >> build [

	( token isNil or: [ challenge isNil ] )
		ifTrue: [ AssertionFailure signal: 'Wait' ].

	^ StartChallengeRequest starting: challenge for: token
]

{ #category : #configuring }
StartChallengeRequestBuilder >> challenge: aChallengeIdenfitifer [

	challenge := aChallengeIdenfitifer
]

{ #category : #configuring }
StartChallengeRequestBuilder >> token: aToken [

	token := aToken
]
