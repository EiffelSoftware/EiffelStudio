indexing

	description:
		"Sequential lists, without commitment to a particular representation";

	status: "See notice at end of class";
	names: list, sequence;
	access: index, cursor, membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class LIST [G] inherit

	CHAIN [G]
		redefine
			forth
		end;
feature -- Cursor movement

	forth is
			-- Move to next position; if no next position,
			-- ensure that `exhausted' will be true.
		deferred
		ensure then
			moved_forth: index = old index + 1
		end;

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

invariant

	before_definition: before = (index = 0);
	after_definition: after = (index = count + 1);

end -- class LIST


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

