note
	description: "Objects that is a command with a toggle button for diagram tool"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_CONTEXT_DIAGRAM_TOGGLE_COMMAND

feature -- Status setting

	enable_select
			-- Make `Current' selected.
		local
			l_string: STRING_GENERAL
		do
			if current_button /= Void then
				if not current_button.is_selected then
					current_button.select_actions.block
					current_button.enable_select
					current_button.select_actions.resume
				end
				l_string := tooltip.twin
				if not shortcut_string.is_empty then
					l_string.append (" (")
					l_string.append (shortcut_string.as_string_32)
					l_string.append (")")
				end
				current_button.set_tooltip (l_string)
			end
		end

	disable_select
			-- Make `Current' deselected.
		local
			l_string: STRING_GENERAL
		do
			if current_button /= Void then
				if current_button.is_selected then
					current_button.select_actions.block
					current_button.disable_select
					current_button.select_actions.resume
				end
				l_string := tooltip.twin
				if not shortcut_string.is_empty then
					l_string.append (" (")
					l_string.append (shortcut_string.as_string_32)
					l_string.append (")")
				end
				current_button.set_tooltip (l_string)
			end
		end

feature -- Access

	current_button: EB_SD_COMMAND_TOOL_BAR_TOGGLE_BUTTON
		deferred
		end

	tooltip: STRING_GENERAL
		deferred
		end

	menu_name: STRING_GENERAL
			-- Name on corresponding menu items
		do
			Result := tooltip
		end

	shortcut_string: STRING_GENERAL
		deferred
		ensure
			Result_not_void: Result /= Void
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

end -- class EB_CONTEXT_DIAGRAM_TOGGLE_COMMAND
