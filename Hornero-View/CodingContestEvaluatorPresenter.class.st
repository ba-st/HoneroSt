Class {
	#name : #CodingContestEvaluatorPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'actionBar',
		'code',
		'token',
		'labeledToken',
		'exerciseNumber',
		'labeledExerciseNumber',
		'form'
	],
	#category : #'Hornero-View'
}

{ #category : #specs }
CodingContestEvaluatorPresenter class >> defaultSpec [

	^ SpBoxLayout newVertical
		add: #form withConstraints: [:constraints | constraints height: self labelledPresenterHeight * 3 ];
		add: #code withConstraints: [ :c | c fill: true ];
		addLast: #actionBar
			expand: false
			fill: false
			padding: 0;
		yourself
]

{ #category : #initialization }
CodingContestEvaluatorPresenter >> initializePresenters [

	form := self instantiate: ChallengeSelectionFormPresenter on: 2.

	actionBar := self newActionBar
		addLast:
			( self newButton
				label: 'Enviar';
				icon: ( self iconNamed: #smallOk );
				help: 'Evaluar y enviar la respuesta al server';
				action: [ self inform: 'Enviado' ];
				yourself );
		yourself.

	code := self newCode
]
