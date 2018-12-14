"
I am a class that can solve referencies and is able to give you the current entity for your visit
"
Class {
	#name : #SRReferenciesSolver,
	#superclass : #Object,
	#instVars : [
		'scopes'
	],
	#category : #SymbolResolver
}

{ #category : #manager }
SRReferenciesSolver >> createScopeManager [
	^ SRScopeManager newAssociatedToSolver: self
]

{ #category : #accessing }
SRReferenciesSolver >> currentEntity [
	^ (self scopes detect: #hasCurrentEntity) currentEntity
]

{ #category : #alias }
SRReferenciesSolver >> defineAliasInCurrentScope: aString for: aBlockClosure [
	self topScope addAlias: aString forEntity: aBlockClosure value
]

{ #category : #initialization }
SRReferenciesSolver >> initialize [
	super initialize.
	self scopes: Stack new
]

{ #category : #'scopes management' }
SRReferenciesSolver >> popScope [
	^ self scopes pop
]

{ #category : #'scopes management' }
SRReferenciesSolver >> pushEntitiesAsScope: aCollectionOfEntities [
	self pushScope: (SRCollectionScope reachableEntities: aCollectionOfEntities)
]

{ #category : #'scopes management' }
SRReferenciesSolver >> pushEntityAsScope: anEntity [
	self pushScope: (SREntityScope entity: anEntity)
]

{ #category : #'scopes management' }
SRReferenciesSolver >> pushScope: aScope [
	^ self scopes push: aScope
]

{ #category : #detect }
SRReferenciesSolver >> reachableEntitiesFor: aScope detect: aBlockClosure ifFound: aBlockClosureAction [
	"optimisation to avoid recreate collection"

	aScope reachableEntities
		detect: aBlockClosure
		ifFound: [ :f | ^ aBlockClosureAction value: f ]
		ifNone: [ "continue" ].
	NotFound signal
]

{ #category : #removing }
SRReferenciesSolver >> removeScope: aPSQLScope [
	self scopes remove: aPSQLScope
]

{ #category : #resolution }
SRReferenciesSolver >> resolve: aChainOfIdentifiers [
	"a collection of identifier will be for example {'myTable' . 'columnA'}"
	self scopes
		do: [ :aScope | 
			[ ^ self resolve: aChainOfIdentifiers inScope: aScope ]
				on: NotFound
				do: [ "do nothing to try superior scope" ] ].
	SRReferenciesNotFound signalIdentifiers: aChainOfIdentifiers 
]

{ #category : #resolution }
SRReferenciesSolver >> resolve: aChainOfIdentifiers inScope: aScope [
	^ self
		reachableEntitiesFor: aScope
		detect: [ :entity | entity name = aChainOfIdentifiers identifier ]
		ifFound: [ :entity | 
			aChainOfIdentifiers entity: entity value.
			aChainOfIdentifiers isLast
				ifTrue: [ ^ aChainOfIdentifiers ]
				ifFalse: [ [ (self resolve: aChainOfIdentifiers next inScope: entity) ]
						on: NotFound
						do: [ SRReferenciesInconsistencies signalIdentifiers: aChainOfIdentifiers ] ] ]
]

{ #category : #accessing }
SRReferenciesSolver >> scopes [
	^ scopes
]

{ #category : #accessing }
SRReferenciesSolver >> scopes: anObject [
	scopes := anObject
]

{ #category : #accessing }
SRReferenciesSolver >> topScope [
	^ self scopes top
]

{ #category : #accessing }
SRReferenciesSolver >> topScopeReachableEntities [
	^ self topScope reachableEntities
]
