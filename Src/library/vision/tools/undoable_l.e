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
			create Result.make
		ensure then
			result_not_void: Result /= Void
		end

end -- class UNDOABLE_L

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

