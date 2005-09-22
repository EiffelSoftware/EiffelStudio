indexing
	description: "[
		Objects that represent file open dialogs which remember their previous directory
		if the "preferences.dialog_data.file_open_and_save_dialogs_remember_last_directory" preference
		is True
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FILE_OPEN_DIALOG
	
inherit
	EV_FILE_OPEN_DIALOG
		undefine
			show_modal_to_window
		redefine
			implementation
		end
		
	EB_FILE_DIALOG
		rename
			ok_actions as open_actions
		redefine
			implementation
		end
		
create
	make_with_preference

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_FILE_OPEN_DIALOG_I
		-- Responsible for interaction with native graphics toolkit.

end
