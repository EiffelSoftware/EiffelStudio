indexing

	description:
		"Descriptions of features that may be dynamically loaded";

	keywords: "Dynamic Linking in Eiffel";
	product: DLE;
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	DYNAMIC_FEATURE

feature -- Access

	argument_count: INTEGER;
			-- Number of arguments to be passed to the current feature
			-- description by subsequent calls to `apply'

feature -- Setting

	set_argument_count (n: INTEGER) is
			-- Set `argument_count' to `n'.
		require
			valid_n: n >= 0
		do
			argument_count := n
		ensure
			assigned: argument_count = n
		end;

	set_boolean_argument (val: BOOLEAN; pos: INTEGER) is
			-- Make `val' be the `pos'-th argument to be passed to the
			-- current feature description by subsequent calls to `apply'.
		require
			pos_large_enough: pos >= 1;
			pos_small_enough: pos <= argument_count
		do
		end;

	set_character_argument (val: CHARACTER; pos: INTEGER) is
			-- Make `val' be the `pos'-th argument to be passed to the
			-- current feature description by subsequent calls to `apply'.
		require
			pos_large_enough: pos >= 1;
			pos_small_enough: pos <= argument_count
		do
		end;

	set_integer_argument (val: INTEGER; pos: INTEGER) is
			-- Make `val' be the `pos'-th argument to be passed to the
			-- current feature description by subsequent calls to `apply'.
		require
			pos_large_enough: pos >= 1;
			pos_small_enough: pos <= argument_count
		do
		end;

	set_real_argument (val: REAL; pos: INTEGER) is
			-- Make `val' be the `pos'-th argument to be passed to the
			-- current feature description by subsequent calls to `apply'.
		require
			pos_large_enough: pos >= 1;
			pos_small_enough: pos <= argument_count
		do
		end;

	set_double_argument (val: DOUBLE; pos: INTEGER) is
			-- Make `val' be the `pos'-th argument to be passed to the
			-- current feature description by subsequent calls to `apply'.
		require
			pos_large_enough: pos >= 1;
			pos_small_enough: pos <= argument_count
		do
		end;

	set_reference_argument (val: ANY; pos: INTEGER) is
			-- Make `val' be the `pos'-th argument to be passed to the
			-- current feature description by subsequent calls to `apply'.
		require
			pos_large_enough: pos >= 1;
			pos_small_enough: pos <= argument_count
		do
		end;

invariant

	valid_argument_count: argument_count >= 0

end -- class DYNAMIC_FEATURE


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

