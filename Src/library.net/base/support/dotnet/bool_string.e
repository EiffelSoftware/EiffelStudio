indexing

	description:
		"Packed boolean strings"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	names: packed_booleans;
	access: index;
	representation: array;
	size: fixed;
	date: "$Date$"
	revision: "$Revision$"

class BOOL_STRING inherit

	TO_SPECIAL [BOOLEAN]
		export
			{NONE} all
			{BOOL_STRING} area
		redefine
			item, infix "@", put, valid_index			
		end

create

	make

feature -- Initialization

	make (n: INTEGER) is
			-- Allocate area of `n' booleans.
		require
			non_negative_size: n >= 0
		do
			make_area (n)
		ensure
			correct_allocation: count = n
		end

feature -- Access

	item alias "[]", infix "@" (i: INTEGER): BOOLEAN assign put is
			-- Boolean at `i'-th position,
			-- beginning at left, 1 origin
		do
			Result := area.item (i - 1)
		end

feature -- Status report

	valid_index (i: INTEGER): BOOLEAN is
			-- Is `i' within the bounds of Current?
		do
			Result := (1 <= i) and then (i <= count)
		end

feature -- Measurement

	count: INTEGER is
			-- Number of boolean in the area.
		do
			Result := area.count
		end

feature -- Element change

	put (v: like item; i: INTEGER) is
			-- Put boolean `v' at `i'-th position
			-- beginning at left, 1 origin.
		do
			area.put (v, i - 1)
		end

	all_true is
			-- Set all booleans to true.
		local
			i, s: INTEGER
		do
			from
				s := count
			until
				i = s
			loop
				area.put (True, i)
				i := i + 1
			end
		end

	all_false is
			-- Set all booleans to false.
		local
			i, s: INTEGER
		do
			from
				s := count
			until
				i = s
			loop
				area.put (False, i)
				i := i + 1
			end
		end

feature -- Basic operations

	infix "and" (other: like Current): like Current is
		-- Logical and of 'Current' and `other'
		require
			other_not_void: other /= Void
			same_size: other.count = count
		local
			other_area, result_area: like area
			i, s: INTEGER
		do
			s := count
			create Result.make (s)
			result_area := Result.area
			other_area := other.area
			from
				
			until
				i = s
			loop
				result_area.put (area.item (i) and other_area.item (i), i)
				i := i + 1
			end
		end

	infix "or" (other: like Current): like Current is
			-- Logical or of 'Current' and `other'
		require
			other_not_void: other /= Void
			same_size: other.count = count
		local
			other_area, result_area: like area
			i, s: INTEGER
		do
			s := count
			create Result.make (s)
			result_area := Result.area
			other_area := other.area
			from
				
			until
				i = s
			loop
				result_area.put (area.item (i) or other_area.item (i), i)
				i := i + 1
			end
		end

	infix "xor" (other: like Current): like Current is
		-- Logical exclusive or of 'Current' and `other'
		require
			other_not_void: other /= Void
			same_size: other.count = count
		local
			other_area, result_area: like area
			i, s: INTEGER
		do
			s := count
			create Result.make (s)
			result_area := Result.area
			other_area := other.area
			from
				
			until
				i = s
			loop
				result_area.put (area.item (i) /= other_area.item (i), i)
				i := i + 1
			end
		end

	prefix "not": like Current is
			-- Negation of 'Current'
		local
			result_area: like area
			i, s: INTEGER
		do
			s := count
			create Result.make (s)
			result_area := Result.area
			from
				
			until
				i = s
			loop
				result_area.put (not area.item (i), i)
				i := i + 1
			end
		end

	right_shifted (n: INTEGER): like Current is
			-- Right shifted 'Current' set, by `n' positions
		require
			non_negative_shift: n >= 0
		local
			result_area: like area
			i: INTEGER
			s: INTEGER
		do
			s := count
			create Result.make (s)
			result_area := Result.area
			if n < s then
				from
					i := n
				until
					i = s
				loop
					result_area.put (area.item (i - n), i)
					i := i + 1
				end
				s := n
			end
			from
				i := 0
			until
				i = s
			loop
				result_area.put (False, i)
				i := i + 1
			end
		end

	left_shifted (n: INTEGER): like Current is
			-- Left shifted 'Current' set, by `n' positions
		require
			non_negative_shift: n >= 0
		local
			result_area: like area
			i, s:INTEGER
		do
			create Result.make (count)
			result_area := Result.area
			s := count
			if n < s then
				from
					i := 0
				until
					i = s - n
				loop
					result_area.put (area.item (i + n), i)
					i := i + 1
				end
				s := n
			end
			from
				i := 0
			until
				i = s
			loop
				result_area.put (False, s - i - 1)
				i := i + 1
			end
		end

indexing
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"



end -- class BOOL_STRING



