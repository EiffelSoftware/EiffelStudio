indexing

	description: "Redo button";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	HISTORY_REDO 

inherit

	COMMAND

feature -- Basic operations

	execute (argument: ANY) is
			-- Redo the last command undone.
		local
			history: HISTORY_L_W
		do
			history ?= argument;
			if (history.history_list /= Void) and then (not history.history_list.islast) then
				history.history_list.forth
			end
		end;

end -- class HISTORY_REDO

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
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

