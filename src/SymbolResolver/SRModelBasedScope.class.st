"
I am a scope that provides all entities of a kind in a model
"
Class {
	#name : #SRModelBasedScope,
	#superclass : #SRScope,
	#instVars : [
		'model',
		'entityType'
	],
	#category : #'SymbolResolver-Scopes'
}

{ #category : #testing }
SRModelBasedScope >> canContainsEntitiesOfType: aType [
	^ aType isNil
		or:
			[ aType = self entityType or: [ aType inheritsFrom: self entityType ] ]
]

{ #category : #accessing }
SRModelBasedScope >> entityType [
	^ entityType
]

{ #category : #accessing }
SRModelBasedScope >> entityType: anObject [
	entityType := anObject
]

{ #category : #accessing }
SRModelBasedScope >> model [
	^ model
]

{ #category : #accessing }
SRModelBasedScope >> model: anObject [
	model := anObject
]

{ #category : #accessing }
SRModelBasedScope >> reachableEntitiesOwned [
	^ self model allWithType: self entityType
]
