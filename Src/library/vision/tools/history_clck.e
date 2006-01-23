indexing

	status: "See notice at end of class.";
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class HISTORY_CLCK

