Class {
	#name : #StartedChallenge,
	#superclass : #Object,
	#instVars : [
		'challengeName',
		'arguments',
		'possibleSolutions',
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

{ #category : #Accessing }
StartedChallenge >> arguments [
	^ arguments
]

{ #category : #Accessing }
StartedChallenge >> challengeName [
	^ challengeName
]

{ #category : #Initialization }
StartedChallenge >> initializeNamed: aChallengeName with: anArgumentsCollection identifyingResponseWith: aToken [

	challengeName := aChallengeName.
	arguments := anArgumentsCollection.
	token := aToken
]

{ #category : #Accessing }
StartedChallenge >> possibleSolutions [
	^ possibleSolutions
]

{ #category : #Accessing }
StartedChallenge >> token [
	^ token
]
