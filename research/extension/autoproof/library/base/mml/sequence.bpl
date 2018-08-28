// Finite sequences.
// (Originally from Dafny Prelude: Copyright (c) Microsoft)

// Sequence type
type Seq T;

// Sequence length
function Seq#Length<T>(Seq T): int;
axiom (forall<T> s: Seq T :: { Seq#Length(s) } 0 <= Seq#Length(s));

// Empty sequence
function Seq#Empty<T>(): Seq T;
axiom (forall<T> :: Seq#Length(Seq#Empty(): Seq T) == 0);
axiom (forall<T> s: Seq T :: { Seq#Length(s) } Seq#Length(s) == 0 ==> s == Seq#Empty());
axiom (forall<T> f: Field (Seq T) :: { Default(f) } Default(f) == Seq#Empty() : Seq T);

// Singleton sequence
function Seq#Singleton<T>(T): Seq T;
axiom (forall<T> t: T :: { Seq#Length(Seq#Singleton(t)) } Seq#Length(Seq#Singleton(t)) == 1);

// Constant sequence
function Seq#Constant<T>(T, int): Seq T;
axiom (forall<T> t: T, n: int :: { Seq#Length(Seq#Constant(t, n)) } 
  n >= 0 ==> Seq#Length(Seq#Constant(t, n)) == n);
axiom (forall<T> t: T, n: int, i: int :: { Seq#Item(Seq#Constant(t, n), i) } 
  1 <= i && i <= n ==> Seq#Item(Seq#Constant(t, n), i) == t);
  

// Does a sequence contain a given element?
function Seq#Has<T>(s: Seq T, x: T): bool;
axiom (forall<T> s: Seq T, x: T :: { Seq#Has(s,x) }
  Seq#Has(s,x) <==>
    (exists i: int :: { Seq#Item(s,i) } 1 <= i && i <= Seq#Length(s) && Seq#Item(s,i) == x));
// axiom (forall<T> s: Seq T, i: int :: { Seq#Item(s, i) }
  // 1 <= i && i <= Seq#Length(s) ==>
    // Seq#Has(s, Seq#Item(s, i)));    
axiom (forall<T> x: T ::
  { Seq#Has(Seq#Empty(), x) }
  !Seq#Has(Seq#Empty(), x));
axiom (forall<T> x, y: T ::
  { Seq#Has(Seq#Singleton(y), x) }
  Seq#Has(Seq#Singleton(y), x) <==> x == y);  
axiom (forall<T> s0: Seq T, s1: Seq T, x: T ::
  { Seq#Has(Seq#Concat(s0, s1), x) }
  Seq#Has(Seq#Concat(s0, s1), x) <==>
    Seq#Has(s0, x) || Seq#Has(s1, x));
axiom (forall<T> s: Seq T, v: T, x: T ::
  { Seq#Has(Seq#Extended(s, v), x) }
    Seq#Has(Seq#Extended(s, v), x) <==> (v == x || Seq#Has(s, x)));
axiom (forall<T> s: Seq T, v: T, x: T ::
  { Seq#Has(Seq#Prepended(s, v), x) }
    Seq#Has(Seq#Prepended(s, v), x) <==> (v == x || Seq#Has(s, x)));    
axiom (forall<T> s: Seq T, n: int, x: T ::
  { Seq#Has(Seq#Take(s, n), x) }
  Seq#Has(Seq#Take(s, n), x) <==>
    (exists i: int :: { Seq#Item(s, i) }
      1 <= i && i <= n && i <= Seq#Length(s) && Seq#Item(s, i) == x));
axiom (forall<T> s: Seq T, n: int, x: T ::
  { Seq#Has(Seq#Drop(s, n), x) }
  Seq#Has(Seq#Drop(s, n), x) <==>
    (exists i: int :: { Seq#Item(s, i) }
      0 <= n && n + 1 <= i && i <= Seq#Length(s) && Seq#Item(s, i) == x));
axiom (forall<T> s: Seq T, n: int, x: T ::
  { Seq#Has(Seq#RemovedAt(s, n), x) }
  Seq#Has(Seq#RemovedAt(s, n), x) <==>
    (exists i: int :: { Seq#Item(s, i) }
      1 <= n && n <= Seq#Length(s) && n != i && Seq#Item(s, i) == x));
      
// Is a sequence empty?
function {: inline } Seq#IsEmpty<T>(a: Seq T): bool
{ Seq#Equal(a, Seq#Empty()) }

function Seq#IsConstant<T>(s: Seq T, x: T): bool
{ (forall i: int :: { Seq#Item(s, i) } 1 <= i && i <= Seq#Length(s) ==> Seq#Item(s, i) == x) }

// Element at a given index
function Seq#Item<T>(Seq T, int): T;
axiom (forall<T> t: T :: { Seq#Item(Seq#Singleton(t), 1) } Seq#Item(Seq#Singleton(t), 1) == t);
// axiom (forall<T> s0: Seq T, s1: Seq T, n: int :: { Seq#Item(Seq#Concat(s0,s1), n) }
  // (n <= Seq#Length(s0) ==> Seq#Item(Seq#Concat(s0,s1), n) == Seq#Item(s0, n)) &&
  // (Seq#Length(s0) < n ==> Seq#Item(Seq#Concat(s0,s1), n) == Seq#Item(s1, n - Seq#Length(s0))));
axiom (forall<T> s0: Seq T, s1: Seq T, n: int :: { Seq#Item(Seq#Concat(s0,s1), n) }
  Seq#Item(Seq#Concat(s0,s1), n) == if n <= Seq#Length(s0) then Seq#Item(s0, n) else Seq#Item(s1, n - Seq#Length(s0)));  
  
// Set of indexes
function Seq#Domain<T>(q: Seq T): Set int
{ Interval#FromRange(1, Seq#Length(q)) }

// Set of values
function Seq#Range<T>(Seq T): Set T;
axiom (forall<T> q: Seq T, o: T :: { Seq#Range(q)[o] } Seq#Has(q, o) <==> Seq#Range(q)[o]);
axiom (forall<T> s: Seq T :: { Seq#Range(s) }
  (forall i: int :: 1 <= i && i <= Seq#Length(s) ==> Seq#Range(s)[Seq#Item(s, i)]));
// axiom (forall<T> s: Seq T, i: int :: { Seq#Range(s), Seq#Item(s, i) }
  // 1 <= i && i <= Seq#Length(s) ==> Seq#Range(s)[Seq#Item(s, i)]);
  
  
// How many times does x occur in a?
function Seq#Occurrences<T>(Seq T, T): int;
axiom (forall<T> x: T :: {Seq#Occurrences(Seq#Empty(), x)} Seq#Occurrences(Seq#Empty(), x) == 0);
axiom (forall<T> a: Seq T, x: T:: {Seq#Occurrences(Seq#Extended(a, x), x)}
  Seq#Occurrences(Seq#Extended(a, x), x) == Seq#Occurrences(a, x) + 1);
axiom (forall<T> a: Seq T, x: T, y: T :: {Seq#Occurrences(Seq#Extended(a, y), x)}
  x != y ==> Seq#Occurrences(Seq#Extended(a, y), x) == Seq#Occurrences(a, x));
// axiom (forall<T> x: T:: {Seq#Occurrences(Seq#Singleton(x), x)}
  // Seq#Occurrences(Seq#Singleton(x), x) == 1);
// axiom (forall<T> x: T, y: T :: {Seq#Occurrences(Seq#Singleton(x), y)}
  // x != y ==> Seq#Occurrences(Seq#Singleton(x), y) == 0);  
 // axiom (forall<T> a: Seq T, x: T :: {Seq#Occurrences(a, x)}
  // !Seq#Has(a, x) ==> Seq#Occurrences(a, x) == 0);
  
function Seq#IndexOf<T>(Seq T, T): int;
axiom (forall<T> s: Seq T, x: T :: { Seq#IndexOf(s,x) }
  Seq#Has(s,x) ==> 1 <= Seq#IndexOf(s,x) && Seq#IndexOf(s,x) <= Seq#Length(s) && Seq#Item(s, Seq#IndexOf(s,x)) == x);
axiom (forall<T> s: Seq T, x: T :: { Seq#IndexOf(s,x) }
  !Seq#Has(s,x) ==> Seq#IndexOf(s,x) < 1 || Seq#Length(s) < Seq#IndexOf(s,x));

// Are two sequences equal?  
function Seq#Equal<T>(Seq T, Seq T): bool;
axiom (forall<T> s0: Seq T, s1: Seq T :: { Seq#Equal(s0,s1) }
  Seq#Equal(s0,s1) <==>
    Seq#Length(s0) == Seq#Length(s1) &&
    (forall j: int :: { Seq#Item(s0,j) } { Seq#Item(s1,j) }
        1 <= j && j <= Seq#Length(s0) ==> Seq#Item(s0,j) == Seq#Item(s1,j)));
axiom (forall<T> a: Seq T, b: Seq T :: { Seq#Equal(a,b) }  // extensionality axiom for sequences
  Seq#Equal(a,b) ==> a == b);
  
// Is q0 a prefix of q1?  
function {: inline } Seq#Prefix<T>(q0: Seq T, q1: Seq T): bool
{ Seq#Equal(q0, Seq#Take(q1, Seq#Length(q0))) }

// Is |q0| <= |q1|?
function {: inline } Seq#LessEqual<T>(q0: Seq T, q1: Seq T): bool
{ Seq#Length(q0) <= Seq#Length(q1) }

// Prefix of length how_many
function Seq#Take<T>(s: Seq T, howMany: int): Seq T;
axiom (forall<T> s: Seq T, n: int :: { Seq#Length(Seq#Take(s,n)) }
  // (n < 0 ==> Seq#Length(Seq#Take(s,n)) == 0) &&
  // (n <= Seq#Length(s) ==> Seq#Length(Seq#Take(s,n)) == n) &&
  // (Seq#Length(s) < n ==> Seq#Length(Seq#Take(s,n)) == Seq#Length(s)));
  0 <= n ==>
    (n <= Seq#Length(s) ==> Seq#Length(Seq#Take(s,n)) == n) &&
    (Seq#Length(s) < n ==> Seq#Length(Seq#Take(s,n)) == Seq#Length(s)));  
axiom (forall<T> s: Seq T, n: int, j: int :: { Seq#Item(Seq#Take(s,n), j) } {:weight 25}
  1 <= j && j <= n && j <= Seq#Length(s) ==>
    Seq#Item(Seq#Take(s,n), j) == Seq#Item(s, j));
// axiom (forall<T> s: Seq T, n: int :: {Seq#Take(s,n)}
  // (n < 0 ==> Seq#Take(s,n) == Seq#Empty() : Seq T) &&
  // (n >= Seq#Length(s) ==> Seq#Take(s,n) == s));

// Sequence without its prefix of length howMany    
function Seq#Drop<T>(s: Seq T, howMany: int): Seq T;
axiom (forall<T> s: Seq T, n: int :: { Seq#Length(Seq#Drop(s,n)) }
  // (n < 0 ==> Seq#Length(Seq#Drop(s,n)) == Seq#Length(s)) &&
  // (n <= Seq#Length(s) ==> Seq#Length(Seq#Drop(s,n)) == Seq#Length(s) - n) &&
  // (Seq#Length(s) < n ==> Seq#Length(Seq#Drop(s,n)) == 0));
  0 <= n ==>
    (n <= Seq#Length(s) ==> Seq#Length(Seq#Drop(s,n)) == Seq#Length(s) - n) &&
    (Seq#Length(s) < n ==> Seq#Length(Seq#Drop(s,n)) == 0));
axiom (forall<T> s: Seq T, n: int, j: int :: { Seq#Item(Seq#Drop(s,n), j) } {:weight 25}
  0 <= n && 1 <= j && j <= Seq#Length(s)-n ==> 
    Seq#Item(Seq#Drop(s,n), j) == Seq#Item(s, j+n));
// axiom (forall<T> s: Seq T, n: int :: {Seq#Drop(s,n)}
  // (n < 0 ==> Seq#Drop(s,n) == s) &&
  // (n >= Seq#Length(s) ==> Seq#Drop(s,n) == Seq#Empty() : Seq T));  

// First element
function {: inline } Seq#First<T>(q: Seq T): T
{ Seq#Item(q, 1) } 

// Last element
function {: inline } Seq#Last<T>(q: Seq T): T
{ Seq#Item(q, Seq#Length(q)) } 

// Sequence with the first element removed
function {: inline } Seq#ButFirst<T>(q: Seq T): Seq T
{ Seq#Drop(q, 1) } 

// Sequence with the last element removed
function {: inline } Seq#ButLast<T>(q: Seq T): Seq T
{ Seq#Take(q, Seq#Length(q) - 1) } 

// Prefix until upper
function Seq#Front<T>(q: Seq T, upper: int): Seq T
// { Seq#Take(q, upper) }
{ if 0 <= upper then Seq#Take(q, upper) else Seq#Empty() : Seq T } 
axiom (forall<T> q: Seq T :: { Seq#Front(q, Seq#Length(q)) } Seq#Front(q, Seq#Length(q)) == q);

// Suffix from lower
function Seq#Tail<T>(q: Seq T, lower: int): Seq T
// { Seq#Drop(q, lower - 1) }
{ if 1 <= lower then Seq#Drop(q, lower - 1) else q } 
axiom (forall<T> q: Seq T :: { Seq#Tail(q, 1) } Seq#Tail(q, 1) == q);

// Subsequence from lower to upper
function Seq#Interval<T>(q: Seq T, lower: int, upper: int): Seq T
{ Seq#Tail(Seq#Front(q, upper), lower) }

// Sequence with element at position i removed
// function {: inline } Seq#RemovedAt<T>(q: Seq T, i: int): Seq T
// { Seq#Concat(Seq#Take(q, i - 1), Seq#Drop(q, i)) } 
function Seq#RemovedAt<T>(q: Seq T, i: int): Seq T;
axiom (forall<T> q: Seq T, i: int :: { Seq#Length(Seq#RemovedAt(q, i)) }
	Seq#Length(Seq#RemovedAt(q, i)) == Seq#Length(q) - 1);
axiom (forall<T> q: Seq T, i: int, j: int :: { Seq#Item(Seq#RemovedAt(q, i), j) }
	(j < i ==> Seq#Item(Seq#RemovedAt(q, i), j) == Seq#Item(q, j)) &&
	(i <= j ==> Seq#Item(Seq#RemovedAt(q, i), j) == Seq#Item(q, j + 1)));

// Sequence extended with x at the end
function Seq#Extended<T>(s: Seq T, val: T): Seq T;
axiom (forall<T> s: Seq T, v: T :: { Seq#Length(Seq#Extended(s,v)) }
  Seq#Length(Seq#Extended(s,v)) == 1 + Seq#Length(s));
axiom (forall<T> s: Seq T, i: int, v: T :: { Seq#Item(Seq#Extended(s,v), i) }
  (i == Seq#Length(s) + 1 ==> Seq#Item(Seq#Extended(s,v), i) == v) &&
  (i <= Seq#Length(s) ==> Seq#Item(Seq#Extended(s,v), i) == Seq#Item(s, i)));
  
// Sequence with x inserted at position i
function {: inline } Seq#ExtendedAt<T>(s: Seq T, i: int, val: T): Seq T
{
  Seq#Concat (Seq#Extended(Seq#Take(s, i - 1), val), Seq#Drop(s, i - 1))
}
axiom (forall<T> s: Seq T, i: int, val: T :: { Seq#Length(Seq#ExtendedAt(s, i, val)) }
	Seq#Length(Seq#ExtendedAt(s, i, val)) == Seq#Length(s) + 1);

// Sequence prepended with x at the beginning
function Seq#Prepended<T>(s: Seq T, val: T): Seq T;
// {
  // Seq#Concat (Seq#Singleton(val), s)
// }
axiom (forall<T> s: Seq T, v: T :: { Seq#Length(Seq#Prepended(s, v)) }
	Seq#Length(Seq#Prepended(s, v)) == Seq#Length(s) + 1);    
axiom (forall<T> s: Seq T, v: T, i: int :: { Seq#Item(Seq#Prepended(s, v), i) }
  (2 <= i && i <= Seq#Length(s) + 1 ==> Seq#Item(Seq#Prepended(s, v), i) == Seq#Item(s, i - 1)) &&
  (i == 1 ==> Seq#Item(Seq#Prepended(s, v), 1) == v));
  
// Concatenation of two sequences
function Seq#Concat<T>(Seq T, Seq T): Seq T;
axiom (forall<T> s0: Seq T, s1: Seq T :: { Seq#Length(Seq#Concat(s0,s1)) }
  Seq#Length(Seq#Concat(s0,s1)) == Seq#Length(s0) + Seq#Length(s1));

// Sequence with x at position i.
function Seq#Update<T>(Seq T, int, T): Seq T;
axiom (forall<T> s: Seq T, i: int, v: T :: { Seq#Length(Seq#Update(s,i,v)) }
  1 <= i && i <= Seq#Length(s) ==> Seq#Length(Seq#Update(s,i,v)) == Seq#Length(s));
axiom (forall<T> s: Seq T, i: int, v: T, n: int :: { Seq#Item(Seq#Update(s,i,v),n) }
  1 <= n && n <= Seq#Length(s) ==>
    (i == n ==> Seq#Item(Seq#Update(s,i,v),n) == v) &&
    (i != n ==> Seq#Item(Seq#Update(s,i,v),n) == Seq#Item(s,n)));
    
// Sequence converted to a bag
function Seq#ToBag<T>(Seq T): Bag T;
axiom (forall<T> s: Seq T :: { Seq#ToBag(s) } Bag#IsValid(Seq#ToBag(s)));
// building axiom
axiom (forall<T> s: Seq T, v: T ::
  { Seq#ToBag(Seq#Extended(s, v)) }
    Seq#ToBag(Seq#Extended(s, v)) == Bag#Extended(Seq#ToBag(s), v)
  );
axiom (forall<T> :: Seq#ToBag(Seq#Empty(): Seq T) == Bag#Empty(): Bag T);
axiom (forall<T> s: Seq T :: { Bag#Card(Seq#ToBag(s)) }
  Bag#Card(Seq#ToBag(s)) == Seq#Length(s));

// concatenation axiom
axiom (forall<T> a: Seq T, b: Seq T, x: T ::
  { Seq#ToBag(Seq#Concat(a, b))[x] }
    Seq#ToBag(Seq#Concat(a, b))[x] == Seq#ToBag(a)[x] + Seq#ToBag(b)[x] );
    
// update axiom
axiom (forall<T> s: Seq T, i: int, v: T, x: T ::
  { Seq#ToBag(Seq#Update(s, i, v))[x] }
    1 <= i && i <= Seq#Length(s) ==>
    Seq#ToBag(Seq#Update(s, i, v))[x] ==
      Bag#Extended(Bag#Difference(Seq#ToBag(s), Bag#Singleton(Seq#Item(s,i))), v)[x] );
  // i.e. MS(Update(s, i, v)) == MS(s) - {{s[i]}} + {{v}}
axiom (forall<T> s: Seq T, x: T :: { Seq#ToBag(s)[x] } Seq#Has(s, x) <==> 0 < Seq#ToBag(s)[x]);
axiom (forall<T> s: Seq T, x: T :: { Seq#ToBag(s)[x] } Seq#ToBag(s)[x] == Seq#Occurrences(s, x));

// removed axiom
axiom (forall<T> s: Seq T, i: int :: { Seq#ToBag(Seq#RemovedAt(s, i)) }
  1 <= i && i <= Seq#Length(s) ==> Seq#ToBag(Seq#RemovedAt(s, i)) == Bag#Difference(Seq#ToBag(s), Bag#Singleton(Seq#Item(s,i))));
// prepend axiom
axiom (forall<T> s: Seq T, v: T :: { Seq#ToBag(Seq#Prepended(s, v)) }
  Seq#ToBag(Seq#Prepended(s, v)) == Bag#Extended(Seq#ToBag(s), v));

// Sequence converted to map
function Seq#ToMap<T>(Seq T): Map int T;
axiom (forall<T> s: Seq T :: { Map#Equal(Seq#ToMap(s), Map#Empty()) }
  Map#Equal(Seq#ToMap(s), Map#Empty()) <==> Seq#Equal (s, Seq#Empty() : Seq T));
axiom (forall<T> s: Seq T :: { Map#Domain(Seq#ToMap(s)) }
  Map#Domain(Seq#ToMap(s)) == Seq#Domain(s));
axiom (forall<T> s: Seq T :: { Map#Card(Seq#ToMap(s)) }
  Map#Card(Seq#ToMap(s)) == Seq#Length(s));
axiom (forall<T> s: Seq T, i: int :: { Map#Item(Seq#ToMap(s), i) }
  1 <= i && i <= Seq#Length(s) ==> Map#Item(Seq#ToMap(s), i) == Seq#Item(s, i));  
  
axiom (forall<T> s: Seq T :: { Map#ToBag(Seq#ToMap(s)) }
  Bag#Equal(Map#ToBag(Seq#ToMap(s)), Seq#ToBag(s)));  
  

// Additional axioms about common things
    
// axiom (forall<T> s, t: Seq T ::
  // { Seq#Concat(s, t) }
  // Seq#Take(Seq#Concat(s, t), Seq#Length(s)) == s &&
  // Seq#Drop(Seq#Concat(s, t), Seq#Length(s)) == t);
  

// Commutability of Take and Drop with Update.
axiom (forall<T> s: Seq T, i: int, v: T, n: int ::
  { Seq#Take(Seq#Update(s, i, v), n) }
    1 <= i && i <= n && n <= Seq#Length(s) ==> Seq#Take(Seq#Update(s, i, v), n) == Seq#Update(Seq#Take(s, n), i, v) );
axiom (forall<T> s: Seq T, i: int, v: T, n: int ::
  { Seq#Take(Seq#Update(s, i, v), n) }
    n < i && i <= Seq#Length(s) ==> Seq#Take(Seq#Update(s, i, v), n) == Seq#Take(s, n));
axiom (forall<T> s: Seq T, i: int, v: T, n: int ::
  { Seq#Drop(Seq#Update(s, i, v), n) }
    0 <= n && n + 1 <= i && i <= Seq#Length(s) ==> Seq#Drop(Seq#Update(s, i, v), n) == Seq#Update(Seq#Drop(s, n), i-n, v) );
axiom (forall<T> s: Seq T, i: int, v: T, n: int ::
  { Seq#Drop(Seq#Update(s, i, v), n) }
    1 <= i && i <= n && n < Seq#Length(s) ==> Seq#Drop(Seq#Update(s, i, v), n) == Seq#Drop(s, n));
// drop commutes with build.
axiom (forall<T> s: Seq T, v: T, n: int ::
  { Seq#Drop(Seq#Extended(s, v), n) }
    0 <= n && n <= Seq#Length(s) ==> Seq#Drop(Seq#Extended(s, v), n) == Seq#Extended(Seq#Drop(s, n), v) );

axiom (forall<T> :: Seq#Take(Seq#Empty() : Seq T, 0) == Seq#Empty() : Seq T);  // [][..0] == []
axiom (forall<T> :: Seq#Drop(Seq#Empty() : Seq T, 0) == Seq#Empty() : Seq T);  // [][0..] == []

// 2 x Take and drop
// axiom (forall<T> s: Seq T, n: int, m: int :: { Seq#Take(Seq#Take(s, n), m) }
	// (n <= m ==> Seq#Equal(Seq#Take(Seq#Take(s, n), m), Seq#Take(s, n))) &&
	// (n >= m ==> Seq#Equal(Seq#Take(Seq#Take(s, n), m), Seq#Take(s, m))));
// axiom (forall<T> s: Seq T, n: int, m: int :: { Seq#Drop(Seq#Drop(s, n), m) }
	// Seq#Equal(Seq#Drop(Seq#Drop(s, n), m), Seq#Drop(s, n + m)));

function Seq#NonNull(s: Seq ref): bool
{ (forall i: int :: { Seq#Item(s, i) } 1 <= i && i <= Seq#Length(s) ==> Seq#Item(s, i) != Void) }

function Seq#NoDuplicates<T>(s: Seq T): bool
{ (forall i, j: int :: { Seq#Item(s, i), Seq#Item(s, j) } 1 <= i && i < j && j <= Seq#Length(s) ==> Seq#Item(s, i) != Seq#Item(s, j)) }
// { (forall i, j: int :: 1 <= i && i <= Seq#Length(s) && 1 <= j && j <= ) }

// Type property
function {: inline } Seq#ItemsType(heap: HeapType, s: Seq ref, t: Type): bool 
{ (forall i: int :: { Seq#Item(s, i) } 1 <= i && i <= Seq#Length(s) ==> detachable(heap, Seq#Item(s, i), t)) }

// function Seq#IsSorted<T>(s: Seq T) returns (bool);

//axiom (forall s: Seq int, i: int ::
//    1 <= i && i < Seq#Length(s) && Seq#IsSorted(s) ==> Seq#Item(s, i) <= Seq#Item(s, i+1));
// axiom (forall s: Seq int ::
  // { Seq#IsSorted(s) }
    // Seq#IsSorted(s) ==> (forall i, j: int :: 1 <= i && i <= Seq#Length(s) && i <= j && j <= Seq#Length(s) ==> Seq#Item(s, i) <= Seq#Item(s, j)));
// axiom (forall s: Seq int ::
  // { Seq#IsSorted(s) }
    // Seq#Length(s) <= 1 ==> Seq#IsSorted(s));
// axiom (forall s: Seq int, i: int ::
    // 1 <= i && i < Seq#Length(s) && Seq#IsSorted(Seq#Front(s, i)) && Seq#Item(s, i) <= Seq#Item(s, i+1) ==> Seq#IsSorted(Seq#Front(s, i+1)));

// axiom (forall s: Seq int ::
  // { Seq#Range(s) }
    // (forall i: int, j: int ::
		// 1 <= i && i < Seq#Length(s) && 1 <= j && j < Seq#Length(s) ==>
			// Seq#Range(Seq#Update(Seq#Update(s, i, Seq#Item(s, j)), j, Seq#Item(s, i))) == Seq#Range(s)));




