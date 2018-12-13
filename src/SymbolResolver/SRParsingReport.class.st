"
I hold all the errors that were raised during parsing so they are not just ignored and lost while the model is built.

With my help, it is possible to create incomplete models to work with til the importer works entirely.
"
Class {
	#name : #SRParsingReport,
	#superclass : #Object,
	#instVars : [
		'errors'
	],
	#category : #SymbolResolver
}

{ #category : #adding }
SRParsingReport >> addError: anError [
	^ self errors add: anError
]

{ #category : #accessing }
SRParsingReport >> errors [
	^ errors
]

{ #category : #accessing }
SRParsingReport >> errors: anObject [
	errors := anObject
]

{ #category : #testing }
SRParsingReport >> ifNotEmpty: aBlock [
	self errors ifNotEmpty: aBlock
]

{ #category : #accessing }
SRParsingReport >> initialize [
	super initialize.
	self errors: OrderedCollection new.
]
