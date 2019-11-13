Class {
	#name : #BaselineOfHorneroSt,
	#superclass : #BaselineOf,
	#category : #BaselineOfHorneroSt
}

{ #category : #baselines }
BaselineOfHorneroSt >> baseline: spec [

	<baseline>
	spec
		for: #pharo
		do: [ spec
				package: 'Hornero';
				package: 'Hornero-View' with: [ spec requires: 'Hornero' ];
				group: 'default' with: #('Hornero-View')
			]
]
