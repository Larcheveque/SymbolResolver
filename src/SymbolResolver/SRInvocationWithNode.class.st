"
I am a resolvable that is invoked (a function call, a message sent...). I have arguments that will be used to be resolved
"
Class {
	#name : #SRInvocationWithNode,
	#superclass : #SRResolvable,
	#instVars : [
		'arguments',
		'candidates'
	],
	#category : #'SymbolResolver-Core'
}

{ #category : #'instance creation' }
SRInvocationWithNode class >> identifier: anIdentifier node: aNode expectedKind: aKind arguments: aCollectionOfArguments [
	^ (self identifier: anIdentifier node: aNode)
		expectedKind: aKind;
		arguments: aCollectionOfArguments;
		yourself
]

{ #category : #accessing }
SRInvocationWithNode >> arguments [
	^ arguments
]

{ #category : #accessing }
SRInvocationWithNode >> arguments: anObject [
	arguments := anObject
]

{ #category : #accessing }
SRInvocationWithNode >> candidates [
	^ candidates
]

{ #category : #accessing }
SRInvocationWithNode >> candidates: anObject [
	candidates := anObject
]

{ #category : #accessing }
SRInvocationWithNode >> entity [
	^ self candidates size = 1
		ifTrue: [ self candidates anyOne ]
		ifFalse: [ NotFound signal ]
]

{ #category : #resolution }
SRInvocationWithNode >> resolveInScope: aScope [
	(aScope canContainsEntitiesOfType: self expectedKind)
		ifFalse: [ NotFound signal ].
	^ (aScope
		select: [ :anEntity | 
			anEntity name = self identifier
				and: [ self checkKindOfEntity: anEntity ] ])
		ifEmpty: [ NotFound signal ]
		ifNotEmpty: [ :entities | 
			self candidates: entities.
			self isLast
				ifTrue: [ ^ self ]
				ifFalse: [ SRNotSupportedYetFunctionnality signal ] ]
]
