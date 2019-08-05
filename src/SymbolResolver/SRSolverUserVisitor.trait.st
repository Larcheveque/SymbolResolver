"
I am a trait for visitors that are using a solver
"
Trait {
	#name : #SRSolverUserVisitor,
	#instVars : [
		'solver',
		'errorReport'
	],
	#category : #'SymbolResolver-Core'
}

{ #category : #'entities creation' }
SRSolverUserVisitor >> create: aClass [
	^ aClass new
		mooseModel: self model;
		yourself
]

{ #category : #'entities creation' }
SRSolverUserVisitor >> create: aClass from: anASTNode [
	| created |
	created := self create: aClass.
	created
		sourceAnchor:
			((self create: FamixPWBIndexedFileAnchor)
				startPos: anASTNode startPosition;
				fileName: (self file relativeTo: self model rootFolder) pathString;
				endPos: anASTNode stopPosition;
				yourself).
	^ created
]

{ #category : #'entities creation' }
SRSolverUserVisitor >> createAssociation: aClass [
	^ aClass new
		mooseModel: self model;
		yourself
]

{ #category : #'entities creation' }
SRSolverUserVisitor >> createAssociation: aClass from: anASTNode [
	| created |
	created := self createAssociation: aClass.
	created
		sourceAnchor:
			(FamixPWBIndexedFileAnchor new
				startPos: anASTNode startPosition;
				mooseModel: self model;
				fileName: (self file relativeTo: self model rootFolder) pathString;
				endPos: anASTNode stopPosition;
				yourself).
	^ created
]

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
SRSolverUserVisitor >> initialiseFutureSolver [
	solver := SRFutureReferencesSolver new
]

{ #category : #initialization }
SRSolverUserVisitor >> initialiseSolver [
	solver := SRReferencesSolver new
]

{ #category : #scope }
SRSolverUserVisitor >> popScope [
	^ self solver popScope
]

{ #category : #scope }
SRSolverUserVisitor >> pushAsScopeAll: aType ofModel: aModel [ 
	self solver pushAsScopeAll: aType ofModel: aModel 
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
SRSolverUserVisitor >> resolve: identifiers onNotFoundDo: aBlock [
	^ [ self solver resolve: identifiers ]
		on: SRReferencesNotFound
		do: [ aBlock value: identifiers ]
]

{ #category : #resolution }
SRSolverUserVisitor >> resolveSilently: identifiers [
	self errorReport
		catch: SRReferencesInconsistencies , SRReferencesNotFound
		during: [ self resolve: identifiers ]
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

{ #category : #scope }
SRSolverUserVisitor >> useEntityNamed: aName ofType: aType during: aBlock [
	^ self
		useCurrentEntity:
			((self model entityStorage selectAllWithType: aType)
				detect: [ :entity | entity name = aName ])
		during: aBlock
]
