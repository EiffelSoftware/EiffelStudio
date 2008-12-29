note

	description: "Undo button"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	HISTORY_UNDO 

inherit

	COMMAND

feature -- Basic operations

	execute (argument: ANY)
			-- Undo the current command.
		local
			history: HISTORY_L_W
		do
			history ?= argument;
			if (history.history_list /= Void) and then (not history.history_list.before) then
				history.history_list.back
			end
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class HISTORY_REDO

