Class {
	#name : #ChallengeStarted,
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
ChallengeStarted class >> wrapping: aSTONJSON [

	^ self new initializeWrapping: aSTONJSON
]

{ #category : #Accessing }
ChallengeStarted >> arguments [
	^ arguments
]

{ #category : #Accessing }
ChallengeStarted >> challengeName [
	^ challengeName
]

{ #category : #Initialization }
ChallengeStarted >> initializeWrapping: aSTONJSON [

	challengeName := aSTONJSON at: 'nombreProblema'.
	arguments := aSTONJSON at: 'parametrosEntrada'.
	possibleSolutions := aSTONJSON at: 'opciones'.
	token := aSTONJSON at: 'token'
]

{ #category : #Accessing }
ChallengeStarted >> possibleSolutions [
	^ possibleSolutions
]

{ #category : #Accessing }
ChallengeStarted >> token [
	^ token
]
