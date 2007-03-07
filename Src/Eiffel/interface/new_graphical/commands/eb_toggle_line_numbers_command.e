indexing
	description: "Toggle line numbers in editors."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_TOGGLE_LINE_NUMBERS_COMMAND

inherit

	EB_EDITOR_COMMAND
		redefine
			make
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	make is
			-- New command
		do
			Precursor {EB_EDITOR_COMMAND}
			initialize
		end

feature -- Execution

	initialize is
			-- Initialize
		local
			l_shortcut: SHORTCUT_PREFERENCE
		do
			menu_name := Interface_names.m_line_numbers
			l_shortcut := preferences.editor_data.shortcuts.item ("toggle_line_number_visibility")
			create accelerator.make_with_key_combination (l_shortcut.key, l_shortcut.is_ctrl, l_shortcut.is_alt, l_shortcut.is_shift)
			accelerator.actions.extend (agent execute)
			execute_agents.extend (agent execute_toggle)
			set_referred_shortcut (l_shortcut)
			enable_sensitive
		end

	execute_toggle is
			-- Execute the command.
		do
			if is_sensitive then
				preferences.editor_data.show_line_numbers_preference.set_value (not preferences.editor_data.show_line_numbers)
			end
		end

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
