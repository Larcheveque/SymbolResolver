Class {
	#name : #SRReferencesSolverTest,
	#superclass : #TestCase,
	#instVars : [
		'referencesSolver'
	],
	#category : #'SymbolResolver-Tests'
}

{ #category : #running }
SRReferencesSolverTest >> setUp [
	referencesSolver := SRReferencesSolver new
]

{ #category : #tests }
SRReferencesSolverTest >> testCreateScopeManager [
	| scopeManager |
	scopeManager := referencesSolver createScopeManager.
	
	self assert: scopeManager class equals: SRScopeManager.
	self assert: scopeManager associatedSolver equals: referencesSolver
]

{ #category : #tests }
SRReferencesSolverTest >> testCurrentEntity [
	self fail
]

{ #category : #tests }
SRReferencesSolverTest >> testDefineAliasInCurrentScopeFor [
	self fail
]

{ #category : #tests }
SRReferencesSolverTest >> testPopScope [
	| sizeBefore scope |
	sizeBefore := referencesSolver scopes size.
	scope := SRScope new.
	referencesSolver pushScope: scope.
	self assert: referencesSolver scopes size equals: sizeBefore + 1.
	
	referencesSolver popScope.
	self assert: referencesSolver scopes size equals: sizeBefore
]

{ #category : #tests }
SRReferencesSolverTest >> testPushEntitiesAsScope [
	| entities |
	entities := { Object new. Object new. Object new }.
	
	referencesSolver pushEntitiesAsScope: entities.
	
	self assert: referencesSolver scopes first class equals: SRCollectionScope.
	self assert: referencesSolver scopes first reachableEntitiesOwned equals: entities.
]

{ #category : #tests }
SRReferencesSolverTest >> testPushEntityAsScope [
	| entity |
	entity := Object new.
	
	referencesSolver pushEntityAsScope: entity.
	
	self assert: referencesSolver scopes first class equals: SREntityScope.
	self assert: referencesSolver scopes first entity equals: entity.
]

{ #category : #tests }
SRReferencesSolverTest >> testPushScope [
	| scope |
	scope := SRScope new.
	referencesSolver pushScope: scope.
	
	self assert: referencesSolver scopes first equals: scope
]

{ #category : #tests }
SRReferencesSolverTest >> testRemoveScope [
	| scopesCount scope1 scope2 scope3 |
	scopesCount := referencesSolver scopes size.
	scope1 := SRScope new.
	scope2 := SRScope new.
	scope3 := SRScope new.
	referencesSolver pushScope: scope1.
	referencesSolver pushScope: scope2.
	referencesSolver pushScope: scope3.
	
	self assert: referencesSolver scopes size equals: scopesCount + 3.
	self assert: referencesSolver scopes first equals: scope3.
	self assert: referencesSolver scopes allButFirst first equals: scope2.
	self assert: (referencesSolver scopes allButFirst: 2) first equals: scope1.
	
	referencesSolver removeScope: scope2.
	
	self assert: referencesSolver scopes size equals: scopesCount + 2.
	self assert: referencesSolver scopes first equals: scope3.
	self assert: referencesSolver scopes allButFirst first equals: scope1
]

{ #category : #tests }
SRReferencesSolverTest >> testResolve [
	self fail
]

{ #category : #tests }
SRReferencesSolverTest >> testResolveInScope [
	self fail
]

{ #category : #tests }
SRReferencesSolverTest >> testTopScopeReachableEntities [
	self fail
]
