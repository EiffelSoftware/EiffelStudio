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

	discard_debug
			-- Discard debugger activity	
		do
			rt_set_debug_mode (0)
		end

	enable_debug
			-- Enable debugger activity (if workbench)
		do
			rt_set_debug_mode (1)
		end

	restore_debug_state (a_state: like debug_state)
			-- Restore debugger activity to `a_state'
		do
			if a_state then
				enable_debug
			else
				discard_debug
			end
		end

feature {NONE} -- Status report

	debug_state: BOOLEAN
			-- Is debugger enabled?
			--| Warning: do not try to evaluate it in watch tool (it will always return False)
		do
			Result := rt_debug_mode = 1
		end

feature {NONE} -- Implementation

	rt_valid_debug_mode (a_mode: INTEGER): BOOLEAN
			-- Is `a_mode' a valid runtime debug_mode value?
		do
			Result := a_mode = 0 or a_mode = 1
		end

	rt_set_debug_mode (a_mode: INTEGER)
			-- Set runtime value for `debug_mode'
			-- a_debug_mode = 0: disable debugger
			-- a_debug_mode = 1: enable debugger
		require
			a_mode_valid: rt_valid_debug_mode (a_mode)
		external
			"C inline use%"eif_main.h%""
		alias
			"[
			#ifdef WORKBENCH
				set_debug_mode ($a_mode);
			#endif
			]"
		ensure
			debug_mode_set: rt_debug_mode_set (a_mode)
		end

	rt_debug_mode: INTEGER
			-- Runtime value for `debug_mode'
			-- 0: debugger disabled
			-- 1: debugger enabled
			--| Warning: do not try to evaluate it in watch tool (it will always return 0)	
		external
			"C inline use %"eif_main.h%""
		alias
			"[
			#ifdef WORKBENCH
				return is_debug_mode();
			#else
				return 0;
			#endif
			]"
		ensure
			result_mode_valid: rt_valid_debug_mode (Result)
		end

	rt_debug_mode_set (a_mode: INTEGER): BOOLEAN
			-- Is runtime value for `debug_mode' set to `a_mode'?
			--| Warning: do not try to evaluate it in watch tool
		external
			"C inline use %"eif_main.h%""
		alias
			"[
			#ifdef WORKBENCH
				if ($a_mode == is_debug_mode()) {
					return EIF_TRUE;
				} else {
					return EIF_FALSE;
				}
			#else
				return EIF_TRUE;
			#endif
			]"
		end

feature -- Debugger: interaction with run-time

    frozen rt_workbench_wait_for_debugger (a_port_number: INTEGER): BOOLEAN
            -- Initialize workbench debugging using socket connection
			-- used to launch the application, and then attach the debugger.
			-- if `a_port_number' <= 0 then check for ISE_DBG_PORTNUM environment variable.
		external
			"C inline use %"eif_main.h%""
		alias
			"[
			#ifdef WORKBENCH
				if (!is_debug_mode() == 1) {
					wdbg_initialize($a_port_number);
					if (is_debug_mode() == 1) {
						return EIF_TRUE;
					} else {
						return EIF_FALSE;
					};
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
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
