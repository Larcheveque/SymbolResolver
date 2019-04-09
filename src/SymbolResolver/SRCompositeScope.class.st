Class {
	#name : #SRCompositeScope,
	#superclass : #SRScope,
	#instVars : [
		'scopes'
	],
	#category : #'SymbolResolver-Scopes'
}

{ #category : #'instance creation' }
SRCompositeScope class >> withScopes: aCollectionOfScope [
	^ self new
		addScopes: aCollectionOfScope;
		yourself
]

{ #category : #initialization }
SRCompositeScope >> addScopes: aCollectionOfScopes [
	self scopes addAll: aCollectionOfScopes
]

{ #category : #accessing }
SRCompositeScope >> aliases [
	^ super aliases , (self scopes flatCollect: #aliases)
]

{ #category : #accessing }
SRCompositeScope >> hasAliases [
	^ self scopes anySatisfy: #hasAliases
]

{ #category : #initialization }
SRCompositeScope >> initialize [
	super initialize.
	self scopes: OrderedCollection new
]

{ #category : #accessing }
SRCompositeScope >> reachableEntitiesOwned [
	^ self scopes flatCollect: #reachableEntities
]

{ #category : #accessing }
SRCompositeScope >> scopes [
	^ scopes
]

{ #category : #accessing }
SRCompositeScope >> scopes: anObject [
	scopes := anObject
]
