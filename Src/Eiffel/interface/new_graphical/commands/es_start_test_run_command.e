indexing
	description: "[
						Start test run command
																]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_START_TEST_RUN_COMMAND

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
		do
			manager := a_manager
		ensure
			set: manager = a_manager
		end

	manager: !ES_EWEASEL_EXECUTION_MANAGER
			-- eweasel chief manager

feature -- Command

	execute is
			-- <Precursor>
		do
			manager.launch_eweasel (False)
			if manager.is_eweasel_running then
				disable_sensitive
				manager.start_test_run_failed_first_command.disable_sensitive
				manager.stop_test_run_command.enable_sensitive
			end
		end

feature -- Query

	executable: BOOLEAN is
			-- <Precursor>
		local
			l_factory: ES_EWEASEL_SINGLETON_FACTORY
		do
			create l_factory
			Result := l_factory.manager.testing_tool /= Void
		end

feature {ES_EWEASEL_TESTING_TOOL_PANEL} -- Implementation

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
		do
			Result := pixmaps.icon_pixmaps.debug_run_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.debug_run_icon_buffer
		end

	name: STRING_GENERAL is
			-- Name of the command. Used to store the command in the
			-- preferences.
		do
			Result := "Start_test_run"
		end

	tooltip: STRING_GENERAL is
			-- Tooltip for the toolbar button.
		do
			Result := interface_names.t_run_last_tests
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
