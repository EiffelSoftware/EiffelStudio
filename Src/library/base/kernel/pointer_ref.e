indexing

	description:
		"References to objects containing a reference to objects %
		%meant to be exchanged with non-Eiffel software.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class POINTER_REF inherit

	ANY
		redefine
			out
		end

feature -- Access

	item: POINTER;
			-- Pointer value

	hash_code: INTEGER is
			-- Hash code value
		do
			Result := c_hashcode ($item)
		end;

feature -- Element change

	set_item (p: POINTER) is
			-- Make `p' the `item' value.
		do
			item := p
		end

feature -- Status report

	is_hashable: BOOLEAN is
			-- May current object be hashed?
			-- (True if it is not its type's default.)
		do
			Result := item /= default_pointer
		end;

feature -- Output

	out: STRING is
			-- Printable representation of pointer value
		do
			Result := c_outp (item)
		end;

feature {NONE} -- Implementation

	c_outp (p: POINTER): STRING is
			-- Printable representation of pointer value
		external
			"C"
		end;

	c_hashcode (p: POINTER): INTEGER is
			-- Hash code value of `p'
		external
			"C"
		alias
			"conv_pi"
		end;

end -- class POINTER_REF


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
