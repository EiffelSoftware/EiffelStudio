indexing
	description: "eSplitter main window"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_ES_MAIN_WINDOW

inherit
	CODE_ES_MAIN_WINDOW_IMP

	CODE_ES_SAVED_SETTINGS
		rename
			make as saved_make
		undefine
			copy,
			default_create
		end
	
	CODE_ES_SHARED_DIRECTORY_SEPARATOR
		undefine
			copy,
			default_create
		end
	
	CODE_ES_SEVERITY_CONSTANTS
		undefine
			copy,
			default_create
		end

	EV_FONT_CONSTANTS
		undefine
			copy,
			default_create
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize registry settings
		do
			saved_make
			default_create
		end
		
	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			create test_regexp.make
			close_request_actions.extend (agent on_exit)
			fill_combo (folders_combo_box, saved_folders)
			folders_combo_box.set_data (agent save_folders)
			fill_combo (destination_folders_combo, saved_destination_folders)
			destination_folders_combo.set_data (agent save_destination_folders)
			fill_combo (regexp_combo_box, saved_regexps)
			regexp_combo_box.set_data (agent save_regexps)
			if saved_process_subfolders then
				subfolders_check_button.enable_select
			else
				subfolders_check_button.disable_select
			end
			if saved_has_destination then
				destination_radio_button.enable_select
			else
				no_destination_radio_button.enable_select
			end
			set_x_position (saved_x_pos)
			set_y_position (saved_y_pos)
		end

feature {NONE} -- Events Handling

	on_folder_change is
			-- Check if `generate' button should be enabled.
		do
			check_can_generate
		end
		
	on_browse_folder is
			-- Browse for folder containing Eiffel multi-class files.
		local
			l_dialog: EV_DIRECTORY_DIALOG
		do
			create l_dialog.make_with_title ("Browse for folder containing multi-class Eiffel file(s)")
			if not folders_combo_box.text.is_empty then
				l_dialog.set_start_directory (folders_combo_box.text)
			end
			l_dialog.show_modal_to_window (Current)
			if not l_dialog.directory.is_empty then
				folders_combo_box.set_text (l_dialog.directory)
				add_entry_to_combo_and_save (l_dialog.directory, folders_combo_box)			
			end
		end
	
	on_folder_select is
			-- Put selected entry in front of combo `strings' list.
		do
			if is_select_during_set_strings then
				is_select_during_set_strings := False
			else
				add_entry_to_combo_and_save (folders_combo_box.text, folders_combo_box)
			end
		end
	
	on_regexp_change is
			-- Check if `generate' button should be enabled.
		do
			check_can_generate
		end		

	on_regexp_select is
			-- Put selected entry in front of combo `strings' list.
		do
			if is_select_during_set_strings then
				is_select_during_set_strings := False
			else
				add_entry_to_combo_and_save (regexp_combo_box.text, regexp_combo_box)
			end
		end
	
	on_select_no_destination is
			-- Disable destination combo box.
		do
			destination_folder_box.disable_sensitive
		end

	on_select_destination is
			-- Enable destination combo box.
		do
			destination_folder_box.enable_sensitive
		end

	on_destination_folder_change is
			-- Check if `generate' buttin should be enabled.
		do
			check_can_generate
		end
	
	on_browse_destination_folder is
			-- Browse for destination folder.
		local
			l_dialog: EV_DIRECTORY_DIALOG
		do
			create l_dialog.make_with_title ("Browse for destination folder")
			if not destination_folders_combo.text.is_empty then
				l_dialog.set_start_directory (destination_folders_combo.text)
			end
			l_dialog.show_modal_to_window (Current)
			if not l_dialog.directory.is_empty then
				destination_folders_combo.set_text (l_dialog.directory)
				add_entry_to_combo_and_save (l_dialog.directory, destination_folders_combo)
			end
		end

	on_destination_folder_select is
			-- Put selected entry in front of combo `strings' list.
		do
			if is_select_during_set_strings then
				is_select_during_set_strings := False
			else
				add_entry_to_combo_and_save (destination_folders_combo.text, destination_folders_combo)
			end
		end
	
	on_generate is
			-- Generate Eiffel source files.
		local
			l_dest, l_folder: STRING
			l_worker_thread: CODE_ES_WORKER_THREAD
		do
			check_can_generate
			if generate_button.is_sensitive then
				notebook.select_item (output_box)
				generate_button.disable_sensitive
				add_entry_to_combo_and_save (regexp_combo_box.text, regexp_combo_box)
				if destination_radio_button.is_selected then
					l_dest := destination_folders_combo.text
					if l_dest.is_empty then
						l_dest := Void
					else
						if l_dest.item (l_dest.count) = Directory_separator then
							l_dest.keep_head (l_dest.count - 1)
						end
					end
				end
				l_folder := folders_combo_box.text
				if l_folder.item (l_folder.count) = Directory_separator then
					l_folder.keep_head (l_folder.count - 1)
				end
				output_text.set_text ("")
				create l_worker_thread.make
				l_worker_thread.do_work (agent (create {CODE_ES_SPLITTER}.make (l_folder, regexp_combo_box.text, l_dest, subfolders_check_button.is_selected)).split_files, agent process_event)
				generate_button.enable_sensitive
			end
		end

	on_open_folder is
			-- Explore destination folder.
		local
			l_dir: STRING
			l_res: SYSTEM_OBJECT
		do
			if destination_folders_combo.text.is_empty then
				l_dir := folders_combo_box.text
			else
				l_dir := destination_folders_combo.text
			end
			if not l_dir.is_empty then
				l_res := feature {SYSTEM_DLL_PROCESS}.start_string_string ("explorer.exe", l_dir)
			end
		end

	on_help is
			-- Called by `select_actions' of `help_menu_item'.
		do
		end

	on_about is
			-- Called by `select_actions' of `about_menu_item'.
		local
			l_about_dialog: CODE_ES_ABOUT_DIALOG
		do
			create l_about_dialog
			l_about_dialog.show_modal_to_window (Current)
		end

	on_exit is
			-- Called by `select_actions' of `exit_menu_item'.
		do
			save_x_pos (x_position)
			save_y_pos (y_position)
			save_process_subfolders (subfolders_check_button.is_selected)
			save_has_destination (destination_radio_button.is_selected)
 			(create {EV_ENVIRONMENT}).application.destroy
		end

feature {NONE} -- Implementation

	process_event (a_event: CODE_ES_EVENT) is
			-- Display events in output text field.
		require
			non_void_event: a_event /= Void
		do
			inspect
				a_event.severity
			when Information then
				output_text.buffered_append (a_event.title, Information_format)
				output_text.buffered_append (": ", Information_format)
				output_text.buffered_append (a_event.message, Information_format)
				output_text.buffered_append ("%N", Information_format)
				output_text.flush_buffer_to (output_text.text_length + 1, output_text.text_length + 1)
			when Warning then
				output_text.buffered_append (a_event.title, Warning_format)
				output_text.buffered_append (": ", Warning_format)
				output_text.buffered_append (a_event.message, Warning_format)
				output_text.buffered_append ("%N", Warning_format)
				output_text.flush_buffer_to (output_text.text_length + 1, output_text.text_length + 1)
			when Error then
				output_text.buffered_append ("%NERROR: " + a_event.title + "%N", Error_format)
				output_text.buffered_append (a_event.message, Error_format)
				output_text.buffered_append ("%N%N", Error_format)
				output_text.flush_buffer_to (output_text.text_length + 1, output_text.text_length + 1)
			else
				check
					should_not_be_here: False
				end
			end
		end
		
	fill_combo (a_combo: EV_COMBO_BOX; a_list: LIST [STRING]) is
			-- Fill `a_combo' with `a_list'.
			-- Do nothing if `a_list' is void.
		require
			non_void_combo: a_combo /= Void
		do
			if a_list /= Void then
				from
					a_list.start
				until
					a_list.after
				loop
					a_combo.extend (create {EV_LIST_ITEM}.make_with_text (a_list.item))
					a_list.forth
				end
			end
		end

	check_can_generate is
			-- Are settings OK for generation?
		local
			l_text: STRING
			l_folder_ok, l_regexp_ok: BOOLEAN
		do
			l_text := folders_combo_box.text
			if not l_text.is_empty then
				l_folder_ok := (create {DIRECTORY}.make (l_text)).exists
				if not l_folder_ok then
					folders_combo_box.set_foreground_color (Red)
				else
					folders_combo_box.set_foreground_color (Black)
				end
			end
			l_text := regexp_combo_box.text
			if not l_text.is_empty then
				test_regexp.compile (l_text)
				l_regexp_ok := test_regexp.is_compiled
				if not l_regexp_ok then
					regexp_combo_box.set_foreground_color (Red)
				else
					regexp_combo_box.set_foreground_color (Black)
				end
			end
			if l_folder_ok and l_regexp_ok then
				generate_button.enable_sensitive
			else
				generate_button.disable_sensitive
			end
		end

	add_entry_to_combo_and_save (a_entry: STRING; a_combo: EV_COMBO_BOX) is
			-- Add entry `a_entry' to combo box `a_combo' if not there already.
			-- Persist combo box strings.
		local
			l_save_routine: ROUTINE [ANY, TUPLE [LIST [STRING]]]
			l_list, l_new_list: LIST [STRING]
		do
			if not a_entry.is_empty then
				l_list := a_combo.strings
				l_list.compare_objects
				if not l_list.has (a_entry) then
					if a_combo.count >= Max_combo_count then
						a_combo.finish
						a_combo.remove
					end
					a_combo.put_front (create {EV_LIST_ITEM}.make_with_text (a_entry))
					l_save_routine ?= a_combo.data
					if l_save_routine /= Void then
						l_save_routine.call ([a_combo.strings])
					end
				else
					a_combo.set_text (a_entry)
					create {ARRAYED_LIST [STRING]} l_new_list.make (l_list.count)
					l_new_list.extend (a_entry)
					l_list.prune (a_entry)
					l_new_list.append (l_list)
					is_select_during_set_strings := True
					a_combo.set_strings (l_new_list)
				end
			end
		end

feature {NONE} -- Private Access

	Max_combo_count: INTEGER is 10
			-- Maximum folders count in combo box

	Red: EV_COLOR is
			-- Red
		once
			Result := (create {EV_STOCK_COLORS}).Red
		end
		
	Blue: EV_COLOR is
			-- Blue
		once
			Result := (create {EV_STOCK_COLORS}).Blue
		end

	Black: EV_COLOR is
			-- Black
		once
			Result := (create {EV_STOCK_COLORS}).Black
		end

	White: EV_COLOR is
			-- White
		once
			Result := (create {EV_STOCK_COLORS}).White
		end

	Message_font: EV_FONT is
			-- Font used to diplay information and warning messages
		once
			create Result.make_with_values (family_sans, weight_regular, shape_regular, 10)
		end
		
	Error_font: EV_FONT is
			-- Font used to diplay error messages
		once
			create Result.make_with_values (family_sans, weight_bold, shape_regular, 10)
		end
		
	Information_format: EV_CHARACTER_FORMAT is
			-- Format used to display information messages
		once
			create Result.make_with_font_and_color (Message_font, Black, White)
		end
		
	Warning_format: EV_CHARACTER_FORMAT is
			-- Format used to display warning messages
		once
			create Result.make_with_font_and_color (Message_font, Blue, White)
		end
		
	Error_format: EV_CHARACTER_FORMAT is
			-- Format used to display error messages
		once
			create Result.make_with_font_and_color (Error_font, Red, White)
		end
		
	test_regexp: RX_PCRE_REGULAR_EXPRESSION
			-- Test regular expression, used to validate regular expression text

	is_select_during_set_strings: BOOLEAN
			-- Was `combo_box.select' called as part of `combo_box.set_strings' execution?

end -- class CODE_ES_MAIN_WINDOW

--+--------------------------------------------------------------------
--| eSplitter
--| Copyright (C) Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------