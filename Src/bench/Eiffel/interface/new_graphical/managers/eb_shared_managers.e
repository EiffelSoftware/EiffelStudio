indexing
	description: "Managers that are used throughout the application"
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHARED_MANAGERS

inherit
	EB_SHARED_WINDOW_MANAGER

feature -- Status report

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

end -- class EB_SHARED_MANAGERS
