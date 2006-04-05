indexing
	description: "Shared system dialogs."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
end -- class SHARED_DIALOGS
