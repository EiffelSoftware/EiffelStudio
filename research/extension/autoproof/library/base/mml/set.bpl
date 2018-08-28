// Finite sets.
// (Originally from Dafny Prelude: Copyright (c) Microsoft)

// Set type
type Set T = [T]bool;

// Cardinality
function Set#Card<T>(Set T): int;
axiom (forall<T> s: Set T :: { Set#Card(s) } 0 <= Set#Card(s));

// Empty set
function Set#Empty<T>(): Set T;
axiom (forall<T> o: T :: { Set#Empty()[o] } !Set#Empty()[o]);
axiom (forall<T> s: Set T :: { Set#Card(s) }
  (Set#Card(s) == 0 <==> s == Set#Empty()));// &&
  // (Set#Card(s) != 0 ==> (exists x: T :: s[x])));
axiom (forall<T> f: Field (Set T) :: { Default(f) } Default(f) == Set#Empty() : Set T);  

// Singleton set  
function Set#Singleton<T>(T): Set T;
axiom (forall<T> r: T :: { Set#Singleton(r) } Set#Singleton(r)[r]);
axiom (forall<T> r: T, o: T :: { Set#Singleton(r)[o] } Set#Singleton(r)[o] <==> r == o);
axiom (forall<T> r: T :: { Set#Card(Set#Singleton(r)) } Set#Card(Set#Singleton(r)) == 1);
axiom (forall<T> s: Set T, x: T :: { Set#Singleton(x), Set#Card(s) } Set#Card(s) == 1 && s[x]  ==>  s == Set#Singleton(x));

// Is a set empty?
function {: inline } Set#IsEmpty<T>(s: Set T): bool
{ Set#Equal(s, Set#Empty()) }

// An arbitrary element of a nonempty set
function Set#AnyItem<T>(Set T): T;
axiom (forall<T> s: Set T :: { Set#AnyItem(s) } 
  !Set#IsEmpty(s) ==> s[Set#AnyItem(s)]);
  
// Are two sets equal?  
function Set#Equal<T>(Set T, Set T): bool;
axiom(forall<T> a: Set T, b: Set T :: { Set#Equal(a,b) }
  Set#Equal(a,b) <==> (forall o: T :: {a[o]} {b[o]} a[o] <==> b[o]));
axiom(forall<T> a: Set T, b: Set T :: { Set#Equal(a,b) }  // extensionality axiom for sets
  Set#Equal(a,b) ==> a == b);  
  
// Is a subset of b?
function Set#Subset<T>(Set T, Set T): bool;
axiom(forall<T> a: Set T, b: Set T :: { Set#Subset(a,b) }
  Set#Subset(a,b) <==> (forall o: T :: {a[o]} {b[o]} a[o] ==> b[o]));
axiom(forall<T> a: Set T, b: Set T :: { Set#Subset(a,b), Set#Card(a) }{ Set#Subset(a,b), Set#Card(b) }
  Set#Subset(a,b) ==> Set#Card(a) <= Set#Card(b));
  
  
// Is a superset of b?
function {: inline } Set#Superset<T>(a: Set T, b: Set T): bool
{ Set#Subset(b, a) }

// Are a and b disjoint?
function Set#Disjoint<T>(Set T, Set T): bool;
axiom (forall<T> a: Set T, b: Set T :: { Set#Disjoint(a,b) }
  Set#Disjoint(a,b) <==> (forall o: T :: {a[o]} {b[o]} !a[o] || !b[o]));
  
// Set extended with one element  
function Set#Extended<T>(Set T, T): Set T;
axiom (forall<T> a: Set T, x: T, o: T :: { Set#Extended(a,x)[o] }
  Set#Extended(a,x)[o] <==> o == x || a[o]);
axiom (forall<T> a: Set T, x: T :: { Set#Extended(a, x) }
  Set#Extended(a, x)[x]);
axiom (forall<T> a: Set T, x: T, y: T :: { Set#Extended(a, x), a[y] }
  a[y] ==> Set#Extended(a, x)[y]);
axiom (forall<T> a: Set T, x: T :: { Set#Card(Set#Extended(a, x)) }
  a[x] ==> Set#Card(Set#Extended(a, x)) == Set#Card(a));  
axiom (forall<T> a: Set T, x: T :: { Set#Card(Set#Extended(a, x)) }
  !a[x] ==> Set#Card(Set#Extended(a, x)) == Set#Card(a) + 1);    
  
// Set with one element removed
function Set#Removed<T>(Set T, T): Set T;
axiom (forall<T> a: Set T, x: T, o: T :: { Set#Removed(a,x)[o] }
  Set#Removed(a,x)[o] <==> o != x && a[o]);
axiom (forall<T> a: Set T, x: T :: { Set#Removed(a, x) }
  !Set#Removed(a, x)[x]);
// axiom (forall<T> a: Set T, x: T, y: T :: { Set#Removed(a, x), a[y] }
  // Set#Removed(a, x)[y] ==> a[y]);
axiom (forall<T> a: Set T, x: T :: { Set#Card(Set#Removed(a, x)) }
  a[x] ==> Set#Card(Set#Removed(a, x)) == Set#Card(a) - 1);  
axiom (forall<T> a: Set T, x: T :: { Set#Card(Set#Removed(a, x)) }
  !a[x] ==> Set#Card(Set#Removed(a, x)) == Set#Card(a));

// Union of two sets
function Set#Union<T>(Set T, Set T): Set T;
axiom (forall<T> a: Set T, b: Set T, o: T :: { Set#Union(a,b)[o] }
  Set#Union(a,b)[o] <==> a[o] || b[o]);
axiom (forall<T> a, b: Set T, y: T :: { Set#Union(a, b), a[y] }
  a[y] ==> Set#Union(a, b)[y]);
axiom (forall<T> a, b: Set T, y: T :: { Set#Union(a, b), b[y] }
  b[y] ==> Set#Union(a, b)[y]);
axiom (forall<T> a, b: Set T :: { Set#Union(a, b) }
  Set#Disjoint(a, b) ==>
    Set#Difference(Set#Union(a, b), a) == b &&
    Set#Difference(Set#Union(a, b), b) == a);

// Intersection of two sets    
function Set#Intersection<T>(Set T, Set T): Set T;
axiom (forall<T> a: Set T, b: Set T, o: T :: { Set#Intersection(a,b)[o] }
  Set#Intersection(a,b)[o] <==> a[o] && b[o]);
axiom (forall<T> a, b: Set T :: { Set#Union(Set#Union(a, b), b) }
  Set#Union(Set#Union(a, b), b) == Set#Union(a, b));
axiom (forall<T> a, b: Set T :: { Set#Union(a, Set#Union(a, b)) }
  Set#Union(a, Set#Union(a, b)) == Set#Union(a, b));
axiom (forall<T> a, b: Set T :: { Set#Intersection(Set#Intersection(a, b), b) }
  Set#Intersection(Set#Intersection(a, b), b) == Set#Intersection(a, b));
axiom (forall<T> a, b: Set T :: { Set#Intersection(a, Set#Intersection(a, b)) }
  Set#Intersection(a, Set#Intersection(a, b)) == Set#Intersection(a, b));
axiom (forall<T> a, b: Set T :: { Set#Card(Set#Union(a, b)) }{ Set#Card(Set#Intersection(a, b)) }
  Set#Card(Set#Union(a, b)) + Set#Card(Set#Intersection(a, b)) == Set#Card(a) + Set#Card(b));

// Set a with all elements from b removed
function Set#Difference<T>(Set T, Set T): Set T;
axiom (forall<T> a: Set T, b: Set T, o: T :: { Set#Difference(a,b)[o] }
  Set#Difference(a,b)[o] <==> a[o] && !b[o]);
axiom (forall<T> a, b: Set T, y: T :: { Set#Difference(a, b), b[y] }
  b[y] ==> !Set#Difference(a, b)[y] );
axiom (forall<T> a, b: Set T ::
  { Set#Card(Set#Difference(a, b)) }
  Set#Card(Set#Difference(a, b)) + Set#Card(Set#Difference(b, a)) 
  + Set#Card(Set#Intersection(a, b))
    == Set#Card(Set#Union(a, b)) &&
  Set#Card(Set#Difference(a, b)) == Set#Card(a) - Set#Card(Set#Intersection(a, b)));
axiom (forall<T> a: Set T :: { Set#Difference(a,Set#Empty()) }
  Set#Equal(Set#Difference(a,Set#Empty()), a));

// Symmetric difference of two sets  
function Set#SymDifference<T>(a: Set T, b: Set T): Set T
{ Set#Union(Set#Difference(a, b), Set#Difference(b, a)) }


function Set#Min<T>(Set T): T;
axiom (forall s: Set int :: { Set#Min(s) } 
  !Set#IsEmpty(s) ==> s[Set#Min(s)] && (forall x: int :: s[x] ==> x >= Set#Min(s)));

function Set#Max<T>(Set T): T;
axiom (forall s: Set int :: { Set#Max(s) } 
  !Set#IsEmpty(s) ==> s[Set#Max(s)] && (forall x: int :: s[x] ==> x <= Set#Max(s)));
  
function Set#NonNull(s: Set ref): bool
{ (forall x: ref :: { s[x] } s[x] ==> x != Void) }
  
// Type property
function {: inline } Set#ItemsType(heap: HeapType, s: Set ref, t: Type): bool 
{ (forall o: ref :: { s[o] } s[o] ==> detachable(heap, o, t)) }
    
// Integer intervals
type Interval = Set int;

// Interval [l, u]
function Interval#FromRange(int, int): Interval;
axiom (forall l, u: int :: { Set#Card(Interval#FromRange(l, u)) }
  (u < l ==> Set#Card(Interval#FromRange(l, u)) == 0) &&
  (l <= u ==> Set#Card(Interval#FromRange(l, u)) == u - l + 1));
axiom (forall l, u, x: int :: { Interval#FromRange(l, u)[x] }
  Interval#FromRange(l, u)[x] <==> l <= x && x <= u);  
