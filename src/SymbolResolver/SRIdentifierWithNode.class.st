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

{ #category : #hooks }
SRIdentifierWithNode >> applyReplacementStrategyWithCurrentEntity: aCurrentEntity [
	aCurrentEntity isNullPatternObject ifTrue: [ ^ self ].
	self
		entity: (self notFoundReplacementEntity cull: self cull: aCurrentEntity)
]

{ #category : #accessing }
SRIdentifierWithNode >> entity [
	^ entity
]

{ #category : #accessing }
SRIdentifierWithNode >> entity: anObject [
	entity := anObject
]

{ #category : #resolution }
SRIdentifierWithNode >> resolveInScope: aScope currentEntity: currentEntity [
	(currentEntity isNullPatternObject) ifTrue: [ ^ self ].
	self
		entity:
			(aScope
				detect: [ :anEntity | 
					anEntity name = self identifier
						and: [ self checkKindOfEntity: anEntity ] ]).
	self triggerFoundActionWithCurrentEntity: currentEntity.
	self isLast
		ifFalse: [ self next resolveInScope: self entity currentEntity: currentEntity ]
]
