indexing
	description: "New project creation dialog."
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
		
	valid: BOOLEAN
			-- Were optins valid?

end -- class PROJECT_DIALOG

