indexing
	description	: "Dialog asking the user if he wants to convert an old project."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CONFIRM_CONVERT_PROJECT_DIALOG

inherit
	EB_DISCARDABLE_CONFIRMATION_DIALOG

create
	make
	
feature {NONE} -- Initialization

	make (a_dir_name: STRING; a_comp_version: STRING; a_incomp_version: STRING) is
			-- Create a warning dialog box.
		do
			dir_name := a_dir_name
			comp_version := a_comp_version
			incomp_version := a_incomp_version
			default_create
		end

feature -- Access
	
	Buttons_count: INTEGER is 2

feature {NONE} -- Deferred Constants

	check_button_label: STRING is
			-- Label for `check_button'.
		do
			Result := Interface_names.l_Discard_convert_project_dialog
		end

	confirmation_message_label: STRING is
			-- Label for the confirmation message.
		do
			Result := Warning_messages.w_Project_incompatible_version (dir_name, comp_version, incomp_version)
		end

feature {NONE} -- Deferred Implementation

	assume_ok: BOOLEAN is
			-- Should `Ok' be assumed as selected?
		do
			Result := not confirm_convert_project
		end

	save_check_button_state (check_button_checked: BOOLEAN)is
			-- Save the preferences according to the state of the check button.
		do
			set_confirm_convert_project (not check_button_checked)
		end
		
feature {NONE} -- Implementation

	dir_name: STRING
			-- Directory name of old project
			
	comp_version: STRING
			-- Old version
			
	incomp_version: STRING
			-- New version

end -- class EB_CONFIRM_CONVERT_PROJECT_DIALOG
