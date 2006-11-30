indexing

	description:
		"Structures whose items may be accessed sequentially, one-way"

	status: "See notice at end of class"
	names: sequential, traversing;
	access: membership;
	contents: generic;
	date: "$Date$"
	revision: "$Revision$"

deferred class LINEAR [G] inherit

	TRAVERSABLE [G]
		redefine
			do_all, do_if, there_exists, for_all
		end

feature -- Access

	has (v: like item): BOOLEAN is
			-- Does structure include an occurrence of `v'?
			-- (Reference or object equality,
			-- based on `object_comparison'.)
		do
			start
			if not off then
				search (v)
			end
			Result := not exhausted
		end

	index_of (v: like item; i: INTEGER): INTEGER is
			-- Index of `i'-th occurrence of `v'.
			-- 0 if none.
			-- (Reference or object equality,
			-- based on `object_comparison'.)
		require
			positive_occurrences: i > 0
		local
			occur, pos: INTEGER
		do
			if object_comparison and v /= Void then
				from
					start
					pos := 1
				until
					off or (occur = i)
				loop
					if item /= Void and then v.is_equal (item) then
						occur := occur + 1
					end
					forth
					pos := pos + 1
				end
			else
				from
					start
					pos := 1
				until
					off or (occur = i)
				loop
					if item = v then
						occur := occur + 1
					end
					forth
					pos := pos + 1
				end
			end
			if occur = i then
				Result := pos - 1
			end
		ensure
			non_negative_result: Result >= 0
		end

	search (v: like item) is
			-- Move to first position (at or after current
			-- position) where `item' and `v' are equal.
			-- (Reference or object equality,
			-- based on `object_comparison'.)
			-- If no such position ensure that `exhausted' will be true.
		do
			if object_comparison and v /= Void then
				from
				until
					exhausted or else (item /= Void and then v.is_equal (item))
				loop
					forth
				end
			else
				from
				until
					exhausted or else v = item
				loop
					forth
				end
			end
		ensure
			object_found: (not exhausted and object_comparison)
				 implies equal (v, item)
			item_found: (not exhausted and not object_comparison)
				 implies v = item
		end

	index: INTEGER is
			-- Index of current position
		deferred
		end

	occurrences (v: G): INTEGER is
			-- Number of times `v' appears.
			-- (Reference or object equality,
			-- based on `object_comparison'.)
		do
			from
				start
				search (v)
			until
				exhausted
			loop
				Result := Result + 1
				forth
				search (v)
			end
		end

feature -- Status report

	exhausted: BOOLEAN is
			-- Has structure been completely explored?
		do
			Result := off
		ensure
			exhausted_when_off: off implies Result
		end

	after: BOOLEAN is
			-- Is there no valid position to the right of current one?
		deferred
		end

	off: BOOLEAN is
			-- Is there no current item?
		do
			Result := is_empty or after
		end

feature -- Cursor movement

	finish is
			-- Move to last position.
		deferred
		end

	forth is
			-- Move to next position; if no next position,
			-- ensure that `exhausted' will be true.
		require
			not_after: not after
		deferred
		ensure
			-- moved_forth_before_end: (not after) implies index = old index + 1
		end

feature -- Iteration

	do_all (action: PROCEDURE [ANY, TUPLE [G]]) is
			-- Apply `action' to every item.
			-- Semantics not guaranteed if `action' changes the structure;
			-- in such a case, apply iterator to clone of structure instead. 
		local
			t: TUPLE [G]
			cs: CURSOR_STRUCTURE [G]
			c: CURSOR
		do
			cs ?= Current
			if cs /= Void then
				c := cs.cursor
			end

			create t
			from
				start
			until
				after
			loop
				t.put (item, 1)
				action.call (t)
				forth
			end

			if cs /= Void then
				cs.go_to (c)
			end
		end

	do_if (action: PROCEDURE [ANY, TUPLE [G]]; test: FUNCTION [ANY, TUPLE [G], BOOLEAN]) is
			-- Apply `action' to every item that satisfies `test'.
			-- Semantics not guaranteed if `action' or `test' changes the structure;
			-- in such a case, apply iterator to clone of structure instead. 
		local
			t: TUPLE [G]
			cs: CURSOR_STRUCTURE [G]
			c: CURSOR
		do
			cs ?= Current
			if cs /= Void then
				c := cs.cursor
			end

			create t
			from
				start
			until
				after
			loop
				t.put (item, 1)
				if test.item (t) then
					action.call (t)
				end
				forth
			end

			if cs /= Void then
				cs.go_to (c)
			end
		end

	there_exists (test: FUNCTION [ANY, TUPLE [G], BOOLEAN]): BOOLEAN is
			-- Is `test' true for at least one item?
		local
			cs: CURSOR_STRUCTURE [G]
			c: CURSOR
			t: TUPLE [G]
		do
			create t
			
			cs ?= Current
			if cs /= Void then
				c := cs.cursor
			end

			from
				start
			until
				after or Result
			loop
				t.put (item, 1)
				Result := test.item (t)
				forth
			end

			if cs /= Void then
				cs.go_to (c)
			end
		end

	for_all (test: FUNCTION [ANY, TUPLE [G], BOOLEAN]): BOOLEAN is
			-- Is `test' true for all items?
		local
			cs: CURSOR_STRUCTURE [G]
			c: CURSOR
			t: TUPLE [G]
		do
			create t
			
			cs ?= Current
			if cs /= Void then
				c := cs.cursor
			end

			from
				start
				Result := True
			until
				after or not Result
			loop
				t.put (item, 1)
				Result := test.item (t)
				forth
			end

			if cs /= Void then
				cs.go_to (c)
			end
		ensure then
			empty: is_empty implies Result
		end

feature -- Conversion

	linear_representation: LINEAR [G] is
			-- Representation as a linear structure
		do
			Result := Current
		end

invariant

	after_constraint: after implies off

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
--| Copyright (c) 1993-2006 University of Southern California and contributors.
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class LINEAR



