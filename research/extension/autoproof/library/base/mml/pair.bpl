// Pairs.

// Pair type
type Pair G H;

// Constructor
function Pair#Make<G, H>(G, H): Pair G H;
// Left component
function Pair#Left<G, H>(Pair G H): G;
// Right component
function Pair#Right<G, H>(Pair G H): H;

axiom (forall<G, H> x: G, y: H :: { Pair#Left(Pair#Make(x, y)) } Pair#Left(Pair#Make(x, y)) == x);
axiom (forall<G, H> x: G, y: H :: { Pair#Right(Pair#Make(x, y)) } Pair#Right(Pair#Make(x, y)) == y);

// Are two pairs equal?
function Pair#Equal<G, H>(p: Pair G H, q: Pair G H): bool
{ Pair#Left(p) == Pair#Left(q) && Pair#Right(p) == Pair#Right(q) }
axiom(forall<G, H> p: Pair G H, q: Pair G H :: { Pair#Equal(p, q) }  // extensionality axiom for pairs
  Pair#Equal(p, q) ==> p == q);  

// Type properties

function {: inline } Pair#LeftType<T>(heap: HeapType, p: Pair ref T, t: Type): bool 
{ detachable(heap, Pair#Left(p), t) }  

function {: inline } Pair#RightType<T>(heap: HeapType, p: Pair T ref, t: Type): bool 
{ detachable(heap, Pair#Right(p), t) }  
