class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			on_menu_command,
			on_control_id_command,
			on_accelerator_command,
			on_wm_erase_background,
			on_size,
			on_notify
		end

	OUTPUT_WINDOW
	
	STORABLE
		rename
			class_name as storable_class_name
		end

	SHARED_DATA
		export
			{NONE} all
		end

	WIZARD_ROUTINES
		export
			{NONE} all
		end

	APPLICATION_IDS
		export
			{NONE} all
		end
		
	WEL_WS_CONSTANTS
		export
			{NONE} all
		end

	WEL_ES_CONSTANTS
		export
			{NONE} all
		end

	WEL_OFN_CONSTANTS
		export
			{NONE} all
		end
		
	OPERATING_ENVIRONMENT
		export
			{NONE} all
		end

	WEL_STANDARD_TOOL_BAR_BITMAP_CONSTANTS
		export
			{NONE} all
		end

	WEL_IDB_CONSTANTS
		export
			{NONE} all
		end

	WEL_TTN_CONSTANTS
		export
			{NONE} all
		end

	WEL_TB_STYLE_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Create the main window.
		do
			state := Initial_state
			create lines.make
			create previous_states.make
			create msg_box.make
			make_top (Title)
			set_menu (main_menu)
			setup_output_edit
			create initial_dialog.make (Current)
			create idl_dialog.make (Current)
			create ps_dialog.make (Current)
			create final_dialog.make (Current)
			resize (400, 400)
		end

feature -- GUI Elements

	msg_box: WEL_MSG_BOX
			-- Message box

	Output_edit: WEL_RICH_EDIT
			-- Output edit

	rebar: WEL_REBAR is
			-- Create and initialise toolbar.
		local
			open_button, new_button, save_button, launch_button,
			clear_button, separator_button: WEL_TOOL_BAR_BUTTON
			rebar_info: WEL_REBARBANDINFO
			tool_bar, too: WEL_TOOL_BAR
		once
			create Result.make (Current, -1)
			create tool_bar.make (Current, -1)
			tool_bar.set_style (tool_bar.style + Tbstyle_flat)
			tool_bar.add_bitmaps (create {WEL_TOOL_BAR_BITMAP}.make_by_predefined_id (Idb_std_small_color), 1)
			create new_button.make_button (tool_bar.last_bitmap_index + Std_filenew, New_id)
			create open_button.make_button (tool_bar.last_bitmap_index + Std_fileopen, Open_id)
			create save_button.make_button (tool_bar.last_bitmap_index + Std_filesave, Save_id)
			create separator_button.make_separator
			tool_bar.add_bitmaps (create {WEL_TOOL_BAR_BITMAP}.make (Toolbar_bitmap_constant), 1)
			create clear_button.make_button (tool_bar.last_bitmap_index, Clear_id)
			create launch_button.make_button (tool_bar.last_bitmap_index + 1, Launch_id)
			tool_bar.add_buttons (<<new_button, open_button, save_button, separator_button, launch_button, clear_button>>)
			create rebar_info.make
			rebar_info.set_unpositionable_child (tool_bar)
			rebar_info.set_child_minimum_width (100)
			rebar_info.set_child_minimum_height (28)
			Result.prepend_band (rebar_info)
			Result.reposition
		end
	
	initial_dialog: WIZARD_INITIAL_DIALOG
			-- Wizard initial dialog

	idl_dialog: WIZARD_IDL_DIALOG
			-- Wizard IDL dialog
	
	ps_dialog: WIZARD_PS_DIALOG
			-- Wizard Proxy/Stub dialog
	
	final_dialog: WIZARD_FINAL_DIALOG
			-- Wizard final dialog

	Title: STRING is "EiffelCOM Wizard"
			-- Window title

	main_menu: WEL_MENU is
			-- Main menu
		once
			create Result.make
			Result.append_popup (file_menu, "&File")
			Result.append_popup (build_menu, "&Build")
		ensure
			main_menu_not_void: Result /= Void
		end

	file_menu: WEL_MENU is
			-- File menu
		once
			create Result.make
			Result.append_string ("&New", New_id)
			Result.append_string ("&Open", Open_id)
			Result.append_string ("&Save", Save_id)
			Result.append_separator
			Result.append_string ("E&xit", Exit_id)
		ensure
			file_menu_not_void: Result /= Void
		end

	build_menu: WEL_MENU is
			-- Build menu
		once
			create Result.make
			Result.append_string ("&Launch Wizard", Launch_id)
			Result.append_string ("&Clear Output", Clear_id)
		ensure
			buil_menu_not_void: Result /= Void
		end

	open_file_dialog: WEL_OPEN_FILE_DIALOG is
			-- Open file dialog
		once
			create Result.make
			Result.add_flag (Ofn_filemustexist)
			Result.set_filter (<<"EiffelCOM Wizard Project (*.ewz)", "All Files (*.*)">>, <<"*.ewz", "*.*">>)
		end

	save_file_dialog: WEL_SAVE_FILE_DIALOG is
			-- Open file dialog
		once
			create Result.make
			Result.add_flag (Ofn_pathmustexist)
			Result.set_filter (<<"EiffelCOM Wizard Project (*.ewz)", "All Files (*.*)">>, <<"*.ewz", "*.*">>)
		end

	Background_color: WEL_COLOR_REF is
			-- Text output background color
		once
			create Result.make_rgb (210, 210, 210)
		end

	Text_color: WEL_COLOR_REF is
			-- Text output color
		once
			create Result.make_rgb (0, 0, 0)
		end

feature -- Element Change

	new_line is
			-- Begin a new line.
		do
			add_text ("%R%N")
		end

	add_text (a_text: STRING) is
			-- Add text `a_text' into window's text
		do
			output_edit.set_caret_position (output_edit.count)
			output_edit.insert_text (a_text)
		end
	
	add_title (a_title: STRING) is
			-- Add title `a_title' to window's text
		do
			output_edit.set_caret_position (output_edit.count)
			output_edit.set_character_format_word (Title_format)
			output_edit.insert_text (a_title)
		end

	clear is
			-- Clear window text.
		do
			output_edit.set_text (Initial_text)
		end

feature {WIZARD_MANAGER} -- Basic Operations

	process_messages is
			-- Process messages in queue.
		do
			from
				win_msg.peek_all
			until
				not win_msg.last_boolean_result
			loop
				if win_msg.last_boolean_result then
					win_msg.translate
					win_msg.dispatch
				end
				win_msg.peek_all
			end
		end

feature {NONE} -- State management

	Initial_state, Idl_state, Ps_state, Final_state, Finished_state, Abort_state: INTEGER is unique
			-- Possible states

	state: INTEGER
			-- Current state

	previous_states: LINKED_LIST [INTEGER]
			-- Previously taken states

	current_dialog: WEL_DIALOG is
			-- Current state dialog
		do
			inspect
				state
			when Initial_state then
				Result := Initial_dialog
			when Idl_state then
				Result := Idl_dialog
			when Ps_state then
				Result := Ps_dialog
			when Final_state then
				Result := Final_dialog
			else
			end
		end

	start is
			-- Start state machine.
		do
			from
				previous_states.extend (Abort_state)
				state := Initial_state
				shared_wizard_environment.set_no_abort
			until
				state = Finished_state or state = Abort_state
			loop
				current_dialog.activate
				change_state (current_dialog.ok_pushed)
			end
			if not (state = Abort_state) then
				create wizard_manager.make (Current)
				wizard_manager.run
			end
		end

	change_state (move_to_next: BOOLEAN) is
			-- Set `state' to next state according to `move_to_next'.
		do
			if shared_wizard_environment.abort then
				state := Abort_state
			elseif move_to_next then
				previous_states.extend (state)
				inspect
					state
				when Initial_state then
					if shared_wizard_environment.idl then
						state := Idl_state
					else
						state := Ps_state
					end
				when Idl_state, Ps_state then
					state := Final_state
				when Final_state then
					state := Finished_state
				else
				end
			else
				previous_states.finish
				check
					previous_state_exists: not previous_states.before
				end
				state := previous_states.item
				previous_states.remove
			end
		end

feature {NONE} -- Implementation

	setup_output_edit is
			-- Initialize output edit.
		do
			create output_edit.make (Current, Output_edit_name, 0, client_rect.y + rebar.height, width, height - rebar.height, -1)
			output_edit.set_text (Initial_text)
			output_edit.set_character_format_all (Window_character_format)
			output_edit.set_style (Ws_visible + Ws_child + Ws_group + Ws_tabstop + Ws_vscroll + Ws_hscroll + Es_left + Es_autohscroll + Es_autovscroll + Es_multiline)
			output_edit.set_read_only
			output_edit.enable_scroll_caret_at_selection
			output_edit.set_background_color (Background_color)
		end

	lines: LINKED_LIST [STRING]
			-- Window text

	code_generator: WIZARD_CODE_GENERATOR
			-- Code generator

	wizard_manager: WIZARD_MANAGER
			-- Code generation manager

	Window_character_format: WEL_CHARACTER_FORMAT is
			-- Window character format
		once
			create Result.make
			Result.set_face_name ("Tahoma")
			Result.set_height (160)
			Result.unset_bold
			Result.set_text_color (Text_color)
		end

	Title_format: WEL_CHARACTER_FORMAT is
			-- Window character format
		once
			create Result.make
			Result.set_face_name ("Tahoma")
			Result.set_height (160)
			Result.set_bold
			Result.set_text_color (Text_color)
		end

	clean is
			-- Delete temporary generated files.
		do
			delete_file (Generated_iid_file_name)
			delete_file (Generated_header_file_name)
			delete_file (Generated_dlldata_file_name)
			delete_file (Generated_ps_file_name)
			delete_file (shared_wizard_environment.type_library_file_name)
			delete_file (c_to_obj (Generated_iid_file_name))
			delete_file (c_to_obj (Generated_dlldata_file_name))
			delete_file (c_to_obj (Generated_ps_file_name))
			delete_file (Def_file_name)
		end

	delete_file (a_file_name: STRING) is
			-- Delete file `a_file_name' from Wizard destination folder.
		require
			non_void_file_name: a_file_name /= Void
			valid_file_name: not a_file_name.empty
		local
			a_string: STRING
			a_file: RAW_FILE
		do
			a_string := clone (shared_wizard_environment.destination_folder)
			a_string.append_character (directory_separator)
			a_string.append (a_file_name)
			create a_file.make (a_string)
			if a_file.exists then
				a_file.delete
			end
		end

	win_msg: WEL_MSG is
			-- Used by `process_messages'
		once
			!! Result.make
		end

	open_project (a_project: STRING) is
			-- Open previous project saved in `a_project'.
		local
			retried: BOOLEAN
			an_environment: WIZARD_ENVIRONMENT
		do
			if not retried then
				an_environment ?= retrieve_by_name (a_project)
				if an_environment /= Void then
					set_shared_wizard_environment (an_environment)
					new_line
					add_text (Open_message)
				else
					new_line
					add_text (Open_error_message)
				end
			else
				new_line
				add_text (Open_error_message)
			end
			new_line
			new_line
		rescue
			retried := True
			retry
		end

	save_project (a_project: STRING) is
			-- Save project in `a_project'.
		local
			retried: BOOLEAN
		do
			if not retried then
				shared_wizard_environment.store_by_name (a_project)
				new_line
				add_text (Save_message)
			else
				new_line
				add_text (Save_error_message)
			end
			new_line
			new_line
		rescue
			retried := True
			retry
		end

	Open_error_message: STRING is "ERROR: File does not include a valid project description"
			-- Open project error message
	
	Save_error_message: STRING is "ERROR: Could not save project."
			-- Project save error message

	Open_message: STRING is "Project Loaded."
			-- Open project message

	Save_message: STRING is "Project Saved."
			-- Save project message

	Output_edit_name: STRING is "Output"
			-- Output edit name

	Initial_text: STRING is "Ready.%R%N%R%N"
			-- Output edit initial text

feature {NONE} -- Behavior

	on_menu_command (menu_id: INTEGER) is
			-- `menu_id' has been selected
		do
			inspect
				menu_id
			when Launch_id then
				start
			when Exit_id then
				destroy			
			when Clear_id then
				clear
			when Open_id then
				open_file_dialog.activate (Current)
				if open_file_dialog.selected then
					open_project (open_file_dialog.file_name)
				end
			when Save_id then
				save_file_dialog.activate (Current)
				if save_file_dialog.selected then
					save_project (save_file_dialog.file_name)
				end
			When New_id then
				set_shared_wizard_environment (create {WIZARD_ENVIRONMENT}.make)
			else
			end
		end

	on_control_id_command (control_id: INTEGER) is
			-- Perform control id command actions
			--| Delegate to on_menu_command
		do
			on_menu_command (control_id)
		end -- on_control_id_command

	on_accelerator_command (accelerator_id: INTEGER) is
			-- Perform accelerator command actions
			--| Delegate to on_menu_command
		do
			on_menu_command (accelerator_id)
		end -- on_accelerator_command

	on_notify (a_control_id: INTEGER; info: WEL_NMHDR) is
			-- Display tooltips.
		local
			tt1: WEL_TOOLTIP_TEXT
		do
			if info.code = Ttn_needtext then
				create tt1.make_by_nmhdr (info)
				tt1.set_text_id (tt1.hdr.id_from)
			end
		end

   	on_size (size_type, a_width, a_height: INTEGER) is
			-- Wm_size message
		do
			if output_edit /= Void then
				output_edit.resize (a_width, a_height - client_rect.y - rebar.height)
			end
		end

   	on_wm_erase_background (wparam: INTEGER) is
   			-- Wm_paint message.
   			-- May be redefined to paint something on
   			-- the `paint_dc'. `invalid_rect' defines
   			-- the invalid rectangle of the client area that
   			-- needs to be repainted.
   		do
			disable_default_processing
		end

invariant
	
	valid_state: state = Initial_state or state = Idl_state or state = Ps_state or 
				state = Final_state or state = Finished_state or state = Abort_state
	non_void_lines: lines /= Void

end -- class MAIN_WINDOW

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
