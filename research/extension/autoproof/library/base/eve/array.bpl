// ----------------------------------------------------------------------
// Arrays

// Types for array objects
const unique ARRAY#int#: Type;
const unique ARRAY#bool#: Type;
const unique ARRAY#ref#: Type;

// Fields for default attributes
const unique ARRAY.count: Field int;

// Special attribute for array content
const unique area: Field<beta> [int]beta;

// Basic functions and procedures
function fun.ARRAY.count(h: HeapType, a: ref) returns (int) {
	h[a, ARRAY.count]
}
function fun.ARRAY.is_index(h: HeapType, a: ref, i: int) returns (bool) {
	(1 <= i && i <= h[a, ARRAY.count])
}
function fun.ARRAY.item<alpha>(h: HeapType, a: ref, i: int) returns (alpha) {
	h[a, area][i]
}
procedure ARRAY.item<alpha>(a: ref, i: int) returns (result: alpha);
	requires fun.ARRAY.is_index(Heap, a, i); // pre tag:index_in_bounds
	ensures result == fun.ARRAY.item(Heap, a, i);

procedure ARRAY.put<alpha>(a: ref, item: alpha, pos: int);
	requires fun.ARRAY.is_index(Heap, a, pos); // pre tag:index_in_bounds
	ensures fun.ARRAY.item(Heap, a, pos) == item;
	ensures Heap[a, area][pos] == item;
	modifies Heap;
	ensures (forall<beta> o: ref, f: Field beta :: { Heap[o, f] } (o != a || f != area) ==> (Heap[o, f] == old(Heap)[o, f]));
	ensures (forall i: int :: { fun.ARRAY.item(Heap, a, i) } { Heap[a, area][i] } (fun.ARRAY.is_index(Heap, a, i) && i != pos) ==> fun.ARRAY.item(Heap, a, i) == old(fun.ARRAY.item(Heap, a, i)));

procedure ARRAY.make(
			c: ref where (c != Void && Heap[c, allocated]),
			l: int where is_integer_32(l),
			u: int where is_integer_32(u)
		);
	requires l == 1; // pre tag:lower_equals_1
	requires u >= 0; // pre tag:upper_not_negative
	ensures Heap[c, ARRAY.count] == u;
	ensures ARRAY.inv(Heap, c);
	modifies Heap;
	ensures (forall<beta> o: ref, f: Field beta :: ((o != c) || (f == allocated)) ==> (Heap[o, f] == old(Heap)[o, f]));

procedure ARRAY.make_filled<alpha>(
			c: ref where (c != Void && Heap[c, allocated]),
			d: alpha,
			l: int where is_integer_32(l),
			u: int where is_integer_32(u)
		);
	requires l == 1; // pre tag:lower_equals_1
	requires u >= 0; // pre tag:upper_not_negative
	ensures Heap[c, ARRAY.count] == u;
	ensures ARRAY.inv(Heap, c);
	ensures (forall i: int :: { Heap[c, area][i] } { fun.ARRAY.item(Heap, c, i) } Heap[c, area][i] == d);
	ensures (forall i: int :: { Heap[c, area][i] } { fun.ARRAY.item(Heap, c, i) } fun.ARRAY.item(Heap, c, i) == d);
	modifies Heap;
	ensures (forall<beta> o: ref, f: Field beta :: ((o != c) || (f == allocated)) ==> (Heap[o, f] == old(Heap)[o, f]));

procedure ARRAY.make_from_array(
			c: ref where (c != Void && Heap[c, allocated]),
			other: ref
		);
	requires other != Void; // pre tag:other_not_void
	requires other != c; // pre tag:other_not_current
	ensures Heap[c, ARRAY.count] == Heap[other, ARRAY.count];
	ensures ARRAY.inv(Heap, c);
	ensures (forall i: int :: { Heap[c, area][i] } { fun.ARRAY.item(Heap, c, i) } Heap[c, area][i] == Heap[other, area][i]);
	ensures (forall i: int :: { Heap[c, area][i] } { fun.ARRAY.item(Heap, c, i) } fun.ARRAY.item(Heap, c, i) == fun.ARRAY.item(Heap, other, i));
	modifies Heap;
	ensures (forall<beta> o: ref, f: Field beta :: ((o != c) || (f == allocated)) ==> (Heap[o, f] == old(Heap)[o, f]));

function fun.ARRAY.has<alpha>(h: HeapType, c: ref, val: alpha) returns (bool) {
	(exists i: int :: (fun.ARRAY.is_index(h, c, i) && (fun.ARRAY.item(h, c, i) == val)))
}

function fun.ARRAY.occurrences<alpha>(heap: HeapType, a: ref, o: alpha) returns (int) {
	occ(heap, a, o, heap[a, ARRAY.count])
}

function fun.ARRAY.is_equal(heap: HeapType, a: ref, b: ref) returns (bool) {
	(fun.ARRAY.count(heap, a) == fun.ARRAY.count(heap, b)) &&
	(forall i: int :: fun.ARRAY.is_index(heap, a, i) ==> (fun.ARRAY.item(heap, a, i) == fun.ARRAY.item(heap, b, i)))
}

function occ<alpha>(h: HeapType, a: ref, o: alpha, i: int) returns (int);
axiom (forall<alpha> h: HeapType, a: ref, o: alpha ::
			{ occ(h, a, o, 0) }
		occ(h, a, o, 0) == 0);
axiom (forall<alpha> h: HeapType, a: ref, o: alpha, i: int ::
			{ occ(h, a, o, i) }
		(h[a, area][i] == o) ==> (occ(h, a, o, i) == occ(h, a, o, i-1) + 1));
axiom (forall<alpha> h: HeapType, a: ref, o: alpha, i: int ::
			{ occ(h, a, o, i) }
		(h[a, area][i] != o) ==> (occ(h, a, o, i) == occ(h, a, o, i-1)));

procedure ARRAY.subarray(a: ref, l: int, u: int) returns (result: ref);
	requires fun.ARRAY.is_index(Heap, a, l) || fun.ARRAY.is_index(Heap, a, u); // pre tag:lower_or_upper_in_bounds
	requires (l-1) <= u && u <= fun.ARRAY.count(Heap, a); // pre tag:range_in_bounds
	ensures !old(Heap)[result, allocated];
	ensures Heap[result, ARRAY.count] == u-l+1;
	ensures attached(Heap, result, type_of(a));
	ensures ARRAY.inv(Heap, result);
	modifies Heap;
	ensures (forall i: int :: (1 <= i && i <= (u-l+1)) ==> (fun.ARRAY.item(Heap, result, i) == fun.ARRAY.item(Heap, a, l+i-1)));
	ensures (forall<beta> o: ref, f: Field beta :: (old(Heap[o, allocated])) ==> (Heap[o, f] == old(Heap[o, f])));

procedure ARRAY.subcopy(c: ref, other: ref, start: int, end: int, index: int);
	requires other != Void; // pre tag:other_not_void
	requires other != c; // pre tag:other_not_current
	requires start >= 1; // pre tag:start_greater_equal_1
	requires end <= fun.ARRAY.count(Heap, other); // pre tag:end_smaller_equal_count
	requires start <= end + 1; // pre tag:start_smaller_end_plus_1
	requires index >= 1; // pre tag:index_greater_equal_1
	requires fun.ARRAY.count(Heap, c) - index >= end - start; // pre tag:enough_space
	modifies Heap;
	ensures (forall i: int :: (start <= i && i <= end) ==> (fun.ARRAY.item(Heap, c, i - start + index) == fun.ARRAY.item(Heap, other, i)));
	ensures (forall<beta> o: ref, f: Field beta :: (o != c) ==> (Heap[o, f] == old(Heap[o, f])));

// Array invariants
function ARRAY.inv(h: HeapType, a: ref) returns (bool) {
	(a != Void) ==> (h[a, ARRAY.count] >= 0 && is_integer_32(h[a, ARRAY.count]))
}
function ARRAY#ref#.inv(h: HeapType, a: ref, ct: Type) returns (bool) {
	ARRAY.inv(h, a) &&
	(forall i: int :: fun.ARRAY.is_index(h, a, i) ==> (detachable(h, fun.ARRAY.item(h, a, i), ct)))
}
function ARRAY#int#.inv(h: HeapType, a: ref) returns (bool) {
	ARRAY.inv(h, a) &&
	(forall i: int :: fun.ARRAY.is_index(h, a, i) ==> is_integer_32(fun.ARRAY.item(h, a, i)))
}
function ARRAY#bool#.inv(h: HeapType, a: ref) returns (bool) {
	ARRAY.inv(h, a)
}
