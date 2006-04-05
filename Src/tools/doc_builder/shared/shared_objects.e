indexing
	description: "Shared Objects"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
end -- class SHARED_OBJECTS
