indexing
	description: "Output notebook tab, can display messages, titles and errors"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_OUTPUT_BOX

inherit
	WIZARD_OUTPUT_BOX_IMP
		rename
			start as list_start,
			finish as list_finish
		end

	WIZARD_SHARED_DATA
		undefine
			is_equal,
			copy,
			default_create
		end

	WIZARD_ERRORS
		export
			{NONE} all
		undefine
			is_equal,
			copy,
			default_create
		end

	WIZARD_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		undefine
			is_equal,
			copy,
			default_create
		end

	REFACTORING_HELPER
		export
			{NONE} all
		undefine
			is_equal,
			copy,
			default_create
		end
	
feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
		do
			create output_text
			output_text.hide_scroll_bars
			wizard_output_upper_box.extend (output_text)
			progress_bar.disable_segmentation
			progress_bar_label.set_text ("Ready.")
			create internal_text.make (256 * 1024)
		end

feature -- Access

	destination_folder: STRING
			-- Destination folder

feature -- Element Settings

	set_destination_folder (a_destination_folder: like destination_folder) is
			-- Set `destination_folder' with `a_destination_folder'
		do
			destination_folder := a_destination_folder
		ensure
			destination_folder_set: destination_folder = a_destination_folder
		end

	disable_eiffelstudio_button is
			-- Disable EiffelStudio open button
			-- Need to do this if destination folder changed but new project hasn't been compiled
		do
			open_eiffelstudio_button.disable_sensitive
		end
	
	enable_generate_button is
			-- Enable sensitivity on `generate' button.
		do
			generate_button.enable_sensitive
		end
		
	disable_generate_button is
			-- Disable sensitivity on `generate' button.
		do
			generate_button.disable_sensitive
		end
		
feature -- Basic Operations

	clear is
			-- Clear output.
		do
			output_text.set_text ("")
			internal_text.wipe_out
		end
	
	process_event (a_event: EV_THREAD_EVENT) is
			-- Process event `a_event'.
		require
			non_void_event: a_event /= Void
		local
			l_output_event: WIZARD_OUTPUT_EVENT
			l_progress_event: WIZARD_PROGRESS_EVENT
			l_percent: INTEGER
		do
			l_output_event ?= a_event
			if l_output_event /= Void then
				inspect
					l_output_event.id
				when feature {WIZARD_OUTPUT_EVENT_ID}.Display_title then
					add_title (l_output_event.text)
				when feature {WIZARD_OUTPUT_EVENT_ID}.Display_text then
					add_text (l_output_event.text)
				when feature {WIZARD_OUTPUT_EVENT_ID}.Display_message then
					add_message (l_output_event.text)
				when feature {WIZARD_OUTPUT_EVENT_ID}.Display_warning then
					add_warning (l_output_event.text)
				when feature {WIZARD_OUTPUT_EVENT_ID}.Display_error then
					add_error (l_output_event.text)
				when feature {WIZARD_OUTPUT_EVENT_ID}.Clear then
					clear
				else
					check
						should_not_be_here: False
					end
				end
			else
				l_progress_event ?= a_event
				if l_progress_event /= Void then
					inspect
						l_progress_event.id
					when feature {WIZARD_PROGRESS_EVENT_ID}.Start then
						percentage_label.set_text ("0")
						progress_bar_box.show
						stop_button.enable_sensitive
						exit_button.disable_sensitive
						save_button.disable_sensitive
						open_eiffelstudio_button.disable_sensitive
						final_message_box.hide
						progress_bar_label.set_foreground_color ((create {EV_STOCK_COLORS}).Black)
						output_text.hide_scroll_bars
					when feature {WIZARD_PROGRESS_EVENT_ID}.Finish then
						set_output
						progress_bar_box.hide
						progress_bar_label.set_text ("Ready.")
						stop_button.disable_sensitive
						exit_button.enable_sensitive
						save_button.enable_sensitive
						if not environment.abort then
							fixme ("progress_bar.value is off by one or two (lower than progress_bar.value_range.upper)")
							check
							--	step_called_correctly: not environment.abort implies (progress_bar.value = progress_bar.value_range.upper)
							end
							if environment.compile_eiffel then
								open_eiffelstudio_button.enable_sensitive
							end
						end
						destination_path_label.set_text (environment.destination_folder)
						final_message_box.show
						output_text.show_scroll_bars
					when feature {WIZARD_PROGRESS_EVENT_ID}.Step then
						check
					--		not_finished: not environment.abort implies (progress_bar.value < (progress_bar.value_range.upper - progress_bar.value_range.lower))
						end
						if not environment.abort and progress_bar.value >= (progress_bar.value_range.upper - progress_bar.value_range.lower) then
							do_nothing
						end
						progress_bar.step_forward
						l_percent := ((progress_bar.value / (progress_bar.value_range.upper - progress_bar.value_range.lower)) * 100).rounded
						percentage_label.set_text (l_percent.out)
					when feature {WIZARD_PROGRESS_EVENT_ID}.Set_range then
						progress_bar.value_range.resize_exactly (0, l_progress_event.value)
						progress_bar.set_value (0)
						percentage_label.set_text ("0")
					when feature {WIZARD_PROGRESS_EVENT_ID}.Title then
						progress_bar_label.set_text (l_progress_event.text_value)
					else
						check
							should_not_be_here: False
						end					
					end
				end
			end
		end

feature {NONE} -- GUI Events Handling

	on_exit is
			-- Called by `select_actions' of `exit_button'.
		do
			((create {EV_ENVIRONMENT}).application).destroy
		end

	on_stop is
			-- Called by `select_actions' of `stop_button'.
		do
			environment.set_abort (User_stop)
			stop_button.disable_sensitive
			progress_bar_label.set_text ("Stopping....")
			progress_bar_label.set_foreground_color ((create {EV_STOCK_COLORS}).Red)
			progress_bar.set_value (progress_bar.value_range.upper)
		end

	on_link_click (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Called by `pointer_button_press_actions' of `destination_path_label'.
			-- Open destination folder.
		do
			(create {WEL_PROCESS_LAUNCHER}).spawn ("explorer.exe " + destination_folder, destination_folder)
		end

	on_open_eiffelstudio is
			-- Called by `select_actions' of `open_eiffelstudio_button'.
		local
			l_folder, l_cmd: STRING
		do
			l_folder := Environment.destination_folder.twin
			if Environment.is_client then
				l_folder.append ("Client")
			else
				l_folder.append ("Server")
			end
			l_cmd := eiffelstudio_command (l_folder)
			if l_cmd /= Void then
				(create {WEL_PROCESS_LAUNCHER}).spawn (l_cmd, l_folder)
			end
		end

	on_link_leave is
			-- Called by `pointer_leave_actions' of `destination_path_label'.
			-- Reset `destination_path_label' format.
		local
			l_font: EV_FONT
		do
			l_font := destination_path_label.font
			l_font.set_weight (feature {EV_FONT_CONSTANTS}.weight_regular)
			destination_path_label.set_font (l_font)
		end

	on_link_enter is
			-- Called by `pointer_enter_actions' of `destination_path_label'.
			-- Set `destination_path_label' format to underline.
		local
			l_font: EV_FONT
		do
			l_font := destination_path_label.font
			l_font.set_weight (feature {EV_FONT_CONSTANTS}.weight_bold)
			destination_path_label.set_font (l_font)
		end

	on_save is
			-- Called by `select_actions' of `save_button'.
			-- Save rich text content.
		local
			l_dialog: EV_FILE_SAVE_DIALOG
			l_file_name: STRING
		do
			create l_dialog.make_with_title ("Browse for log file")
			l_dialog.filters.extend (["*.log", "Log File (*.log)"])
			l_dialog.filters.extend (["*.txt", "Plain Text File (*.txt)"])
			l_dialog.filters.extend (["*.*", "All Files (*.*)"])
			l_dialog.set_file_name (environment.project_name + ".log")
			l_dialog.set_start_directory (environment.destination_folder)
			l_dialog.show_modal_to_window ((create {EV_UTILITIES}).parent_window (Current))
			l_file_name := l_dialog.file_name.as_lower
			if not l_file_name.is_empty then
				if l_file_name.substring_index (".log", l_dialog.file_name.count - 3) = 0 then
					l_file_name.append (".log")
				end
				output_text.save (l_file_name)
			end
		end

	on_generate is
			-- Called by `select_actions' of `generate_button'.
		local
			l_window: WIZARD_MAIN_WINDOW
		do
			l_window ?= (create {EV_UTILITIES}).parent_window (Current)
			check
				has_main_window: l_window /= Void
			end
			l_window.on_generate
		end

feature {NONE} -- Implementation

	add_title (a_title: STRING) is
			-- Append title `a_title' to content of `output_text'.
		require
			non_void_title: a_title /= Void
		local
			l_underline: STRING
		do
			create l_underline.make (a_title.count)
			l_underline.fill_character ('-')
			append_text ("%R%N")
			append_text (a_title)
			append_text ("%R%N")
			append_text (l_underline)
			append_text ("%R%N%R%N")
			update_output
		end

	add_error (a_error: STRING) is
			-- Append error `a_error' to content of `output_text'.
		require
			non_void_error: a_error /= Void
		do
			append_text ("%R%NERROR: ")
			append_text (a_error)
			append_text ("%R%N")
			update_output
		end

	add_warning (a_warning: STRING) is
			-- Append warning `a_warning' to content of `output_text'.
		require
			non_void_warning: a_warning /= Void
		do
			append_text (a_warning)
			append_text ("%R%N")
			update_output
		end

	add_message (a_message: STRING) is
			-- Append message `a_message' to content of `output_text'.
		require
			non_void_message: a_message /= Void
		do
			append_text (a_message)
			append_text ("%R%N")
			update_output
		end
				
	add_text (a_text: STRING) is
			-- Append text `a_text' to content of `output_text'.
		require
			non_void_text: a_text /= Void
		do
			append_text (a_text)
			update_output
		end
	
	append_text (a_text: STRING) is
			-- Append `a_text' to `text', wrap lines of more than 1024 characters.
		require	
			non_void_text: a_text /= Void
		do	
			if a_text.count < 1023 then
				internal_text.append (a_text)
			else	
				internal_text.append (a_text.substring (1, 1022))
				internal_text.append ("%R%N")
				append_text (a_text.substring (1023, a_text.count))
			end
		end

	update_output is
			-- Append `a_text' to content of `output_text' using format `a_format'.
		local
			l_visible_lines, i, l_index: INTEGER
			l_displayed_text: STRING
		do
			l_visible_lines := output_text.visible_lines_count
			from
				l_index := internal_text.count
			until
				i >= l_visible_lines or l_index <= 0
			loop
				l_index := internal_text.last_index_of ('%N', l_index) - 1
				i := i + 1
			end
			if l_index > 0 then
				l_displayed_text := internal_text.substring (internal_text.count.min (l_index + 2), internal_text.count)
			else
				l_displayed_text := internal_text
			end
			output_text.set_text (l_displayed_text)
		end

	set_output is
			-- Set content of `output_text' with `text'
		local
			l_scroll: INTEGER
		do
			output_text.set_text (internal_text)
			l_scroll := output_text.line_count - output_text.visible_lines_count + 1
			if l_scroll > 0 then
				output_text.scroll_to_line (l_scroll)
			end
		end
		
	eiffelstudio_command (a_folder: STRING): STRING is
			-- Launch EiffelBench with first project in `a_folder'
		require
			non_void_folder: a_folder /= Void
			valid_folder: not a_folder.is_empty
		local
			l_directory: DIRECTORY
			l_file_list: LIST [STRING]
			l_found: BOOLEAN
			l_file: STRING
		do
			create Result.make (100)
			Result.append (Eiffel_installation_dir_name)
			Result.append ("\studio\spec\windows\bin\estudio ")
			create l_directory.make (a_folder)
			if l_directory.exists then
				from
					l_file_list := l_directory.linear_representation
					l_file_list.start
				until
					l_file_list.after or l_found
				loop
					l_file := l_file_list.item
					l_found := l_file.substring (l_file.count - 3, l_file.count).is_equal (".epr")
					if l_found then
						Result.append_character ('"')
						Result.append (a_folder)
						Result.append ("\")
						Result.append (l_file)
						Result.append_character ('"')
					end
					l_file_list.forth
				end
			end
			if not l_found then
				Result := Void
			end
		end

feature {NONE} -- Private Access

	internal_text: STRING
			-- Output text

	output_text: WIZARD_TEXT
			-- Output text

	default_parent: EV_INTERNAL_SILLY_WINDOW_IMP is
			-- Default parent for creation of `rich_text'
		once
			create Result.make_top ("Output")
		ensure
			valid_parent: Result /= Void
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
end -- class WIZARD_OUTPUT_BOX

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

