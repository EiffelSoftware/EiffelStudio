indexing
	description: "Managers that are used throughout the application"
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

end -- class EB_SHARED_MANAGERS
