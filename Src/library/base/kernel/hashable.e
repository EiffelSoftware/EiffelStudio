indexing

	description:
		"Values that may be hashed into an integer index, %
		%for use as keys in hash tables";

	note: 
		"In general, the default value of a type (e.g. 0 for integers, %
		%void for references) may not be hashed."

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	HASHABLE

feature -- Access

	hash_code: INTEGER is
			-- Hash code value
		require
			hashable: is_hashable
		deferred
		ensure
			good_hash_value: Result >= 0
		end;

feature -- Status report

	is_hashable: BOOLEAN is
			-- May current object be hashed?
			-- (True if it is not its type's default.)
		do
			Result := (Current /= default)
		ensure
			ok_if_not_default: Result implies (Current /= default)
		end;

end -- class HASHABLE


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
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
