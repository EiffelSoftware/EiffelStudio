indexing

	description:
		"References to objects containing a character value";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class CHARACTER_REF inherit

	COMPARABLE
		redefine
			out
		end

feature -- Access


	item: CHARACTER;
			-- Character value

	code: INTEGER is
			-- Associated integer value
		do
			Result := chcode ($item);		
		end;

feature -- Comparison

	infix "<" (other: CHARACTER_REF): BOOLEAN is
			-- Is current character less than `other'?
		require else
			other_exists: other /= Void
		do
			Result := item < other.item;
		end;

feature -- Output

	out: STRING is
			-- Printable representation of character.
		do
			Result := c_outc ($item)
		end;

feature {NONE} -- Implementation

	chcode (c: like item): INTEGER is
			-- Associated integer value.
		external
			"C"
		end;


	c_outc (c: CHARACTER): STRING is
			-- Printable representation of character.
		external
			"C"
		end;

end -- class CHARACTER_REF


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
