note
	description: "[
		A windows-specific package implementation for the graphical version of escln.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	APPLICATION

inherit
	PACKAGE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize package
		local
			l_app: EV_APPLICATION
			l_window: EV_WINDOW
			l_site: SITE [PACKAGE]
		do
			create workbench_mode_change_actions

			create l_app
			l_window := create_main_window
			main_window := l_window
			l_site ?= l_window
			if l_site /= Void then
				l_site.set_site (Current)
			end
			l_window.close_request_actions.extend (agent l_app.destroy)
			l_window.show
			l_app.launch
			if l_site /= Void then
				l_site.set_site (Void)
			end
		end

feature {NONE} -- Access

	main_window: EV_WINDOW

feature {NONE} -- Factory functions

	create_main_window: EV_WINDOW
			-- Creates and initialize the main application window
		do
			create {MAIN_WINDOW}Result
		ensure
			result_attached: Result /= Void
		end

	create_path_provider: WINDOWS_PATH_PROVIDER
			-- Create a path provider
		do
			create Result.make (Current)
		end

	create_cleaner: WINDOWS_CLEANER
			-- Create a new configuration cleaner using the configuration `a_config'
			-- (export status {NONE})
		do
			create Result.make (Current)
		end

	create_backup_manager: WINDOWS_BACKUP_MANAGER
			-- Create a new configuration backup manager
		do
			create Result.make (Current)
		end

	create_error_displayer: ERROR_DISPLAYER
			-- Create a new error displayer
		do
			create Result.make (main_window)
		end

invariant
	main_window_attached: main_window /= Void

;note
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
