Class {
	#name : #BaselineOfSymbolResolver,
	#superclass : #BaselineOf,
	#category : #BaselineOfSymbolResolver
}

{ #category : #baselines }
BaselineOfSymbolResolver >> baseline: spec [
	<baseline>
	spec for: #common do: [ spec package: 'SymbolResolver' ]
]
