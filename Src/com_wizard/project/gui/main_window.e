
class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			on_menu_command,
			on_control_id_command,
			on_accelerator_command,
			on_wm_erase_background,
			on_notify,
			on_size
		end

	WIZARD_OUTPUT_WINDOW
	
	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		rename
			free as env_free
		export
			{NONE} all
		end

	WIZARD_BROWSE_DIRECTORY
		export
			{NONE} all
		end

	WIZARD_RESCUABLE
		export
			{NONE} all
		end

	APPLICATION_IDS
		export
			{NONE} all
		end
		
	WEL_OFN_CONSTANTS
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

	WEL_TB_STATE_CONSTANTS
		export
			{NONE} all
		end

	WEL_HWND_CONSTANTS
		export
			{NONE} all
		end

	WEL_HELP_CONSTANTS
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
			create previous_states.make
			make_top (Title)
			create msg_box.make
			create output_edit.make (Current, rebar.height)
			set_menu (main_menu)
			create generated_code_type_dialog.make (Current)
			create definition_file_dialog.make (Current)
			create eiffel_project_file_dialog.make (Current)
			create eiffel_destination_folder_dialog.make (Current)
			create idl_dialog.make (Current)
			create ps_dialog.make (Current)
			create final_dialog.make (Current)
			create first_choice_dialog.make (Current)
			create about_dialog.make (Current)
			resize (600, 400)
			set_z_order (Hwnd_top)
			show
			start
		end

feature -- GUI Elements

	msg_box: WEL_MSG_BOX
			-- Message box

	rebar: WEL_REBAR is
			-- Create and initialise toolbar.
		local
			rebar_info: WEL_REBARBANDINFO
		once
			initialize_toolbar
			create Result.make (Current, -1)
			create rebar_info.make
			rebar_info.set_unpositionable_child (tool_bar)
			rebar_info.set_child_minimum_width (100)
			rebar_info.set_child_minimum_height (28)
			Result.prepend_band (rebar_info)
			Result.reposition
		end

	initialize_toolbar is
				-- Create toolbar and toolbar buttons.
		local
			tool_bar_bitmap: WEL_TOOL_BAR_BITMAP
		do
			create tool_bar.make (Current, -1)
			tool_bar.set_style (tool_bar.style + Tbstyle_flat)
			create tool_bar_bitmap.make_by_predefined_id (Idb_std_small_color)
			tool_bar.add_bitmaps (tool_bar_bitmap, 1)
			create new_button.make_button (tool_bar.last_bitmap_index + Std_filenew, New_string_constant)
			create open_button.make_button (tool_bar.last_bitmap_index + Std_fileopen, Open_string_constant)
			create save_button.make_button (tool_bar.last_bitmap_index + Std_filesave, Save_string_constant)
			create separator_button.make_separator
			create tool_bar_bitmap.make (Toolbar_bitmap_constant)
			tool_bar.add_bitmaps (tool_bar_bitmap, 1)
			create launch_button.make_button (tool_bar.last_bitmap_index + 1, Launch_string_constant)
			create generate_button.make_button (tool_bar.last_bitmap_index, Generate_string_constant)
			tool_bar.add_buttons (<<new_button, open_button, save_button, separator_button, launch_button, generate_button>>)
			tool_bar.set_width (2000)
			tool_bar.disable_button (Save_string_constant)
			tool_bar.disable_button (Generate_string_constant)
		end

	generated_code_type_dialog: WIZARD_GENERATED_CODE_TYPE_DIALOG
			-- Wizard introduction dialog

	definition_file_dialog: WIZARD_DEFINITION_FILE_DIALOG
			-- Wizard initial dialog

	eiffel_project_file_dialog: WIZARD_EIFFEL_PROJECT_FILE_DIALOG
			-- Wizard Eiffel project dialog

	eiffel_destination_folder_dialog: WIZARD_DESTINATION_FOLDER_FILE_DIALOG
			-- Wizard destination folder dialog

	idl_dialog: WIZARD_IDL_DIALOG
			-- Wizard IDL dialog
	
	ps_dialog: WIZARD_PS_DIALOG
			-- Wizard Proxy/Stub dialog
	
	final_dialog: WIZARD_FINAL_DIALOG
			-- Wizard final dialog

	first_choice_dialog: WIZARD_FIRST_CHOICE_DIALOG
			-- Wizard first choice dialog

	about_dialog: WIZARD_ABOUT_DIALOG
			-- About dialog

	Title: STRING is "EiffelCOM Wizard"
			-- Window title

	main_menu: WEL_MENU is
			-- Main menu
		once
			create Result.make
			Result.append_popup (file_menu, "&File")
			Result.append_popup (build_menu, "&Build")
			Result.append_popup (help_menu, "&Help")
		ensure
			main_menu_not_void: Result /= Void
		end

	file_menu: WEL_MENU is
			-- File menu
		once
			create Result.make
			Result.append_string ("&New", New_string_constant)
			Result.append_string ("&Open", Open_string_constant)
			Result.append_string ("&Save", Save_string_constant)
			Result.append_separator
			Result.append_string ("E&xit", Exit_string_constant)
		ensure
			file_menu_not_void: Result /= Void
		end

	build_menu: WEL_MENU is
			-- Build menu
		once
			create Result.make
			Result.append_string ("&Launch Wizard", Launch_string_constant)
			Result.append_string ("&Generate (no wizard)", Generate_string_constant)
		ensure
			build_menu_not_void: Result /= Void
		end

	help_menu: WEL_MENU is
			-- Help menu
		once
			create Result.make
			Result.append_string ("&Help", Help_string_constant)
			Result.append_string ("&About EiffelCOM", About_string_constant)
		ensure
			menu_not_void: Result /= Void
		end

	open_file_dialog: WEL_OPEN_FILE_DIALOG is
			-- Open file dialog
		once
			create Result.make
			Result.add_flag (Ofn_filemustexist)
			Result.set_filter (<<Wizard_filter, "All Files (*.*)">>, <<Wizard_wild_card, "*.*">>)
		end

	save_file_dialog: WEL_SAVE_FILE_DIALOG is
			-- Open file dialog
		once
			create Result.make
			Result.add_flag (Ofn_pathmustexist)
			Result.set_filter (<<Wizard_filter, "All Files (*.*)">>, <<Wizard_wild_card, "*.*">>)
		end

	output_edit: WIZARD_OUTPUT_EDIT
			-- Output edit used to display messages

	open_button, new_button, save_button, launch_button,
			generate_button, separator_button: WEL_TOOL_BAR_BUTTON
			-- Toolbar buttons

	tool_bar: WEL_TOOL_BAR
			-- Toolbar

feature -- Output

	add_message (a_text: STRING) is
			-- Add text `a_text' into window's text.
		do
			output_edit.add_text (a_text)
		end
	
	add_continuous_message (a_text: STRING) is
			-- Add text `a_text' into window's text.
			-- Do not add new line.
		do
			output_edit.add_continuous_text (a_text)
		end
	
	add_title (a_title: STRING) is
			-- Add title `a_title' to window's text.
		do
			output_edit.set_title_format
			output_edit.add_text (a_title)
		end

	add_warning (a_warning: STRING) is
			-- Add warning `a_warning' to window's text.
		do
			output_edit.set_warning_format
			output_edit.add_text (a_warning)
		end

	add_error (a_error: STRING) is
			-- Add error `a_error' to window's text.
		do
			output_edit.set_title_format
			output_edit.add_text (a_error)
		end

	clear is
			-- Clear window text.
		do
			output_edit.clear
		end

	refresh is
			-- Refresh output window.
		do
			output_edit.refresh
		end

feature {NONE} -- State management

	First_state,  		-- First_choice_dialog
	Introduction_state, 		-- Generated_code_type_dialog
	Initial_state, 		-- Definition_file_dialog
	Initial_eiffel_state, 	-- Eiffel_project_file_dialog
	Destination_state, 		-- Eiffel_destination_folder_dialog
	Idl_state, 			-- Idl_dialog
	Ps_state, 			-- Ps_dialog
	Final_state, 			-- Final_dialog
	Finished_state, 		-- No more dialogs
	Abort_state,			-- Abort
	Open_state: INTEGER is unique
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
			when First_state then
				Result := first_choice_dialog
			when Introduction_state then
				Result := Generated_code_type_dialog
			when Initial_state then
				Result := Definition_file_dialog
			when Initial_eiffel_state then
				Result := eiffel_project_file_dialog
			when Destination_state then
				Result := eiffel_destination_folder_dialog
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
			clear
			set_message_output_and_progress_report

			from
				previous_states.extend (Abort_state)
				state := First_state
				shared_wizard_environment.set_no_abort
			until
				state = Finished_state or 
				state = Abort_state or
				state = Open_state
			loop
				current_dialog.activate
				if state /= Abort_state then
					change_state (current_dialog.ok_pushed)
				end
			end
			if state = Open_state then
				on_menu_command (Open_string_constant)
			elseif state = Finished_state then
				run_wizard_manager
			end
			tool_bar.enable_button (Save_string_constant)
			tool_bar.enable_button (Generate_string_constant)
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
					
				when First_state then
					if shared_wizard_environment.new_project then
						state := Introduction_state
					else
						state := Open_state
					end
					
				when Introduction_state then
					if shared_wizard_environment.new_eiffel_project then
						state := Initial_eiffel_state
					else
						state := Initial_state
					end

				when Initial_state then
					if not shared_wizard_environment.server then
						state := Final_state
					elseif shared_wizard_environment.idl then
						state := Idl_state
					else
						state := Ps_state
					end
					
				when Initial_eiffel_state then
					state := Destination_state
					
				when Destination_state then
					state := Idl_state
					
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

	run_wizard_manager is
			-- Run Code generation manager.
		local
			wizard_manager: WIZARD_MANAGER
		do
			create wizard_manager
			wizard_manager.run
			wizard_manager := Void
			full_collect
		end

	open_project (a_project: STRING) is
			-- Open previous project saved in `a_project'.
		local
			retried: BOOLEAN
			an_environment: WIZARD_ENVIRONMENT
			f: RAW_FILE
		do
			if not retried then
				create f.make (a_project)
				if f.exists then
					f.open_read
					an_environment ?= f.retrieved
					f.close
				end
				if an_environment /= Void then
					set_shared_wizard_environment (an_environment)
					add_message (Open_message)
					project_retrieved := True
				else
					add_message (Open_error_message)
					project_retrieved := False
				end
			else
				add_message (Open_error_message)
				project_retrieved := False
			end
		rescue
			if not failed_on_rescue then
				retried := True
				retry
			end
		end

	save_project (a_project: STRING) is
			-- Save project in `a_project'.
		local
			retried: BOOLEAN
			f: RAW_FILE
		do
			if not a_project.substring (a_project.count  - Wizard_extension.count + 1, a_project.count).is_equal (Wizard_extension) then
				a_project.append (Wizard_extension)
			end
			if not retried then
				create f.make_open_write (a_project)
				f.independent_store (shared_wizard_environment)
				f.close
				add_message (Save_message)
			else
				add_message (Save_error_message)
			end
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

	project_retrieved: BOOLEAN	
			-- Was project correctly retrieved?

	set_message_output_and_progress_report is
			-- Set message output and progress report.
		do
			set_message_output (create {WIZARD_MESSAGE_OUTPUT}.set_output (Current))
			set_progress_report (create {WIZARD_PROGRESS_REPORT_GUI}.make (Current))
		end

feature {WIZARD_FIRST_CHOICE_DIALOG} -- Behavior

	on_menu_command (menu_id: INTEGER) is
			-- `menu_id' has been selected
		do
			inspect
				menu_id
			when Launch_string_constant then
				start
			when Generate_string_constant then
				clear
				shared_wizard_environment.set_no_abort
				set_message_output_and_progress_report
				run_wizard_manager
			when Exit_string_constant then
				destroy			
			when Open_string_constant then
				open_file_dialog.set_initial_directory (browse_directory)
				open_file_dialog.activate (Current)
				if open_file_dialog.selected then
					open_project (open_file_dialog.file_name)
				end
				safe_browse_directory_from_dialog (open_file_dialog)
				tool_bar.enable_button (Save_string_constant)
				tool_bar.enable_button (Generate_string_constant)
			when Save_string_constant then
				save_file_dialog.set_initial_directory (browse_directory)
				save_file_dialog.activate (Current)
				if save_file_dialog.selected then
					save_project (save_file_dialog.file_name)
				end
				safe_browse_directory_from_dialog (save_file_dialog)
			When New_string_constant then
				set_shared_wizard_environment (create {WIZARD_ENVIRONMENT}.make)
				tool_bar.disable_button (Save_string_constant)
				tool_bar.disable_button (Generate_string_constant)
				shared_wizard_environment.set_new_project (True)
				start

			when About_string_constant then
				about_dialog.activate
			when Help_string_constant then
				launch_help
			else
			end
		end

	launch_help is
			-- Launch Help
		local
			tmp_help_path: STRING			
		do
			tmp_help_path := clone (Eiffel4_location)
			tmp_help_path.append ("\wizards\com\eiffelcom.hlp")
			win_help (tmp_help_path, Help_finder, 0)
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

   	on_wm_erase_background (wparam: INTEGER) is
   			-- Wm_paint message.
   			-- May be redefined to paint something on
   			-- the `paint_dc'. `invalid_rect' defines
   			-- the invalid rectangle of the client area that
   			-- needs to be repainted.
   		do
			disable_default_processing
		end

	on_size (size_type, a_width, a_height: INTEGER) is
			-- Wm_size message
			-- See class WEL_SIZE_CONSTANTS for `size_type' value
		do
			output_edit.resize (a_width, a_height - rebar.height)
			rebar.reposition
		end

		
feature {NONE} -- Externals

	cwin_create_process (a_name, a_command_line, a_sec_attributes1, a_sec_attributes2: POINTER;
							a_herit_handles: BOOLEAN; a_flags: INTEGER; an_environment, a_directory,
							a_startup_info, a_process_info: POINTER): BOOLEAN is
			-- SDK CreateProcess
		external
			"C [macro <winbase.h>] (LPCTSTR, LPTSTR, LPSECURITY_ATTRIBUTES, LPSECURITY_ATTRIBUTES, BOOL, DWORD, LPVOID, LPCTSTR, LPSTARTUPINFO, LPPROCESS_INFORMATION) :EIF_BOOLEAN"
		alias
			"CreateProcess"
		end

invariant
	
	valid_state: state = Introduction_state or state = Initial_state or state = Idl_state or state = Ps_state or 
				state = Final_state or state = Finished_state or state = Abort_state or state = First_state or
				state = Initial_eiffel_state or state = Destination_state or state = Open_state

end -- class MAIN_WINDOW

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
