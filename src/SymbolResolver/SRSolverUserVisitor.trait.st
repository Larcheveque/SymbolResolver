"
I am a trait for visitors that are using a solver
"
Trait {
	#name : #SRSolverUserVisitor,
	#instVars : [
		'solver',
		'errorReport'
	],
	#category : #SymbolResolver
}

{ #category : #accessing }
SRSolverUserVisitor >> currentEntity [
	^ self solver currentEntity
]

{ #category : #accessing }
SRSolverUserVisitor >> currentEntity: anEntity [
	^ self solver pushScope: (SREntityScope currentEntity: anEntity)
]

{ #category : #alias }
SRSolverUserVisitor >> defineAliasInCurrentScope: anAlias for: aBlockClosure [
	^ self solver defineAliasInCurrentScope: anAlias for: aBlockClosure
]

{ #category : #accessing }
SRSolverUserVisitor >> errorReport [
	errorReport ifNil: [ errorReport := SRParsingReport new ].
	^ errorReport
]

{ #category : #accessing }
SRSolverUserVisitor >> errorReport: anObject [
	errorReport := anObject
]

{ #category : #initialization }
SRSolverUserVisitor >> initialiseSolver [
	solver := SRReferenciesSolver new
]

{ #category : #scope }
SRSolverUserVisitor >> popScope [
	^ self solver popScope
]

{ #category : #scope }
SRSolverUserVisitor >> pushEntitiesAsScope: aCollectionOfEntities [
	self solver pushEntitiesAsScope: aCollectionOfEntities
]

{ #category : #scope }
SRSolverUserVisitor >> pushEntityAsScope: anEntity [
	self solver pushEntityAsScope: anEntity
]

{ #category : #resolution }
SRSolverUserVisitor >> resolve: identifiers [
	self solver resolve: identifiers
]

{ #category : #resolution }
SRSolverUserVisitor >> resolveSilently: identifiers [
	[ self resolve: identifiers ]
		on: SRReferenciesInconsistencies , SRReferenciesNotFound
		do: [ :err |  self errorReport addError: err ]
]

{ #category : #accessing }
SRSolverUserVisitor >> solver [
	^ solver
]

{ #category : #accessing }
SRSolverUserVisitor >> topScopeReachableEntities [
	^ self solver topScopeReachableEntities
]

{ #category : #scope }
SRSolverUserVisitor >> useCurrentEntity: anEntity during: aBlock [
	"Here we are not testing that we remove the right scope but if it's not the case, it's probably a bug"

	| entityScope |
	entityScope := self currentEntity: anEntity.
	aBlock value.
	"This assert is to check that the good scope is poped"
	self assert: self solver topScope = entityScope.
	self popScope.
	^ anEntity
]