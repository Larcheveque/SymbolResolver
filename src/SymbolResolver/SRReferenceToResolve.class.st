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

{ #category : #resolution }
SRReferenceToResolve >> resolve [
	self scopes
		do: [ :aScope | 
			[ ^ self resolve: self identifiers inScope: aScope ]
				on: NotFound
				do: [ "do nothing to try superior scope" ] ].
	identifiers hasReplacementStrategy
		ifTrue: [ identifiers applyReplacementStrategyWithCurrentEntity: self currentEntity.
			^ identifiers triggerFoundActionWithCurrentEntity: self currentEntity ]
		ifFalse: [ SRReferencesNotFound signalIdentifiers: identifiers ]
]

{ #category : #accessing }
SRReferenceToResolve >> resolve: aChainOfIdentifiers inScope: aScope [
	^ aChainOfIdentifiers resolveInScope: aScope currentEntity: self currentEntity 
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
