indexing
	description: "Shared system dialogs."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_DIALOGS

feature -- Access
	
	generation_dialog: GENERATION_DIALOG is
			-- Start dialog for generation wizard
		do
			create Result
		end

	template_dialog: TEMPLATE_DIALOG is
			-- Dialog for page templates
		once
			create Result
		end
			
	project_dialog: PROJECT_DIALOG is
			-- Dialog for project creation
		once
			create Result
		end
			
	about_dialog: ABOUT_DIALOG is
			-- Dialog for system information
		once
			create Result
		end
			
	preferences_dialog: PREFERENCES_DIALOG is
			-- Dialog for application preferences
		once
			create result
		end
			
	search_dialog: SEARCH_DIALOG is
			-- Dialog for text searching
		once
			create Result
		end
			
	error_dialog: ERROR_DIALOG is
			-- Dialog containing error information
		once
			create Result
		end
			
	progress_dialog: PROGRESS_DIALOG is
			-- Dialog for showing progress information
		do
			create Result
		end
			
	expression_dialog: EXPRESSION_DIALOG is
			-- Dialog for regular expressions
		once
			create Result
		end
		
	validator_tool: VALIDATOR_TOOL_DIALOG is
			-- Dialog for validation functions
		once
			create Result
		end	
			
	new_toc_dialog: TOC_NEW_DIALOG is
			-- Dialog for new toc creation
		once
			create Result
		end	
		
	toc_dialog: TOC_DIALOG is
			-- Dialog for toc properties
		once
			create Result
		end	
			
	toc_merge_dialog: TOC_MERGE_DIALOG is
			-- Dialog for toc merging
		once
			create Result
		end			
			
	character_dialog: CHARACTER_DIALOG is
			-- Dialog for special character codes
		once
			create Result
		end			
			
	shortcut_dialog: SHORTCUTS_DIALOG is
			-- Dialog for editor shortcuts
		once
			create Result
		end			
			
end -- class SHARED_DIALOGS
