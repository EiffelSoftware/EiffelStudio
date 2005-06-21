indexing
	description: "A basic editor for EiffelStudio"
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EDITOR

inherit
	EDITABLE_TEXT_PANEL
		rename
			cursors as editor_cursors
		undefine
			font,
			line_height
		redefine
			handle_extended_ctrled_key,
			display_not_editable_warning_message,
			load_file,
			load_text,
			initialize_editor_context,
			reference_window
		end

	EB_SHARED_MANAGERS
		export
			{NONE} all
		undefine
			default_create
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create
		end

	EB_RECYCLABLE
		export
			{EB_RECYCLER} all
		undefine
			default_create
		end

	SHARED_EDITOR_FONT
		export
			{NONE} all
		undefine
			default_create
		end

	EB_SHARED_PREFERENCES
		undefine
			default_create
		end

create
	make
	
feature {NONE} -- Initialization

	 make is
			-- Initialize the editor.
		do
			default_create
			register_documents				
			unwanted_characters.extend ('%N')
		end

	initialize_editor_context is
			-- Here initialize editor contextual settings.  For example, set location of cursor pixmaps.
		do
			create syntax_files_path.make_from_string ((create {EIFFEL_ENV}).syntax_path)
			editor_cursors.set_editor_installation_dir_name ((create {EIFFEL_ENV}).cursor_path)			
			icons.set_editor_installation_dir_name ((create {EIFFEL_ENV}).bitmaps_path)			
		end	

	register_documents is
	 		-- Register known document types with this editor
	 	do
	 		register_document ("e", eiffel_class)
	 	end	 	
	 	
	 eiffel_class: DOCUMENT_CLASS is
	         -- Eiffel class
	   	once
			create Result.make ("eiffel", "e", Void)
	   	    Result.set_scanner (create {EDITOR_EIFFEL_SCANNER}.make)
	   	end
		
feature -- Warning messages display

	display_not_editable_warning_message is
				-- display warning message : text is not editable...
		local
			wm: STRING
			w: EB_TEXT_LOADING_WARNING_DIALOG
		do
			if text_displayed /= Void then
				if open_backup then
					show_warning_message (Warning_messages.w_Backup_file_not_editable)
				elseif is_read_only and then not allow_edition then
					if not_editable_warning_message = Void or else not_editable_warning_message.is_empty then
						wm := Warning_messages.w_Text_not_editable
					else
						wm := not_editable_warning_message
					end	
					show_warning_message (wm)
				else
					create w.make
					w.show_modal_to_window (reference_window)
				end
			end
		end	 

feature -- Access
	
	dev_window: EB_DEVELOPMENT_WINDOW
			-- Associated development window

feature -- Text Loading

	load_file (a_filename: STRING) is
	        -- Load contents of `a_filename'
		local
		    test_file, test_file_2: RAW_FILE
		    l_filename: FILE_NAME
  	   	do	
  	   		reset
  	   		load_file_error := False
  	   		
  	   		create l_filename.make_from_string (a_filename)
			create test_file.make (l_filename.string.twin)
			l_filename.add_extension ("swp")
			create test_file_2.make (l_filename)
			if test_file_2.exists and then test_file_2.is_readable and then ((not test_file.exists) or else test_file.date < test_file_2.date) then
				ask_if_opens_backup
				if not open_backup then
					test_file_2.delete
						-- Use original file
					create l_filename.make_from_string (a_filename)
				end
				Precursor (l_filename)
			else
				create l_filename.make_from_string (a_filename)
				Precursor (l_filename)
			end
  	  	end

	load_text (s: STRING) is
			-- Load text
		do			
			set_current_document_class (get_class_from_type (once "e"))
			Precursor {EDITABLE_TEXT_PANEL} (s)
		end		

feature {NONE} -- Handle keystokes

	handle_extended_ctrled_key (ev_key: EV_KEY) is
 			-- Process the push on Ctrl + an extended key.
		do	
			inspect
				ev_key.code

			when Key_u then
					-- Ctrl-U
				run_if_editable (agent set_selection_case(shifted_key))
				
			when Key_k then
				if shifted_key then
						-- Ctrl+Shift+K uncomment selection
					run_if_editable (agent uncomment_selection)
				else
						-- Ctrl+K
					run_if_editable (agent comment_selection)
				end
			else
				Precursor (ev_key)
			end
		end

feature {EB_COMMAND, EB_SEARCH_PERFORMER, EB_DEVELOPMENT_WINDOW} -- Edition Operations on text

	comment_selection is
			-- Comment selected lines.
		require
			text_is_not_empty: number_of_lines /= 0
			text_is_editable: is_editable
		do
			text_displayed.comment_selection
			refresh_now
		end

	uncomment_selection is
			-- Uncomment selected lines.
		require
			text_is_not_empty: number_of_lines /= 0
			text_is_editable: is_editable
		do
			text_displayed.uncomment_selection
			refresh_now
		end

feature {NONE} -- Retrieving backup

	ask_if_opens_backup is
			-- Display a dialog asking the user whether he wants to open
			-- the original file or the backup one, and set `open_backup' accordingly.
		local
			dial: EV_WARNING_DIALOG
		do
			create dial.make_with_text (Warning_messages.w_Found_backup)
			dial.set_buttons_and_actions (<<Interface_names.b_Open_backup, Interface_names.b_Open_original>>, <<agent open_backup_selected, agent open_normal_selected>>)
			dial.set_default_push_button (dial.button (Interface_names.b_Open_backup))
			dial.set_default_cancel_button (dial.button (Interface_names.b_Open_original))
			dial.set_title (Interface_names.t_Open_backup)
			dial.show_modal_to_window (reference_window)
		end
		
feature {NONE} -- Implementation

	reference_window: EV_WINDOW is
			-- Window which error dialogs will be shown relative to.
		do
			if internal_reference_window /= Void then
				Result := internal_reference_window
			else
				if dev_window /= Void and then dev_window.window /= Void then
					Result := dev_window.window
				else
					Result := Window_manager.last_focused_window.window
				end
				internal_reference_window := Result
			end
		end	
			
end -- class EDITOR
