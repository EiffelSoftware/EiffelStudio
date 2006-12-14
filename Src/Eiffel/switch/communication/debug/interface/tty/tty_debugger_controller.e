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
			before_starting,
			after_starting,
			if_confirmed_do,
			discardable_if_confirmed_do,
			activate_debugger_environment
		end

feature

	before_starting is
		do
			Precursor
			manager.display_debugger_info
		end

	after_starting is
		do
			Precursor
		end

	if_confirmed_do (msg: STRING; a_action: PROCEDURE [ANY, TUPLE]) is
		local
			is_yes: BOOLEAN
		do
			io.put_string (msg + " [y/n] ?")
			io.read_line
			is_yes := io.last_string.is_empty or else io.last_string.item (1).is_equal ('y')
			if is_yes then
				a_action.call (Void)
			end
		end

	discardable_if_confirmed_do (msg: STRING; a_action: PROCEDURE [ANY, TUPLE];
			a_button_count: INTEGER; a_pref_string: STRING) is
		local
			bp: BOOLEAN_PREFERENCE
		do
			bp ?= preferences.preferences.get_preference (a_pref_string)
			if bp /= Void and then bp.value then
				a_action.call (Void)
			else
				if_confirmed_do (msg, a_action)
			end
		end

	activate_debugger_environment (b: BOOLEAN) is
		do
			Precursor {DEBUGGER_CONTROLLER} (b)
			if b then
				io.put_string ("Debugger environment started%N")
			else
				io.put_string ("Debugger environment closed%N")
			end
		end

feature {NONE} -- Implementation

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
