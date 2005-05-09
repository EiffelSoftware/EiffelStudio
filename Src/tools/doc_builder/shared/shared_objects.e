indexing
	description: "Shared Objects"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_OBJECTS

feature -- Once objects

	Application_window: DOC_BUILDER_WINDOW is
			-- Root application window
		once
			if window_cell /= Void then
				Result := window_cell.item	
			end
		end

	Shared_error_reporter: ERROR_REPORT is
			-- Shared reporter for various types of errors
		once
			create Result
		end		

	Shared_project: DOCUMENT_PROJECT is
			-- Document Project
		once
			create Result
		end

	Shared_document_editor_commands: DOCUMENT_EDITOR_COMMANDS is
			-- Document Editor
		once
			create Result
		end

	Shared_search_control: SEARCH_CONTROL is
			-- Editor search control
		once
			create Result.make
		end

	Shared_document_manager: DOCUMENT_MANAGER is
			-- Document Manager
		once
			create Result.make
		end
		
	Shared_help_manager: HELP_MANAGER is
			-- Help Manager
		once
			create Result	
		end		
		
	Shared_toc_manager: TABLE_OF_CONTENTS_MANAGER is
			-- Table of Content manage
		once
			create Result.make
		end		
		
	Shared_web_browser: WEB_BROWSER_WIDGET is
			-- Object used for web browsing and XSLT output display
		once
			create Result.make
		end		

	Generation_data: GENERATION_INFORMATION is
			-- Generation data
		once
			create Result
		end
		
	progress_generator: GENERATOR is
			-- Generator
		once
			create Result
			Result.set_graphical_mode (Shared_constants.Application_constants.is_gui_mode)
			Result.suppress_progress_bar (False)
		end

feature -- Shared
	
	Shared_dialogs: SHARED_DIALOGS is
			-- System dialogs
		once
			create Result
		end
		
	Shared_constants: SHARED_CONSTANTS is
			-- Shared constants
		once 
			create Result
		end

	Shared_preferences: SHARED_PREFERENCES is
			-- System dialogs
		once
			create Result
		end

feature {NONE} -- Status Setting

	set_root_window (window: DOC_BUILDER_WINDOW) is
			-- The main application window
		do
			window_cell.put (window)
		ensure
			window_cell_set: window_cell.item = window
		end
		
	window_cell: CELL [DOC_BUILDER_WINDOW] is
			-- Window Container
		once
			create Result.put (Void)
		end		

end -- class SHARED_OBJECTS
