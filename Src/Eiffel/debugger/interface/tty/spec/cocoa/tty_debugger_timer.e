note
	description	: "TIMER for debugger on Carbon"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TTY_DEBUGGER_TIMER

inherit

	DEBUGGER_TIMER

create
	make

feature {NONE} -- Initialization

	make (dmi: TTY_DEBUGGER_EVENTS_HANDLER_IMP)
		do
			tty_dbg_events_handler_imp := dmi
			create actions

--			if gtk_init_check then
--				marshal_init ($Current, $marshal)
--				marshal_set_is_enabled (True)
--			end
		end

feature -- Access

	interval: INTEGER

	actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed at a regular interval.
			-- Only called when interval is greater than 0.	

feature -- Change

	set_interval (i: like interval)
		do
			interval := i
			if timeout_connection_id > 0 then
--				gtk_timeout_remove (timeout_connection_id)
			end
			if interval > 0 then
--				timeout_connection_id := marshal_timeout_connect (i, agent actions.call(Void))
			end
		end

feature {NONE} -- Implementation

	tty_dbg_events_handler_imp: TTY_DEBUGGER_EVENTS_HANDLER_IMP;

	timeout_connection_id: INTEGER

	marshal (action: PROCEDURE; n_args: INTEGER_32; args: POINTER)
		do
			action.call (Void)
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
