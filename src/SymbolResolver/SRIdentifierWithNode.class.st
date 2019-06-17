"
I am a resolvable only identified by an identifier (like an instance variable or a property)
"
Class {
	#name : #SRIdentifierWithNode,
	#superclass : #SRResolvable,
	#instVars : [
		'entity'
	],
	#category : #'SymbolResolver-Core'
}

{ #category : #accessing }
SRIdentifierWithNode >> entity [
	^ entity
]

{ #category : #accessing }
SRIdentifierWithNode >> entity: anObject [
	entity := anObject
]

{ #category : #resolution }
SRIdentifierWithNode >> resolveInScope: aScope [
	self
		entity: (aScope detect: [ :anEntity | anEntity name = self identifier ]).
	self isLast
		ifFalse: [ self next resolveInScope: self entity ]
]
