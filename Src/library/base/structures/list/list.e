indexing

	description:
		"Sequential lists, without commitment to a particular representation";

	copyright: "See notice at end of class";
	names: list, sequence;
	access: index, cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class LIST [G] inherit

	CHAIN [G];

feature -- Status report

	after: BOOLEAN is
			-- Is there no valid cursor position to the right of cursor?
		do
			Result := (index = count + 1)
		end;

	before: BOOLEAN is
			-- Is there no valid cursor position to the left of cursor?
		do
			Result := (index = 0)
		end;

feature -- Obsolete

	offleft: BOOLEAN is obsolete "Use ``before''"
		do
			Result := before or empty
		end;

	offright: BOOLEAN is obsolete "Use ``after''"
		do
			Result := after or empty
		end;

invariant

	before_definition: before = (index = 0);
	after_definition: after = (index = count + 1);

end -- class LIST


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
