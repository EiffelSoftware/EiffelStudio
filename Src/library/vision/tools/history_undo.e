
-- Undo button.

indexing

	date: "$Date$";
	revision: "$Revision$"

class HISTORY_UNDO 

inherit

	COMMAND

feature 

	execute (argument: ANY) is
			-- Undo the current command
		local
			history: HISTORY_L_W
		do
			history ?= argument;
			if (not (history.history_list = Void)) and then (not history.history_list.before) then
				history.history_list.back
			end
		end

end


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
