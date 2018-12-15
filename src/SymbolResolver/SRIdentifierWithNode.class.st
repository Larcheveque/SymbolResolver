Class {
	#name : #SRIdentifierWithNode,
	#superclass : #Object,
	#instVars : [
		'identifier',
		'node',
		'entity',
		'next'
	],
	#category : #'SymbolResolver-Core'
}

{ #category : #'instance creation' }
SRIdentifierWithNode class >> identifier: aStringIdentifier node: aPSQLASTIdentifier [
	^ self new
		identifier: aStringIdentifier;
		node: aPSQLASTIdentifier;
		yourself
]

{ #category : #'instance creation' }
SRIdentifierWithNode class >> identifier: aStringIdentifier node: aPSQLASTIdentifier next: aNextPSQIdentifierWithNode [
	^ self new
		identifier: aStringIdentifier;
		node: aPSQLASTIdentifier;
		next: aNextPSQIdentifierWithNode;
		yourself
]

{ #category : #accessing }
SRIdentifierWithNode >> entity [
	^ entity
]

{ #category : #accessing }
SRIdentifierWithNode >> entity: anObject [
	entity := anObject
]

{ #category : #accessing }
SRIdentifierWithNode >> identifier [
	^ identifier
]

{ #category : #accessing }
SRIdentifierWithNode >> identifier: anObject [
	identifier := anObject
]

{ #category : #testing }
SRIdentifierWithNode >> isLast [
	^ self next isNil
]

{ #category : #accessing }
SRIdentifierWithNode >> next [
	^ next
]

{ #category : #accessing }
SRIdentifierWithNode >> next: anObject [
	next := anObject
]

{ #category : #accessing }
SRIdentifierWithNode >> node [
	^ node
]

{ #category : #accessing }
SRIdentifierWithNode >> node: anObject [
	node := anObject
]

{ #category : #printing }
SRIdentifierWithNode >> printIdentifierPath: aStream [
	aStream nextPutAll: self identifier.
	self isLast
		ifFalse: [ aStream nextPut: $..
			self next printIdentifierPath: aStream ]
]

{ #category : #printing }
SRIdentifierWithNode >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(.
	self printIdentifierPath: aStream.
	aStream nextPut: $)
]

{ #category : #accessing }
SRIdentifierWithNode >> targetEntity [
	^ self isLast
		ifFalse: [ self next targetEntity ]
		ifTrue: [ self entity ]
]
