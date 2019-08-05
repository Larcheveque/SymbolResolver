"
I am a resolvable thing, i have an identifier and the solver will try to resolve me to fill the real entity (or candidates if multiple are possible).
"
Class {
	#name : #SRResolvable,
	#superclass : #Object,
	#instVars : [
		'identifier',
		'node',
		'next',
		'expectedKind',
		'foundAction',
		'notFoundReplacementEntity'
	],
	#category : #'SymbolResolver-Core'
}

{ #category : #'instance creation' }
SRResolvable class >> identifier: anIdentifier expectedKind: aKind node: aNode [ 
	^ (self identifier: anIdentifier node: aNode)
		expectedKind: aKind;
		yourself
]

{ #category : #'instance creation' }
SRResolvable class >> identifier: aStringIdentifier node: aPSQLASTIdentifier [
	^ self new
		identifier: aStringIdentifier;
		node: aPSQLASTIdentifier;
		yourself
]

{ #category : #'instance creation' }
SRResolvable class >> identifier: aStringIdentifier node: aPSQLASTIdentifier next: aNextPSQIdentifierWithNode [
	^ self new
		identifier: aStringIdentifier;
		node: aPSQLASTIdentifier;
		next: aNextPSQIdentifierWithNode;
		yourself
]

{ #category : #hooks }
SRResolvable >> applyReplacementStrategyWithCurrentEntity: aCurrentEntity [
	self subclassResponsibility 
]

{ #category : #resolution }
SRResolvable >> checkKindOfEntity: anEntity [
	self expectedKind ifNil: [ ^ true ].
	^ self expectedKind isCollection
		ifTrue: [ self expectedKind
				anySatisfy: [ :expectedPossibility | anEntity isKindOf: expectedPossibility ] ]
		ifFalse: [ anEntity isKindOf: self expectedKind ]
]

{ #category : #accessing }
SRResolvable >> entity [
	^ self subclassResponsibility 
]

{ #category : #accessing }
SRResolvable >> expectedKind [
	^ expectedKind
]

{ #category : #accessing }
SRResolvable >> expectedKind: anObject [
	expectedKind := anObject
]

{ #category : #accessing }
SRResolvable >> foundAction [
	^ foundAction
]

{ #category : #accessing }
SRResolvable >> foundAction: anObject [
	foundAction := anObject
]

{ #category : #testing }
SRResolvable >> hasReplacementStrategy [
	^ self notFoundReplacementEntity notNil
]

{ #category : #accessing }
SRResolvable >> identifier [
	^ identifier
]

{ #category : #accessing }
SRResolvable >> identifier: anObject [
	identifier := anObject
]

{ #category : #testing }
SRResolvable >> isLast [
	^ self next isNil
]

{ #category : #accessing }
SRResolvable >> next [
	^ next
]

{ #category : #accessing }
SRResolvable >> next: anObject [
	next := anObject
]

{ #category : #accessing }
SRResolvable >> node [
	^ node
]

{ #category : #accessing }
SRResolvable >> node: anObject [
	node := anObject
]

{ #category : #accessing }
SRResolvable >> notFoundReplacementEntity [
	^ notFoundReplacementEntity
]

{ #category : #accessing }
SRResolvable >> notFoundReplacementEntity: anObject [
	notFoundReplacementEntity := anObject
]

{ #category : #printing }
SRResolvable >> printIdentifierPath: aStream [
	aStream nextPutAll: self identifier.
	self isLast
		ifFalse: [ aStream nextPut: $..
			self next printIdentifierPath: aStream ]
]

{ #category : #printing }
SRResolvable >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(.
	self printIdentifierPath: aStream.
	aStream nextPut: $)
]

{ #category : #printing }
SRResolvable >> representationString [
	^ String streamContents: [ :s | self printIdentifierPath: s ]
]

{ #category : #resolution }
SRResolvable >> resolveInScope: aScope currentEntity: currentEntity [ 
	^ self subclassResponsibility 
]

{ #category : #accessing }
SRResolvable >> targetEntity [
	^ self isLast
		ifFalse: [ self next targetEntity ]
		ifTrue: [ self entity ]
]

{ #category : #hooks }
SRResolvable >> triggerFoundActionWithCurrentEntity: aCurrentEntity [
	aCurrentEntity isNullPatternObject ifTrue: [ ^ self ].
	^ self foundAction cull: self cull: aCurrentEntity
]
