note
	description: "[
		Set of features to access ISE debugger functionality from debuggee.	
		
		Note: do not try to evaluate the following feature in watch tool!
		]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	RT_DEBUGGER

feature {NONE} -- Status settings

	enable_debug
			-- Enable debugger (if workbench)
		do
			set_debug_state (True)
		end

	disable_debug
			-- Disable debugger	
		do
			set_debug_state (False)
		end

	set_debug_state (a_state: like debug_state)
			-- Set debugger state to `a_state'
		external
			"C inline use%"eif_main.h%""
		alias
			"[
			#ifdef WORKBENCH
				set_debug_mode ($a_state ? 1 : 0);
			#endif
			]"
		end

feature {NONE} -- Status report

	debug_state: BOOLEAN
			-- Is debugger enabled?
			--| Warning: do not try to evaluate it in watch tool (it will always return False)
		external
			"C inline use %"eif_main.h%""
		alias
			"[
			#ifdef WORKBENCH
				return EIF_TEST(is_debug_mode());
			#else
				return EIF_FALSE;
			#endif
			]"
		end

feature -- Debugger: interaction with run-time

	frozen wait_for_debugger (a_port_number: INTEGER): BOOLEAN
			-- Initialize workbench debugging using socket connection
			-- used to launch the application, and then attach the debugger.
			-- if `a_port_number' <= 0 then check for ISE_DBG_PORTNUM environment variable.
			--
			--| Note: The port number shoud be greater than 1023, and available.
			--| 	  The port range 49152-65535 can be used for such custom or temporary purposes.
		external
			"C inline use %"eif_main.h%""
		alias
			"[
			#ifdef WORKBENCH
				if (!is_debug_mode()) {
					wdbg_initialize($a_port_number);
					return EIF_TEST(is_debug_mode());
				} else {
					return EIF_FALSE;
				}
			#else
				return EIF_FALSE;
			#endif
			]"
		end

note
	library:   "EiffelBase: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
