note
	description	: "TIMER for debugger on gtk"
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

			if gtk_init_check then
				marshal_init ($Current, $marshal)
				marshal_set_is_enabled (True)
			end
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
				g_source_remove (timeout_connection_id)
			end
			if interval > 0 then
				timeout_connection_id := marshal_timeout_connect (i, agent actions.call(Void))
			end
		end

feature {NONE} -- Implementation

	tty_dbg_events_handler_imp: TTY_DEBUGGER_EVENTS_HANDLER_IMP;

	timeout_connection_id: NATURAL_32

	marshal (action: PROCEDURE; n_args: INTEGER_32; args: POINTER)
		do
			action.call (Void)
		end

	gtk_init_check: BOOLEAN
			-- (export status {NONE})
		external
			"C [macro <gtk/gtk.h>] | %"eif_argv.h%""
		alias
			"gtk_init_check (&eif_argc, &eif_argv)"
		end

	frozen g_source_remove (a_source_id: NATURAL_32)
		external
			"C signature (guint) use <ev_gtk.h>"
		end

	frozen marshal_init (
		object: POINTER; a_marshal: POINTER
		)
			-- See ev_gtk_callback_marshal.c
		external
			"C inline use %"ev_gtk_callback_marshal.h%""
		alias
			"c_ev_gtk_callback_marshal_init ((EIF_REFERENCE) $object, (void (*) (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_POINTER, EIF_POINTER)) $a_marshal);"
		end

	frozen marshal_set_is_enabled (a_enabled_state: BOOLEAN)
			-- See ev_gtk_callback_marshal.c
		external
			"C signature (int) use %"ev_gtk_callback_marshal.h%""
		alias
			"c_ev_gtk_callback_marshal_set_is_enabled"
		end

	frozen marshal_timeout_connect (a_delay: INTEGER_32; an_agent: PROCEDURE): NATURAL_32
			-- Call `an_agent' after `a_delay'.
		external
			"C (gint, EIF_OBJECT): EIF_INTEGER | %"ev_gtk_callback_marshal.h%""
		alias
			"c_ev_gtk_callback_marshal_timeout_connect"
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
