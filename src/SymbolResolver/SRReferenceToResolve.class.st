"
I represent a reference that will be resolved in the future. I contain everything required for that (scopes, identifiers, actions)
"
Class {
	#name : #SRReferenceToResolve,
	#superclass : #Object,
	#instVars : [
		'scopes',
		'identifiers'
	],
	#category : #'SymbolResolver-Solver'
}

{ #category : #'instance creation' }
SRReferenceToResolve class >> newFromScopes: aCollectionOfScopes identifiers: aSRIdentifierWithNode [
	^ self new
		scopes: aCollectionOfScopes;
		identifiers: aSRIdentifierWithNode;
		yourself
]

{ #category : #accessing }
SRReferenceToResolve >> currentEntity [
	^ (self scopes
		detect: #hasCurrentEntity
		ifNone: [ SRNoCurrentEntityAvailable signalReferencesResolver: self ])
		currentEntity
]

{ #category : #accessing }
SRReferenceToResolve >> identifiers [
	^ identifiers
]

{ #category : #accessing }
SRReferenceToResolve >> identifiers: anObject [
	identifiers := anObject
]

{ #category : #accessing }
SRReferenceToResolve >> scopes [
	^ scopes
]

{ #category : #accessing }
SRReferenceToResolve >> scopes: anObject [
	"Scopes are poped and pushed during the visit so we have to copy this mutating collection"
	scopes := anObject copy
]
