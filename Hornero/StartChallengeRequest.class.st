Class {
	#name : #StartChallengeRequest,
	#superclass : #Object,
	#instVars : [
		'challenge',
		'token'
	],
	#category : #Hornero
}

{ #category : #'instance creation' }
StartChallengeRequest class >> starting: aChallenge for: aToken [

	^ self new initializeStarting: aChallenge for: aToken
]

{ #category : #applying }
StartChallengeRequest >> apply [

	| location |

	location := 'http://hornero.fi.uncoma.edu.ar/index.php?r=juego/solicitud&token=<1s>&problema=<2p>'
		expandMacrosWith: token
		with: challenge.

	^ ChallengeSession fromString: ( ZnClient new get: location )
]

{ #category : #initialization }
StartChallengeRequest >> initializeStarting: aChallenge for: aToken [

	challenge := aChallenge.
	token := aToken 
]
