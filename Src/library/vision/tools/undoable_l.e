
-- Ancestors of user commands for a history based on a linear list.
-- This command will create an history of class HISTORY_LIST
--
-- Deferred features : is_error, n_ame, redo, undo, work

indexing

	date: "$Date$";
	revision: "$Revision$"

deferred class UNDOABLE_L 

inherit

	UNDOABLE

feature 

	history: HISTORY_LIST is
			-- Trace of previously executed commands
		once
			!! Result.make
		ensure then
			not (Result = Void)
		end

end


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
