indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	HISTORY_CLCK 

inherit

	COMMAND
		redefine
			context_data_useful
		end

feature -- Status report

	context_data_useful: BOOLEAN is true;
			-- This command need a context_data structure

feature -- Basic operations

	execute (argument: ANY) is
			-- Undo the current command.
		local
			history: HISTORY_L_W;
			single_data: SINGLE_DATA
		do
			single_data ?= context_data;
			history ?= argument;
			if history.history_list /= Void then
				history.history_list.go_i_th (single_data.position)
			end
		end;

end -- class HISTORY_CLCK

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

