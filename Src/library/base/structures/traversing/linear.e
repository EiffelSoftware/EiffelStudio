indexing

	description:
		"Structures whose items may be accessed sequentially, one-way";

	status: "See notice at end of class";
	names: sequential, traversing;
	access: membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class LINEAR [G] inherit

	TRAVERSABLE [G]

feature -- Access

	has (v: like item): BOOLEAN is
			-- Does structure include an occurrence of `v'?
			-- (Reference or object equality,
			-- based on `object_comparison'.)
		do
			start;
			if not off then
				search (v)
			end;
			Result := not exhausted
		end;

	index_of (v: like item; i: INTEGER): INTEGER is
			-- Index of `i'-th occurrence of `v'.
			-- 0 if none.
			-- (Reference or object equality,
			-- based on `object_comparison'.)
		require
			positive_occurrences: i > 0;
		local
			occur, pos: INTEGER;
		do
			if object_comparison then
				if v /= Void then
					from
						start;
						pos := 1
					until
						off or else (occur = i)
					loop
						if item /= Void and then v.is_equal (item) then
							occur := occur + 1
						end;
						forth;
						pos := pos + 1
					end
				end
			else
				from
					start;
					pos := 1
				until
					off or else (occur = i)
				loop
					if item = v then
						occur := occur + 1
					end;
					forth;
					pos := pos + 1
				end
			end;
			if occur = i then
				Result := pos - 1
			end;
		ensure
			non_negative_result: Result >= 0
		end;

	search (v: like item) is
			-- Move to first position (at or after current
			-- position) where `item' and `v' are equal.
			-- (Reference or object equality,
			-- based on `object_comparison'.)
			-- If no such position ensure that `exhausted' will be true.
		do
			if object_comparison then
				if v = Void then
					finish;
					if not after then forth end
				else
					from
					until
						exhausted or else (item /= Void and then v.is_equal (item))
					loop
						forth
					end
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
			object_found: (not exhausted and then object_comparison and then v /= Void and then item /= Void)
				 implies v.is_equal (item);
			item_found: (not exhausted and not object_comparison)
				 implies v = item
		end;

	index: INTEGER is
			-- Index of current position
		deferred
		end;

	occurrences (v: G): INTEGER is
			-- Number of times `v' appears.
			-- (Reference or object equality,
			-- based on `object_comparison'.)
		do
			from
				start;
				search (v)
			until
				exhausted
			loop
				Result := Result + 1;
				forth;
				search (v)
			end;
		end;

feature -- Status report

	exhausted: BOOLEAN is
			-- Has structure been completely explored?
		do
			Result := off
		ensure
			exhausted_when_off: off implies Result
		end;

	after: BOOLEAN is
			-- Is there no valid position to the right of current one?
		deferred
		end;

	off: BOOLEAN is
			-- Is there no current item?
		do
			Result := empty or after
		end;

feature -- Cursor movement

	finish is
			-- Move to last position.
		deferred
		end;

	forth is
			-- Move to next position; if no next position,
			-- ensure that `exhausted' will be true.
		require
			not_after: not after
		deferred
		ensure
			-- moved_forth_before_end: (not after) implies index = old index + 1
		end;

feature -- Conversion

	linear_representation: LINEAR [G] is
			-- Representation as a linear structure
		do
			Result := Current
		end;

invariant

	after_constraint: after implies off

end -- class LINEAR


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
