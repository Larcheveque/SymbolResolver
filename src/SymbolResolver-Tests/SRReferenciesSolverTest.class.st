Class {
	#name : #SRReferenciesSolverTest,
	#superclass : #TestCase,
	#instVars : [
		'referenciesSolver'
	],
	#category : #'SymbolResolver-Tests'
}

{ #category : #running }
SRReferenciesSolverTest >> setUp [
	referenciesSolver := SRReferenciesSolver new
]

{ #category : #tests }
SRReferenciesSolverTest >> testCreateScopeManager [
	| scopeManager |
	scopeManager := referenciesSolver createScopeManager.
	
	self assert: scopeManager class equals: SRScopeManager.
	self assert: scopeManager associatedSolver equals: referenciesSolver
]

{ #category : #tests }
SRReferenciesSolverTest >> testCurrentEntity [
	self fail
]

{ #category : #tests }
SRReferenciesSolverTest >> testDefineAliasInCurrentScopeFor [
	self fail
]

{ #category : #tests }
SRReferenciesSolverTest >> testPopScope [
	| sizeBefore scope |
	sizeBefore := referenciesSolver scopes size.
	scope := SRScope new.
	referenciesSolver pushScope: scope.
	self assert: referenciesSolver scopes size equals: sizeBefore + 1.
	
	referenciesSolver popScope.
	self assert: referenciesSolver scopes size equals: sizeBefore
]

{ #category : #tests }
SRReferenciesSolverTest >> testPushEntitiesAsScope [
	| entities |
	entities := { Object new. Object new. Object new }.
	
	referenciesSolver pushEntitiesAsScope: entities.
	
	self assert: referenciesSolver scopes first class equals: SRCollectionScope.
	self assert: referenciesSolver scopes first reachableEntitiesOwned equals: entities.
]

{ #category : #tests }
SRReferenciesSolverTest >> testPushEntityAsScope [
	| entity |
	entity := Object new.
	
	referenciesSolver pushEntityAsScope: entity.
	
	self assert: referenciesSolver scopes first class equals: SREntityScope.
	self assert: referenciesSolver scopes first entity equals: entity.
]

{ #category : #tests }
SRReferenciesSolverTest >> testPushScope [
	| scope |
	scope := SRScope new.
	referenciesSolver pushScope: scope.
	
	self assert: referenciesSolver scopes first equals: scope
]

{ #category : #tests }
SRReferenciesSolverTest >> testRemoveScope [
	| scopesCount scope1 scope2 scope3 |
	scopesCount := referenciesSolver scopes size.
	scope1 := SRScope new.
	scope2 := SRScope new.
	scope3 := SRScope new.
	referenciesSolver pushScope: scope1.
	referenciesSolver pushScope: scope2.
	referenciesSolver pushScope: scope3.
	
	self assert: referenciesSolver scopes size equals: scopesCount + 3.
	self assert: referenciesSolver scopes first equals: scope3.
	self assert: referenciesSolver scopes allButFirst first equals: scope2.
	self assert: (referenciesSolver scopes allButFirst: 2) first equals: scope1.
	
	referenciesSolver removeScope: scope2.
	
	self assert: referenciesSolver scopes size equals: scopesCount + 2.
	self assert: referenciesSolver scopes first equals: scope3.
	self assert: referenciesSolver scopes allButFirst first equals: scope1
]

{ #category : #tests }
SRReferenciesSolverTest >> testResolve [
	self fail
]

{ #category : #tests }
SRReferenciesSolverTest >> testResolveInScope [
	self fail
]

{ #category : #tests }
SRReferenciesSolverTest >> testTopScopeReachableEntities [
	self fail
]
