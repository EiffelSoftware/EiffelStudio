indexing

	description:
		"Packed boolean strings"

	status: "See notice at end of class"
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

	item (i: INTEGER): BOOLEAN is
			-- Boolean at `i'-th position,
			-- beginning at left, 1 origin
		require
			index_large_enough: 1 <= i
			index_small_enough: i <= count
		do
			Result := area.item (i - 1)
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
		require
			index_large_enough: 1 <= i
			index_small_enough: i <= count
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

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
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

end -- class BOOL_STRING



