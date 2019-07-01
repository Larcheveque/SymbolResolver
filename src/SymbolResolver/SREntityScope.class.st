"
I am a scope that contains one entity. I will return all the reachable entities from the entity i contain if i am asked to. But i will be ignored concerning current entity
"
Class {
	#name : #SREntityScope,
	#superclass : #SRScope,
	#instVars : [
		'entity',
		'isCurrentEntity'
	],
	#category : #'SymbolResolver-Scopes'
}

{ #category : #accessing }
SREntityScope class >> currentEntity: anEntity [
	^ self new
		entity: anEntity;
		isCurrentEntity: true;
		yourself
]

{ #category : #accessing }
SREntityScope class >> entity: anEntity [
	^ self new
		entity: anEntity;
		isCurrentEntity: false;
		yourself
]

{ #category : #accessing }
SREntityScope >> currentEntity [
	self assert: self isCurrentEntity.
	^ self entity
]

{ #category : #accessing }
SREntityScope >> entity [
	^ entity
]

{ #category : #accessing }
SREntityScope >> entity: anObject [
	entity := anObject
]

{ #category : #accessing }
SREntityScope >> hasCurrentEntity [
	^ self isCurrentEntity
]

{ #category : #initialization }
SREntityScope >> initialize [
	super initialize.
	self isCurrentEntity: false
]

{ #category : #accessing }
SREntityScope >> isCurrentEntity [
	^ isCurrentEntity
]

{ #category : #accessing }
SREntityScope >> isCurrentEntity: anObject [
	isCurrentEntity := anObject
]

{ #category : #printing }
SREntityScope >> printOn: aStream [
	super printOn: aStream.
	aStream << $(.
	aStream << $".
	self entity
		ifNil: [ aStream << 'No Entity' ]
		ifNotNil: [ self entity name printOn: aStream.
			aStream << '":'.
			self entity class printOn: aStream ].
	aStream << $)
]

{ #category : #accessing }
SREntityScope >> reachableEntitiesOwned [
	^ self entity reachableEntities
]
