indexing

	description:
		"Ancestors of user commands for a history based on a linear list. %
		%This command will create an history of class HISTORY_LIST. %
		%Deferred features : is_error, n_ame, redo, undo, work";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	UNDOABLE_L 

inherit

	UNDOABLE

feature -- Access

	history: HISTORY_LIST is
			-- Trace of previously executed commands
		once
			!! Result.make
		ensure then
			result_not_void: Result /= Void
		end

end -- class UNDOABLE_L



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

