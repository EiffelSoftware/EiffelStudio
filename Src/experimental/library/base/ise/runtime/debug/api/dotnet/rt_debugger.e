note
	description: "[
		Set of features to access ISE debugger functionality from debuggee.	
		
		Note: do not try to evaluate the following feature in watch tool!
		
		TO BE USED AT YOUR OWN RISK.
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
		end

	enable_debug
			-- Enable debugger activity (if workbench)
		do
		end

	restore_debug_state (a_state: like debug_state)
			-- Restore debugger activity to `a_state'
		do
		end

feature {NONE} -- Status report

	debug_state: BOOLEAN
            -- Is debugger enabled?
            --| Warning: do not try to evaluate it in watch tool (it will always return False)
		do
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
