
indexing

	date: "$Date$";
	revision: "$Revision$"

class HISTORY_CLCK 

inherit

	COMMAND
		redefine
			context_data_useful
		end

feature 

	context_data_useful: BOOLEAN is true;
			-- This command need a context_data structure

	execute (argument: ANY) is
			-- Undo the current command
		local
			history: HISTORY_L_W;
			single_data: SINGLE_DATA
		do
			single_data ?= context_data;
			history ?= argument;
			if not (history.history_list = Void) then
				history.history_list.go_i_th (single_data.position)
			end
		end;

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
