"
I am an error that occurs when the solver do not find the reference
"
Class {
	#name : #SRReferenciesNotFound,
	#superclass : #SRReferencesError,
	#category : #'SymbolResolver-Errors'
}

{ #category : #exceptioninstantiator }
SRReferenciesNotFound class >> signal: anIdentifier [
	^ self new
		identifier: anIdentifier;
		signal
]
