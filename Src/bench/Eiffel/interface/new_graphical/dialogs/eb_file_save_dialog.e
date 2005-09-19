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
		rename
			show_modal_to_window as standard_show_modal_to_window
		select
			implementation,
			save_actions
		end
		
	EB_FILE_DIALOG
		rename
			ok_actions as standard_ok_actions,
			implementation as file_dialog_implementation
		select
			show_modal_to_window
		end
		
create
	make_with_preference
	
end
