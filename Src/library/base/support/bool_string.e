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
		do
			bl_str_set ($area, count, 1)
		end

	all_false is
			-- Set all booleans to false.
		do
			bl_str_set ($area, count, 0)
		end

feature -- Basic operations

	infix "and" (other: like Current): like Current is
		-- Logical and of 'Current' and `other'
		require
			other_not_void: other /= Void
			same_size: other.count = count
		local
			other_area, result_area: like area
		do
			create Result.make (count)
			result_area := Result.area
			other_area := other.area
			bl_str_and ($area, $other_area, $result_area, count)
		end

	infix "or" (other: like Current): like Current is
			-- Logical or of 'Current' and `other'
		require
			other_not_void: other /= Void
			same_size: other.count = count
		local
			other_area, result_area: like area
		do
			create Result.make (count)
			result_area := Result.area
			other_area := other.area
			bl_str_or ($area, $other_area, $result_area, count)
		end

	infix "xor" (other: like Current): like Current is
		-- Logical exclusive or of 'Current' and `other'
		require
			other_not_void: other /= Void
			same_size: other.count = count
		local
			other_area, result_area: like area
		do
			create Result.make (count)
			result_area := Result.area
			other_area := other.area
			bl_str_xor ($area, $other_area, $result_area, count)
		end

	prefix "not": like Current is
			-- Negation of 'Current'
		local
			result_area: like area
		do
			create Result.make (count)
			result_area := Result.area
			bl_str_not ($area, $result_area, count)
		end

	right_shifted (n: INTEGER): like Current is
			-- Right shifted 'Current' set, by `n' positions
		require
			non_negative_shift: n >= 0
		local
			result_area: like area
		do
			create Result.make (count)
			result_area := Result.area
			bl_str_shiftr ($area, $result_area, count, n)
		end

	left_shifted (n: INTEGER): like Current is
			-- Left shifted 'Current' set, by `n' positions
		require
			non_negative_shift: n >= 0
		local
			result_area: like area
		do
			create Result.make (count)
			result_area := Result.area
			bl_str_shiftl ($area, $result_area, count, n)
		end

feature {NONE} -- Implementation

	bl_str_and (a1, a2, a3: POINTER; size: INTEGER) is
			-- Apply logic and on `a1' with `a2'.
		external
			"C | %"eif_boolstr.h%""
		end

	bl_str_or (a1, a2, a3: POINTER; size: INTEGER) is
			-- Apply logic or on `a1' with `a2'.
		external
			"C | %"eif_boolstr.h%""
		end

	bl_str_xor (a1, a2, a3: POINTER; size: INTEGER) is
			-- Apply exclusive or on `a1' with `a2'.
		external
			"C | %"eif_boolstr.h%""
		end

	bl_str_not (a1, a2: POINTER; size: INTEGER) is
			-- Negation of `a1'.
		external
			"C | %"eif_boolstr.h%""
		end

	bl_str_shiftr (a1, a2: POINTER; size, value: INTEGER) is
			-- Right shifted `a1' by `n' positions.
		external
			"C | %"eif_boolstr.h%""
		end

	bl_str_shiftl (a1, a2: POINTER; size, value: INTEGER) is
			-- Left shifted `a1' by `n' positions.
		external
			"C | %"eif_boolstr.h%""
		end

	bl_str_set (a1: POINTER; size, value: INTEGER) is
			-- Set all booleans to true if `value' = 1
			-- or false if `value' = 0.
		external
			"C | %"eif_boolstr.h%""
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



