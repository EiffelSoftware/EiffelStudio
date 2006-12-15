indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUGGER_TIMER

inherit

	ANY
		redefine default_create end

feature {NONE} -- Initialization

	default_create is
			-- Create Current debugger timer
		do
			Precursor
			create actions.make

			if gtk_init_check then			
				marshal_init (Current, $marshal)
				marshal_set_is_enabled (True)
			end
		end

feature -- Access

	interval: INTEGER

	actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed at a regular interval.
			-- Only called when interval is greater than 0.	

feature -- Change

	set_interval (i: like interval) is
		do
			interval := i
			if timeout_connection_id > 0 then
				gtk_timeout_remove (timeout_connection_id)
			end
			if interval > 0 then
				timeout_connection_id := marshal_timeout_connect (i, agent actions.call(Void))
			end
		end

feature {NONE} -- Implementation

	timeout_connection_id: INTEGER

	marshal (action: PROCEDURE [ANY, TUPLE]; n_args: INTEGER_32; args: POINTER) is
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

	frozen marshal_init (object: like Current; a_marshal: POINTER)
			-- See ev_gtk_callback_marshal.c
		external
			"C | %"ev_gtk_callback_marshal.h%""
		alias
			"c_ev_gtk_callback_marshal_init"
		end

	frozen marshal_set_is_enabled (a_enabled_state: BOOLEAN) is
			-- See ev_gtk_callback_marshal.c
		external
			"C signature (int) use %"ev_gtk_callback_marshal.h%""
		alias
			"c_ev_gtk_callback_marshal_set_is_enabled"
		end


	frozen marshal_timeout_connect (a_delay: INTEGER_32; an_agent: PROCEDURE [ANY, TUPLE]): INTEGER_32
			-- Call `an_agent' after `a_delay'.
		external
			"C (gint, EIF_OBJECT): EIF_INTEGER | %"ev_gtk_callback_marshal.h%""
		alias
			"c_ev_gtk_callback_marshal_timeout_connect"
		end

invariant
	ev_timer /= Void

end
