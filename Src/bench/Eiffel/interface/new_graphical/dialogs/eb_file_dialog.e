indexing
	description: "[
		Objects that represent file dialogs which remember their previous directory
		if the "preferences.dialog_data.file_open_and_save_dialogs_remember_last_directory" preference
		is True
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_FILE_DIALOG
	
inherit
	EV_FILE_DIALOG
		redefine
			show_modal_to_window
		end
		
	EB_SHARED_PREFERENCES
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end
			
feature {NONE} -- Initialization
	
	make_with_preference (a_preference: STRING_PREFERENCE) is
			-- Create `Current' and assign `a_preference' to `preference'.
		require
			a_preference_not_void: a_preference /= Void
		do
			default_create
			preference := a_preference
		end
		
feature -- Access

	preference: STRING_PREFERENCE
		-- Preference associated with `Current' which
		-- stores the last selected directory opened

feature -- Status setting

	show_modal_to_window (a_window: EV_WINDOW) is
			-- Show `Current' modal to window `a_window'.
		local
			last_directory: STRING
			dir: DIRECTORY
		do
			last_directory := preference.string_value
			if not last_directory.is_empty then
					-- Nothing to do if the preference is empty.
				create dir.make (last_directory)
				if dir.exists and preferences.dialog_data.file_open_and_save_dialogs_remember_last_directory.value then
						-- Only set the start directory if the directory exists and the remember preference is enabled.
					set_start_directory (last_directory)
				end
			end
			Precursor {EV_FILE_DIALOG} (a_window)
			update_preference
		end		

	update_preference is
			-- Update value of `preference' from `file_path'.
		do
			if not file_path.is_empty then
				preference.set_value (file_path)
			end
		end

invariant
	preference_not_void: preference /= Void

end
