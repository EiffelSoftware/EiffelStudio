indexing
	description: "eSplitter main window"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
	
	EV_THREAD_SEVERITY_CONSTANTS
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
			initialize_combo (folders_combo_box, Folders_key)
			initialize_combo (destination_folders_combo, Destination_folders_key)
			initialize_combo (regexp_combo_box, Regexps_key)
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
			l_dir: STRING
		do
			create l_dialog.make_with_title ("Browse for folder containing multi-class Eiffel file(s)")
			if not folders_combo_box.text.is_empty then
				l_dialog.set_start_directory (folders_combo_box.text)
			end
			l_dialog.show_modal_to_window (Current)
			l_dir := l_dialog.directory
			if not l_dir.is_empty and not l_dir.is_equal (folders_combo_box.text) then
				folders_combo_box.set_text (l_dir)
				add_entry_to_combo_and_save (l_dir, folders_combo_box)			
			end
		end
	
	on_regexp_change is
			-- Check if `generate' button should be enabled.
		do
			check_can_generate
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
			l_dir: STRING
		do
			create l_dialog.make_with_title ("Browse for destination folder")
			if not destination_folders_combo.text.is_empty then
				l_dialog.set_start_directory (destination_folders_combo.text)
			end
			l_dialog.show_modal_to_window (Current)
			l_dir := l_dialog.directory
			if not l_dir.is_empty and not l_dir.is_equal (destination_folders_combo.text) then
				destination_folders_combo.set_text (l_dir)
				add_entry_to_combo_and_save (l_dir, destination_folders_combo)
			end
		end
	
	on_generate is
			-- Generate Eiffel source files.
		local
			l_dest, l_folder: STRING
			l_worker_thread: EV_THREAD_WORKER
		do
			check_can_generate
			if generate_button.is_sensitive then
				notebook.select_item (output_box)
				generate_button.disable_sensitive
				add_entry_to_combo_and_save (regexp_combo_box.text, regexp_combo_box)
				add_entry_to_combo_and_save (destination_folders_combo.text, destination_folders_combo)
				add_entry_to_combo_and_save (folders_combo_box.text, folders_combo_box)
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
			if destination_radio_button.is_selected then
				l_dir := destination_folders_combo.text
			else
				l_dir := folders_combo_box.text
			end
			if not l_dir.is_empty then
				l_res := {SYSTEM_DLL_PROCESS}.start_string_string ("explorer.exe", l_dir)
			end
		end

	on_help is
			-- Called by `select_actions' of `help_menu_item'.
		do
			(create {EV_ENVIRONMENT}).application.display_help_for_widget (Current)
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

	process_event (a_event: EV_THREAD_EVENT) is
			-- Display events in output text field.
		require
			non_void_event: a_event /= Void
		local
			l_event: CODE_ES_EVENT
		do
			l_event ?= a_event
			check
				is_code_event: l_event /= Void
			end
			inspect
				l_event.severity
			when Information then
				display_info (l_event.title, l_event.message)
			when Warning then
				display_warning (l_event.title, l_event.message)
			when Error then
				display_error (l_event.title, l_event.message)
			else
				-- Stop event
			end
		end

	display_info (a_title, a_message: STRING) is
			-- Display informational text with title `a_title' and content `a_message'.
		require
			non_void_title: a_title /= Void
			non_void_text: a_message /= Void
		do
			output_text.buffered_append (a_title, Information_format)
			output_text.buffered_append (": ", Information_format)
			output_text.buffered_append (a_message, Information_format)
			output_text.buffered_append ("%N", Information_format)
			output_text.flush_buffer_to (output_text.text_length + 1, output_text.text_length + 1)
		end
		
	display_warning (a_title, a_message: STRING) is
			-- Display warning with title `a_title' and content `a_message'.
		require
			non_void_title: a_title /= Void
			non_void_text: a_message /= Void
		do
			output_text.buffered_append (a_title, Warning_format)
			output_text.buffered_append (": ", Warning_format)
			output_text.buffered_append (a_message, Warning_format)
			output_text.buffered_append ("%N", Warning_format)
			output_text.flush_buffer_to (output_text.text_length + 1, output_text.text_length + 1)
		end
		
	display_error (a_title, a_message: STRING) is
			-- Display error with title `a_title' and content `a_message'.
		require
			non_void_title: a_title /= Void
			non_void_text: a_message /= Void
		do
			output_text.buffered_append ("%NERROR: " + a_title + "%N", Error_format)
			output_text.buffered_append (a_message, Error_format)
			output_text.buffered_append ("%N%N", Error_format)
			output_text.flush_buffer_to (output_text.text_length + 1, output_text.text_length + 1)
		end

feature {NONE} -- Private Access

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

	is_select_during_set_strings: BOOLEAN;
			-- Was `combo_box.select' called as part of `combo_box.set_strings' execution?

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


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