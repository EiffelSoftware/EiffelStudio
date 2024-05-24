note
	description: "Managers that are used throughout the application"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHARED_MANAGERS

inherit
	EB_SHARED_WINDOW_MANAGER

	EB_SHARED_PROCESS_IO_DATA_STORAGE

	PROJECT_CONTEXT

	EB_SHARED_METRIC_MANAGER

	EB_SHARED_SHORTCUT_MANAGER

feature -- Status report

	process_manager: EB_PROCESS_MANAGER
			-- Manager to manipulated processed spawned by Current process
		once
			create Result.make (freezing_launcher, finalizing_launcher, external_launcher)
		end

	external_launcher: EB_EXTERNAL_LAUNCHER
			-- Launcher to launch external processed used in external output tool
		once
			create Result.initialize
		end

	freezing_launcher: EB_C_COMPILER_LAUNCHER
			-- Launcher to launch c compiler for freezing.
		once
			create Result.make (False)
		end

	finalizing_launcher: EB_C_COMPILER_LAUNCHER
			-- Launcher to launch c compiler for finalizing.
		once
			create Result.make (True)
		end

	idle_printing_manager: EB_IDLE_PRINTING_MANAGER
			-- Manager to maintain output data got from launched processes
		once
			create Result.make
		end

	external_output_manager: EB_EXTERNAL_OUTPUT_MANAGER
			-- Manager for output from external processes
		do
			Result := external_output_manager_cell.item
		end

	recent_projects_manager: EB_RECENT_PROJECTS_MANAGER
			-- Manager for the recently opened projects.
		do
			Result := recent_projects_manager_cell.item
		end

	favorites: EB_FAVORITES
			-- Singleton Objects, this ensure that all windows use the
			-- same Favorites.
		once
			create Result
		end

	customized_formatter_manager: EB_CUSTOMIZED_FORMATTER_MANAGER
			-- Customized formatter manager
		once
			create Result
		end

	customized_tool_manager: EB_CUSTOMIZED_TOOL_MANAGER
			-- Customized tool manager
		once
			create Result
		end

	composer_manager: COMPOSER_MANAGER
			-- The composer manager.
		once
			create Result.make
		end

	Refactoring_manager: ERF_MANAGER
			-- The refactoring manager.
		once
			create Result.make
		end

	incoming_command_manager: ES_INCOMING_COMMAND_MANAGER
			-- Incoming command manager
		do
			Result := incoming_command_manager_cell.item
		end

	eis_manager: ES_EIS_MANAGER
			-- EIS manager
		once
			create Result
		end

feature {NONE} -- Implementation

	Recent_projects_manager_cell: CELL [EB_RECENT_PROJECTS_MANAGER]
			-- Recent projects manager for ebench
		once
			create Result.put (Void)
		end

	External_output_manager_cell: CELL [EB_EXTERNAL_OUTPUT_MANAGER]
			-- External output manager
		once
			create Result.put (Void)
		end

	incoming_command_manager_cell: CELL [ES_INCOMING_COMMAND_MANAGER]
			-- Incoming command manager
		once
			create Result.put (Void)
		end

note
	copyright:	"Copyright (c) 1984-2024, Eiffel Software"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EB_SHARED_MANAGERS
