indexing
	description: "[
		A command to navigate to the previous warning in the warnings and warnings tool list {ES_ERRORS_AND_WARNINGS_TOOL}
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	ES_PREVIOUS_WARNING_COMMAND

inherit
	ES_ERROR_LIST_COMMAND
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make (a_commander: like tool_commander)
			-- Initialize command using a tool commander
			--
			-- `a_commander': A errors and warnings tool commander
		local
			l_shortcut: SHORTCUT_PREFERENCE
		do
			Precursor {ES_ERROR_LIST_COMMAND} (a_commander)
			l_shortcut := preferences.misc_shortcut_data.shortcuts.item ("go_to_previous_warning")
			check shortcut_attached: l_shortcut /= Void end
			if l_shortcut /= Void then
				set_global_shortcut (l_shortcut)
			end
		end

feature -- Access

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer which representing the command.
		once
			Result := pixmaps.icon_pixmaps.errors_and_warnings_previous_warning_icon_buffer
		end

	menu_name: STRING_GENERAL
			-- Name as it appears in the menu (with '&' symbol).
		do
			Result := interface_names.m_go_to_previous_warning
		end

	description: STRING_GENERAL
			-- Description of the command as it appears in the
			-- "customize" dialog.
		do
			Result := interface_names.l_go_to_previous_warning
		end

	tooltip: STRING_GENERAL
			-- Tooltip for the toolbar button.
		do
			Result := interface_names.f_go_to_previous_warning
		end

feature -- Execution

	execute
			-- Execute Current command.
		do
			tool_commander.go_to_previous_warning (True)
		end

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
