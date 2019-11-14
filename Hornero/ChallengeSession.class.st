Class {
	#name : #ChallengeSession,
	#superclass : #Object,
	#instVars : [
		'challengeName',
		'arguments',
		'token'
	],
	#category : #Hornero
}

{ #category : #'Instance-Creation' }
ChallengeSession class >> fromString: aString [

	| json |

	json := STONJSON fromString: aString.

	^ self
		named: ( json at: 'nombreProblema' )
		with: ( json at: 'parametrosEntrada' )
		identifiedBy: ( json at: 'token' )
]

{ #category : #'Instance-Creation' }
ChallengeSession class >> named: aChallengeName with: anArgumentsCollection identifiedBy: aToken [

	^ self new
		initializeNamed: aChallengeName
		with: anArgumentsCollection
		identifiedBy: aToken
]

{ #category : #accessing }
ChallengeSession >> arguments [

	^ arguments
]

{ #category : #accessing }
ChallengeSession >> challengeName [

	^ challengeName
]

{ #category : #Initialization }
ChallengeSession >> initializeNamed: aChallengeName with: anArgumentsCollection identifiedBy: aToken [

	challengeName := aChallengeName.
	arguments := anArgumentsCollection.
	token := aToken
]

{ #category : #accessing }
ChallengeSession >> token [

	^ token
]
