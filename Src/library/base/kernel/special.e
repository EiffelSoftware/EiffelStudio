indexing

	description:
		"Special objects: homogeneous sequences of values, %
		%used to represent arrays and strings";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SPECIAL [T] inherit

	ANY
		redefine
			conforms_to,
			c_standard_clone, c_standard_is_equal, c_standard_copy
		end

feature -- Access

	item (i: INTEGER): T is
			-- Item at `i'-th position
			-- (indices begin at 0)
		require
			index_big_enough: i >= 0;
			index_small_enough: i < count
		do
			-- Built-in
		end;

	conforms_to (other: SPECIAL [T]): BOOLEAN is
			-- Does special object conform to `other'?
		do
			Result := other.count = count
		end;

feature -- Measurement

	count: INTEGER is
			-- Count of the special area
		do
			Result := sp_count ($Current);
		end;

feature -- Element change

	put (v: T; i: INTEGER) is
			-- Replace `i'-th item by `v'.
			-- (Indices begin at 0.)
		require
			index_big_enough: i >= 0;
			index_small_enough: i < count
		do
			-- Built-in
		end;

feature {NONE} -- Implementation

	sp_count (sp_obj: POINTER): INTEGER is
			-- Count of the special object
		external
			"C | <plug.h>"
		end;

	c_standard_is_equal (source, target: POINTER): BOOLEAN is
			-- Is `source' equal to `target' ?
			-- Returns True if `source' and `target' have the same count
			-- and the same entries.
		external
			"C | <equal.h>"
		alias
			"spequal"
		end;

	c_standard_copy (source, target: POINTER) is
			-- Copy entries of `target' into `source'.
		external
			"C | <copy.h>"
		alias
			"spcopy"
		end;

	c_standard_clone (other: POINTER): SPECIAL [T] is
			-- New special object of size `count'
		external
			"C | <copy.h>"
		alias
			"spclone"
		end

end -- class SPECIAL


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1997 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
