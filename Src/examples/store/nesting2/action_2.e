indexing

	description: "Nested queries example."
	production: "EiffelStore"
	Status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class ACTION_2 inherit

	ACTION

feature

	selection: DB_SELECTION

	make (sel: DB_SELECTION) is
		require
			sel_not_void: sel /= Void
		do
			selection := sel
		ensure
			selection = sel
		end
        
end -- class ACTION_2






--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
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
