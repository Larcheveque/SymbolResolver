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
		'expectedKind'
	],
	#category : #'SymbolResolver-Core'
}

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
SRResolvable >> resolveInScope: aScope [ 
	^ self subclassResponsibility 
]

{ #category : #accessing }
SRResolvable >> targetEntity [
	^ self isLast
		ifFalse: [ self next targetEntity ]
		ifTrue: [ self entity ]
]
