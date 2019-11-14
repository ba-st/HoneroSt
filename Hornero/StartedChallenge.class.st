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
StartedChallenge class >> wrapping: aSTONJSON [

	^ self new initializeWrapping: aSTONJSON
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
StartedChallenge >> initializeWrapping: aSTONJSON [

	challengeName := aSTONJSON at: 'nombreProblema'.
	arguments := aSTONJSON at: 'parametrosEntrada'.
	possibleSolutions := aSTONJSON at: 'opciones'.
	token := aSTONJSON at: 'token'
]

{ #category : #Accessing }
StartedChallenge >> possibleSolutions [
	^ possibleSolutions
]

{ #category : #Accessing }
StartedChallenge >> token [
	^ token
]
