indexing
	description: "New project creation dialog."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PROJECT_DIALOG

inherit
	PROJECT_DIALOG_IMP
	
	SHARED_OBJECTS
		undefine
			copy,
			default_create
		end

feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			browse_button.select_actions.extend (agent browse_directories)
			create_button.select_actions.extend (agent create_project)
			cancel_btn.select_actions.extend (agent hide)
		end

feature {NONE} -- Implementation

	browse_directories is
			-- Browse Directories
		local
			l_directory_dialog: EV_DIRECTORY_DIALOG
		do
			create l_directory_dialog
			l_directory_dialog.show_modal_to_window (Application_window)
			if l_directory_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_ok) then
				set_path_field (l_directory_dialog.directory)
			end
		end

	create_project is
			-- Create new project
		local
			l_question_dialog: EV_MESSAGE_DIALOG
		do
			if name_field.text.is_empty or path_field.text.is_empty then
				create l_question_dialog.make_with_text ((create {MESSAGE_CONSTANTS}).invalid_project_name)
				l_question_dialog.set_title ((create {MESSAGE_CONSTANTS}).invalid_project_name_title)
				l_question_dialog.set_buttons (<<(create {EV_DIALOG_CONSTANTS}).ev_ok>>)
				l_question_dialog.show_modal_to_window (Current)
				if l_question_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_ok) then
					l_question_dialog.destroy
				end
				valid := False
			else
				valid := True
				Shared_project.set_name (name_field.text)
				Shared_project.set_root_directory (path_field.text)
				hide
			end			
		end

	set_path_field (a_location: STRING) is
			-- Set path field with directory path
		do
			path_field.set_text (a_location)	
		end	

feature {DOCUMENT_PROJECT} -- Implementation
		
	valid: BOOLEAN;
			-- Were options valid?

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
end -- class PROJECT_DIALOG

