Class {
	#name : #SubmitChallengeSolutionRequest,
	#superclass : #Object,
	#instVars : [
		'solution',
		'startedChallenge'
	],
	#category : #Hornero
}

{ #category : #'instance creation' }
SubmitChallengeSolutionRequest class >> submitting: aSolution for: aStartedChallenge [ 

	^ self new initializeSubmitting: aSolution for: aStartedChallenge 
]

{ #category : #applying }
SubmitChallengeSolutionRequest >> apply [

	| location |

	location := 'http://hornero.fi.uncoma.edu.ar/index.php?r=juego/respuesta&tokenSolicitud=<1s>&solucion=<2p>'
		expandMacrosWith: startedChallenge token
		with: solution.

	^ STONJSON fromString: ( ZnClient new get: location )
]

{ #category : #initialization }
SubmitChallengeSolutionRequest >> initializeSubmitting: aSolution for: aStartedChallenge [ 
	
	solution := aSolution .
	startedChallenge := aStartedChallenge 
]
