indexing

	description: "Nested queries example."
	production: "EiffelStore"
	Status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class ACTION_1 inherit

	ACTION
		redefine
			execute
		end
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
        
	execute is
		do
			process_row
		end

	process_row is
		deferred
		end

	select_string: STRING is
		deferred
		ensure
			result_not_void: Result /= Void
		end

end -- class ACTION_1


--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

