indexing
	description: "[
							Command to find all test case classes in system
																																				]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_FIND_TEST_CASE_COMMAND

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			executable
		end

create
	make

feature {NONE} -- Initialization

	make (a_manager: like manager) is
			-- Creation method
		local
			l_shared: SHARED_EIFFEL_PROJECT
		do
			manager := a_manager

			create l_shared
			if l_shared.eiffel_project.manager.is_project_loaded then
				enable_sensitive
			else
				l_shared.eiffel_project.manager.load_agents.extend_kamikaze (agent enable_sensitive)
			end
		ensure
			set: manager = a_manager
		end

	manager: !ES_EWEASEL_EXECUTION_MANAGER
			-- eweasel chief manager

feature -- Command

	execute is
			-- <Precursor>
		local
			l_finder: ES_TEST_CASE_FINDER
			l_command: EB_SHARED_GRAPHICAL_COMMANDS
			l_melt_command: EB_DISCOVER_AND_MELT_COMMAND
		do
			create l_finder
			l_finder.add_hook

			create l_command
			l_melt_command := l_command.discover_melt_cmd
			if l_melt_command.executable then
				l_melt_command.execute
			end

			l_finder.remove_hook
		end

feature -- Query

	executable: BOOLEAN is
			-- <Precursor>
		local
			l_shared: SHARED_EIFFEL_PROJECT
		do
			create l_shared
			Result := l_shared.eiffel_project.manager.is_project_loaded
		end

feature {ES_TESTING_TOOL_PANEL} -- Implementation

	menu_name: STRING_GENERAL is
			-- Name as it appears in the menu (with & symbol).
		do
		end

	description: STRING_GENERAL is
			-- Description for this command.
		do
			Result := tooltip
		end

	pixmap: EV_PIXMAP is
			-- Pixmap representing the command.
		once
			Result := pixel_buffer.to_pixmap
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representing the command.
		local
			l_orignal: EV_PIXEL_BUFFER
			l_overlay: EV_PIXEL_BUFFER
			l_pixmaps: ES_PIXMAPS_16X16
		once
			l_pixmaps := pixmaps.icon_pixmaps
			l_orignal := l_pixmaps.testing_tool_icon_buffer
			l_overlay := l_pixmaps.overlay_search_icon_buffer
			Result := l_pixmaps.icon_buffer_with_overlay (l_orignal, l_overlay, 0, 0)
		end

	name: STRING_GENERAL is
			-- Name of the command. Used to store the command in the
			-- preferences.
		do
			Result := "Find_test_case_classes"
		end

	tooltip: STRING_GENERAL is
			-- Tooltip for the toolbar button.
		do
			Result := interface_names.t_Find_test_case_classes
		end

indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
