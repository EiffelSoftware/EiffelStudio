indexing
	description: "Output notebook tab, can display messages, titles and errors"
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

	WIZARD_OUTPUT_FORMAT_CONSTANTS
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

feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
		do
			progress_bar.disable_segmentation
			progress_bar_label.set_text ("Ready.")
			output_text.set_background_color ((create {EV_STOCK_COLORS}).Color_read_write)
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
		
feature -- Basic Operations

	clear is
			-- Clear output.
		do
			output_text.remove_text
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
					add_output (l_output_event.text + "%N", Title_format)
				when feature {WIZARD_OUTPUT_EVENT_ID}.Display_text then
					add_output (l_output_event.text, Message_format)
				when feature {WIZARD_OUTPUT_EVENT_ID}.Display_message then
					add_output (l_output_event.text + "%N", Message_format)
				when feature {WIZARD_OUTPUT_EVENT_ID}.Display_warning then
					add_output (l_output_event.text + "%N", Warning_format)
				when feature {WIZARD_OUTPUT_EVENT_ID}.Display_error then
					add_output (l_output_event.text + "%N", Error_format)
				when feature {WIZARD_OUTPUT_EVENT_ID}.Clear then
					clear
				else
					check
						should_not_be_here: False
					end
				end
			else
				l_progress_event ?= a_event
				check
					is_output_or_progress: l_progress_event /= Void
				end
				inspect
					l_progress_event.id
				when feature {WIZARD_PROGRESS_EVENT_ID}.Start then
					percentage_label.set_text ("0")
					task_percentage_label.set_text ("0")
					progress_bar_box.show
					task_progress_bar_box.show
					stop_button.enable_sensitive
					exit_button.disable_sensitive
					save_button.disable_sensitive
					open_eiffelstudio_button.disable_sensitive
					final_message_box.hide
				when feature {WIZARD_PROGRESS_EVENT_ID}.Finish then
					progress_bar_box.hide
					task_progress_bar_box.hide
					progress_bar_label.set_text ("Ready.")
					stop_button.disable_sensitive
					exit_button.enable_sensitive
					save_button.enable_sensitive
					if not environment.abort then
						check
							step_called_correctly: progress_bar.value = progress_bar.value_range.upper
							task_step_called_correctly: task_progress_bar.value = task_progress_bar.value_range.upper
						end
						if environment.compile_eiffel then
							open_eiffelstudio_button.enable_sensitive
						end
					end
					destination_path_label.set_text (environment.destination_folder)
					final_message_box.show
				when feature {WIZARD_PROGRESS_EVENT_ID}.Step then
					check
						not_finished: progress_bar.value < (progress_bar.value_range.upper - progress_bar.value_range.lower)
						not_task_finished: task_progress_bar.value < (task_progress_bar.value_range.upper - task_progress_bar.value_range.lower)
					end
					progress_bar.step_forward
					task_progress_bar.step_forward
			print ("total: " + progress_bar.value.out + " / " + (progress_bar.value_range.upper - progress_bar.value_range.lower).out + "%N")
			print ("task:  " + task_progress_bar.value.out + " / " + (task_progress_bar.value_range.upper - task_progress_bar.value_range.lower).out + "%N%N")
					l_percent := ((progress_bar.value / (progress_bar.value_range.upper - progress_bar.value_range.lower)) * 100).rounded
					percentage_label.set_text (l_percent.out)
					l_percent := ((task_progress_bar.value / (task_progress_bar.value_range.upper - task_progress_bar.value_range.lower)) * 100).rounded
					task_percentage_label.set_text (l_percent.out)
				when feature {WIZARD_PROGRESS_EVENT_ID}.Set_range then
					progress_bar.value_range.resize_exactly (0, l_progress_event.value)
					progress_bar.set_value (0)
					percentage_label.set_text ("0")
				when feature {WIZARD_PROGRESS_EVENT_ID}.Set_task_range then
					task_progress_bar.value_range.resize_exactly (0, l_progress_event.value)
					task_progress_bar.set_value (0)
					task_percentage_label.set_text ("0")
				when feature {WIZARD_PROGRESS_EVENT_ID}.Title then
					progress_bar_label.set_text (l_progress_event.text_value)
				when feature {WIZARD_PROGRESS_EVENT_ID}.Task_title then
					task_progress_bar_label.set_text (l_progress_event.text_value)
				else
					check
						should_not_be_here: False
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
			environment.set_abort (Standard_abort_value)
			stop_button.disable_sensitive
			progress_bar_label.set_text ("Stopping....")
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
			l_dialog: EV_FILE_OPEN_DIALOG
			l_file_name: STRING
		do
			create l_dialog.make_with_title ("Browse for log file")
			l_dialog.filters.extend (["*.rtf", "Rich Text File (*.rtf)"])
			l_dialog.set_file_name (environment.project_name + "_log.rtf")
			l_dialog.show_modal_to_window ((create {EV_UTILITIES}).parent_window (Current))
			l_file_name := l_dialog.file_name.as_lower
			if not l_file_name.is_empty then
				if l_file_name.substring_index (".rtf", l_dialog.file_name.count - 3) = 0 then
					l_file_name.append (".rtf")
				end
				output_text.save_to_named_file (l_file_name)
			end
		end

feature {NONE} -- Implementation

	add_output (a_text: STRING; a_format: EV_CHARACTER_FORMAT) is
			-- Append `a_text' to content of `output_text' using format `a_format'.
		require
			non_void_text: a_text /= Void
			non_void_format: a_format /= Void
		local
			l_length, l_start_line, l_end_line: INTEGER
		do
			output_text.buffered_append (a_text, a_format)
			l_length := output_text.text_length
			output_text.flush_buffer_to (l_length + 1, l_length + 1)
			l_start_line := output_text.line_number_from_position (output_text.index_from_position (0, 0))
			l_end_line := output_text.line_number_from_position (output_text.index_from_position (0, output_text.height))
			output_text.scroll_to_line (output_text.line_count - (l_end_line - l_start_line) + 1)
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
						Result.append (l_file)
					end
					l_file_list.forth
				end
			end
			if not l_found then
				Result := Void
			end
		end

end -- class WIZARD_OUTPUT_BOX

