"
I am an error that occurs when the solver start to find the reference but then failed to follow the next identifier.

For example, in foo.bar, the resolver was able to resolve foo but not bar.
"
Class {
	#name : #SRReferenciesInconsistencies,
	#superclass : #SRReferencesError,
	#category : #'SymbolResolver-Errors'
}

{ #category : #exceptioninstantiator }
SRReferenciesInconsistencies class >> signal: anIdentifier [
	^ self new
		identifier: anIdentifier;
		signal
]
