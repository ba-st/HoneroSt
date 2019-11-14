Class {
	#name : #SubmitChallengeSolutionRequest,
	#superclass : #Object,
	#instVars : [
		'solution',
		'challengeSession'
	],
	#category : #Hornero
}

{ #category : #'instance creation' }
SubmitChallengeSolutionRequest class >> submitting: aSolution for: aChallengeSession [ 

	^ self new initializeSubmitting: aSolution for: aChallengeSession 
]

{ #category : #applying }
SubmitChallengeSolutionRequest >> apply [

	| location |

	location := 'http://hornero.fi.uncoma.edu.ar/index.php?r=juego/respuesta&tokenSolicitud=<1s>&solucion=<2p>'
		expandMacrosWith: challengeSession token
		with: solution.

	^ STONJSON fromString: ( ZnClient new get: location )
]

{ #category : #initialization }
SubmitChallengeSolutionRequest >> initializeSubmitting: aSolution for: aChallengeSession [ 
	
	solution := aSolution .
	challengeSession := aChallengeSession 
]
