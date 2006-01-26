indexing
	description: "Objects that is a command with a toggle button for diagram tool"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_CONTEXT_DIAGRAM_TOGGLE_COMMAND

feature -- Status setting

	enable_select is
			-- Make `Current' selected.
		do
			if current_button /= Void then
				if not current_button.is_selected then
					current_button.select_actions.block
					current_button.toggle
					current_button.select_actions.resume
				end
				current_button.set_tooltip (tooltip + shortcut_string)
			end
		end

	disable_select is
			-- Make `Current' deselected.
		do
			if current_button /= Void then
				if current_button.is_selected then
					current_button.select_actions.block
					current_button.toggle
					current_button.select_actions.resume
				end
				current_button.set_tooltip (tooltip + shortcut_string)
			end
		end

feature -- Access

	current_button: EB_COMMAND_TOGGLE_TOOL_BAR_BUTTON is
		deferred
		end

	tooltip: STRING is
		deferred
		end

	shortcut_string: STRING is
		deferred
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
