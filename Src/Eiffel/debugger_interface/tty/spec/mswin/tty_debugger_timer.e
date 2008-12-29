note
	description	: "TIMER for debugger on mswin"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TTY_DEBUGGER_TIMER

inherit

	IDENTIFIED

	DEBUGGER_TIMER
		undefine
			is_equal, copy
		end

create
	make

feature {NONE} -- Initialization

	make (dmi: TTY_DEBUGGER_EVENTS_HANDLER_IMP)
		do
			tty_dbg_events_handler_imp := dmi
			create actions
		end

feature -- Access

	interval: INTEGER

	actions: ACTION_SEQUENCE [TUPLE]

feature -- Change

	set_interval (i: like interval)
		do
			interval := i
			if i = 0 then
				kill_timer
			else
				set_timer
			end
		end

	set_timer
		do
			tty_dbg_events_handler_imp.set_timer (object_id, interval)
		end

	kill_timer
		do
			tty_dbg_events_handler_imp.kill_timer (object_id)
		end

feature -- Execution

	execute
		do
			actions.call (Void)
		end

feature {NONE} -- Implementation

	tty_dbg_events_handler_imp: TTY_DEBUGGER_EVENTS_HANDLER_IMP;

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
