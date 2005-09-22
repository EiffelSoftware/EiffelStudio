indexing
	description: "[
		Objects that represent file save dialogs which remember their previous directory
		if the "preferences.dialog_data.file_open_and_save_dialogs_remember_last_directory" preference
		is True
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FILE_SAVE_DIALOG
	
inherit
	EV_FILE_SAVE_DIALOG
		undefine
			show_modal_to_window
		redefine
			implementation
		end
		
	EB_FILE_DIALOG
		rename
			ok_actions as save_actions
		redefine
			implementation
		end
		
create
	make_with_preference

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_FILE_SAVE_DIALOG_I
		-- Responsible for interaction with native graphics toolkit.

end
