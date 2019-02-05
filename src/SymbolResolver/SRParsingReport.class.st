"
I hold all the errors that were raised during parsing so they are not just ignored and lost while the model is built.

With my help, it is possible to create incomplete models to work with til the importer works entirely.
"
Class {
	#name : #SRParsingReport,
	#superclass : #Object,
	#instVars : [
		'errors',
		'warnings'
	],
	#category : #'SymbolResolver-Core'
}

{ #category : #adding }
SRParsingReport >> addError: anError [
	^ self errors add: anError
]

{ #category : #adding }
SRParsingReport >> addWarning: anObject [
	self warnings add: anObject
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

{ #category : #initialization }
SRParsingReport >> initialize [
	super initialize.
	self errors: OrderedCollection new.
	self warnings: OrderedCollection new
]

{ #category : #accessing }
SRParsingReport >> warnings [
	^ warnings
]

{ #category : #accessing }
SRParsingReport >> warnings: anObject [
	warnings := anObject
]
