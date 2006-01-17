indexing
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

feature -- Status report

	process_manager: EB_PROCESS_MANAGER is
			--
		once
			create Result.make (freezing_launcher, finalizing_launcher, external_launcher)
		end

	external_launcher: EB_EXTERNAL_LAUNCHER is
			--
		once
			create Result.initialize
		end

	freezing_launcher: EB_FREEZING_LAUNCHER is
			--
		once
			create Result.make
		end

	finalizing_launcher: EB_FINALIZING_LAUNCHER is
			--
		once
			create Result.make
		end

	idle_printing_manager: EB_IDLE_PRINTING_MANAGER is
			--
		once
			create Result.make
		end

	external_output_manager: EB_EXTERNAL_OUTPUT_MANAGER is
			--
		do
			Result := external_output_manager_cell.item
		end

	c_compilation_output_manager: EB_C_COMPILATION_OUTPUT_MANAGER is
			--
		do
			Result := c_compilation_output_manager_cell.item
		end

	output_manager: EB_OUTPUT_MANAGER is
			-- Output manager for all output messages.
		do
			Result := output_manager_cell.item
		end

	graphical_output_manager: EB_GRAPHICAL_OUTPUT_MANAGER is
			-- Output manager for all output tool in Development windows.
		do
			Result ?= output_manager_cell.item
		end

	recent_projects_manager: EB_RECENT_PROJECTS_MANAGER is
			-- Manager for the recently opened projects.
		do
			Result := recent_projects_manager_cell.item
		end

	favorites: EB_FAVORITES is
			-- Singleton Objects, this ensure that all windows use the
			-- same Favorites.
		once
			create Result
		end

feature {NONE} -- Implementation

	Recent_projects_manager_cell: CELL [EB_RECENT_PROJECTS_MANAGER] is
			-- Recent projects manager for ebench
		once
			create Result.put (Void)
		end

	Output_manager_cell: CELL [EB_OUTPUT_MANAGER] is
			-- Output manager for development windows	
		once
			create Result.put (Void)
		end

	External_output_manager_cell: CELL [EB_EXTERNAL_OUTPUT_MANAGER] is
			--
		once
			create Result.put (Void)
		end

	C_compilation_output_manager_cell: CELL [EB_C_COMPILATION_OUTPUT_MANAGER] is
			--
		once
			create Result.put (Void)
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

end -- class EB_SHARED_MANAGERS
