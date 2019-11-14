Class {
	#name : #StartedChallenge,
	#superclass : #Object,
	#instVars : [
		'challengeName',
		'arguments',
		'token'
	],
	#category : #Hornero
}

{ #category : #'Instance-Creation' }
StartedChallenge class >> fromString: aString [

	| json |

	json := STONJSON fromString: aString.

	^ self new
		initializeNamed: ( json at: 'nombreProblema' )
		with: ( json at: 'parametrosEntrada' )
		identifyingResponseWith: ( json at: 'token' )
]

{ #category : #accessing }
StartedChallenge >> arguments [

	^ arguments
]

{ #category : #accessing }
StartedChallenge >> challengeName [

	^ challengeName
]

{ #category : #Initialization }
StartedChallenge >> initializeNamed: aChallengeName with: anArgumentsCollection identifyingResponseWith: aToken [

	challengeName := aChallengeName.
	arguments := anArgumentsCollection.
	token := aToken
]

{ #category : #accessing }
StartedChallenge >> token [

	^ token
]
