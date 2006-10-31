indexing
	description: "A basic editor"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GENERIC_EDITOR

inherit
	EDITABLE_TEXT_PANEL
		redefine
			handle_extended_ctrled_key,
			reference_window,
			initialize_editor_context
		end

feature -- Initialization		
	
	initialize_editor_context is
			-- Here initialize editor contextual settings.  For example, set location of cursor
			-- pixmaps.
		do
			cursors.set_editor_installation_dir_name (cursor_path)
			icons.set_editor_installation_dir_name (icons_path)						
		end	
		
	icons_path, cursor_path: DIRECTORY_NAME is
			-- Paths
		local
			l_env: EXECUTION_ENVIRONMENT
		once
			create l_env
			create Result.make_from_string (l_env.current_working_directory)	
			Result.extend ("bitmaps")
		end		
		
	reference_window: EV_WINDOW is
			-- Reference window
		once
			create Result
		end		
		
	handle_extended_ctrled_key (ev_key: EV_KEY) is
 			-- Process the push on Ctrl + an extended key.
		do
			inspect
				ev_key.code
			when Key_s then
					-- Ctrl-S (save)
				save_current_document
			else
				Precursor (ev_key)
			end
		end
		
	save_current_document is
			-- Save the document currently loaded
		local
			l_save_dialog: EV_FILE_SAVE_DIALOG
		do
			create l_save_dialog
			l_save_dialog.show_modal_to_window (reference_window)
			if l_save_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_save) then
				write_to_disk (l_save_dialog.file_name)
			end
		end		
		
	write_to_disk (a_filename: STRING) is
			-- Write Current text to disk
		local
			file: PLAIN_TEXT_FILE
		do			
			create file.make_open_write (a_filename)
			if file.is_open_write then					
				file.putstring (text_displayed.text)
				date_of_file_when_loaded := file.date
				file.flush
				file.close
			end
		end
		
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class EDITOR
