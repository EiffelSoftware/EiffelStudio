--|---------------------------------------------------------------
--|   Copyright (C) 1989 Interactive Software Engineering, Inc. --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	names: packed_booleans;
	access: index;
	representation: array;
	size: fixed;
	date: "$Date$";
	revision: "$Revision$"

class BOOL_STRING 

inherit

	TO_SPECIAL [BOOLEAN]
		export
			{NONE} all;
			{BOOL_STRING} area
		end

creation

	make

feature  -- Creation

	make (n: INTEGER) is
			-- Allocate area of `n' booleans.
		require
			positive_size: n > 0
		do
			make_area (n);
		ensure
			count = n
		end;

feature -- Access

	item (i: INTEGER): BOOLEAN is
			-- Boolean at `i'-th position,
			-- beginning at left, 1 origin
		require
			index_large_enough: 1 <= i;
			index_small_enough: i <= count
		do
			Result := area.item (i - 1) 
		end;

	put (v: like item; i: INTEGER) is
			-- Put boolean `v' at `i'-th position
			-- beginning at left, 1 origin.
		require
			index_large_enough: 1 <= i;
			index_small_enough: i <= count
		do
			area.put (v, i - 1)
		end; 

	count: INTEGER is
			-- Number of boolean in the area.
		do
			Result := area.count
		end;

	all_true is
			-- Set all booleans to true.
		do
			bl_str_set ($area, count, 1);
		end;

	all_false is
			-- Set all booleans to false.
		do
			bl_str_set ($area, count, 0);
		end;

	infix "and" (other: like Current): like Current is
			-- Apply logic and on current set with `other'
		require
			same_size: other.count = count
		local
			other_area, result_area: like area;
		do
			!! Result.make (count);
			result_area := Result.area;
			other_area := other.area;
			bl_str_and ($area, $other_area, $result_area, count);
		end;

	infix "or" (other: like Current): like Current is
			-- Apply logic or on current set with `other'
		require
			same_size: other.count = count
		local
			other_area, result_area: like area;
		do
			!! Result.make (count);
			result_area := Result.area;
			other_area := other.area;
			bl_str_or ($area, $other_area, $result_area, count);
		end;

	infix "xor" (other: like Current): like Current is
			-- Apply exclusive or on current set with `other'
		require
			same_size: other.count = count
		local
			other_area, result_area: like area;
		do
			!! Result.make (count);
			result_area := Result.area;
			other_area := other.area;
			bl_str_xor ($area, $other_area, $result_area, count);
		end;

	prefix "not": like Current is
			-- Negation of current set
		local
			result_area: like area;
		do
			!! Result.make (count);	
			result_area := Result.area;
			bl_str_not ($area, $result_area, count);
		end;

	right_shifted (n: INTEGER): like Current is
			-- Right shifted current set, by `n' positions
		require
			positive_shift: n >= 0
		local
			result_area: like area;
		do
			!! Result.make (count);
			result_area := Result.area;
			bl_str_shiftr ($area, $result_area, count, n);
		end;

	left_shifted (n: INTEGER): like Current is
			-- Left shifted current set, by `n' positions
		require
			positive_shift: n >= 0
		local
			result_area: like area;
		do
			!! Result.make (count);
			result_area := Result.area;
			bl_str_shiftl ($area, $result_area, count, n);
		end;

feature {NONE} -- Externals

	bl_str_and (a1, a2, a3: like area; size: INTEGER) is
			-- Apply logic and on `a1' with `a2'.
		external
			"C"
		end;

	bl_str_or (a1, a2, a3: like area; size: INTEGER) is
			-- Apply logic or on `a1' with `a2'.
		external
			"C"
		end;

	bl_str_xor (a1, a2, a3: like area; size: INTEGER) is
			-- Apply exclusive or on `a1' with `a2'.
		external
			"C"
		end;

	bl_str_not (a1, a2: like area; size: INTEGER) is
			-- Negation of `a1'.
		external
			"C"
		end;

	bl_str_shiftr (a1, a2: like area; size, value: INTEGER) is
			-- Right shifted `a1' by `n' positions.
		external
			"C"
		end;

	bl_str_shiftl (a1, a2: like area; size, value: INTEGER) is
			-- Left shifted `a1' by `n' positions.
		external
			"C"
		end;

	bl_str_set (a1: like area; size, value: INTEGER) is
			-- Set all booleans to true if `value' = 1
			-- or false if `value' = 0.
		external
			"C"
		end;

end
