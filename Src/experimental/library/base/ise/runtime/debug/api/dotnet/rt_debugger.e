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
		end

	disable_debug
			-- Disable debugger
		do
		end

	set_debug_state (a_state: like debug_state)
			-- Set debugger state to `a_state'
		do
		end

feature {NONE} -- Status report

	debug_state: BOOLEAN
            -- Is debugger enabled?
            --| Warning: do not try to evaluate it in watch tool (it will always return False)
		do
		end

feature -- Debugger: interaction with run-time

    frozen wait_for_debugger (a_port_number: INTEGER): BOOLEAN
            -- Initialize workbench debugging using socket connection
			-- used to launch the application, and then attach the debugger.
			-- if `a_port_number' <= 0 then check for ISE_DBG_PORTNUM environment variable.
		do
			--| This is not implemented for dotnet platform.
		end		

note
	library:   "EiffelBase: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
