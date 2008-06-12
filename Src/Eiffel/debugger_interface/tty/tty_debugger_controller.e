indexing
	description: "TTY debugger's controller."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	TTY_DEBUGGER_CONTROLLER

inherit
	DEBUGGER_CONTROLLER
		redefine
			manager,
			if_confirmed_do,
			discardable_if_confirmed_do,
			activate_debugger_environment
		end

feature -- Access

	if_confirmed_do (msg: STRING_GENERAL; a_action: PROCEDURE [ANY, TUPLE]) is
		local
			is_yes: BOOLEAN
		do
			localized_print (msg.as_string_32 + " [y/n] ?")
			io.read_line
			is_yes := io.last_string.is_empty or else io.last_string.item (1).is_equal ('y')
			if is_yes then
				a_action.call (Void)
			end
		end

	discardable_if_confirmed_do (msg: STRING_GENERAL; a_action: PROCEDURE [ANY, TUPLE];
			a_button_count: INTEGER; a_pref_string: STRING) is
		do
			if manager.is_true_boolean_value (a_pref_string) then
				a_action.call (Void)
			else
				if_confirmed_do (msg, a_action)
			end
		end

	activate_debugger_environment (b: BOOLEAN) is
		do
			Precursor {DEBUGGER_CONTROLLER} (b)
			if b then
				localized_print (debugger_names.m_debugger_environment_started)
			else
				localized_print (debugger_names.m_debugger_environment_closed)
			end
		end

feature -- {DEBUGGER_MANAGER, SHARED_DEBUGGER_MANAGER} -- Implementation

	manager: TTY_DEBUGGER_MANAGER;

indexing
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
