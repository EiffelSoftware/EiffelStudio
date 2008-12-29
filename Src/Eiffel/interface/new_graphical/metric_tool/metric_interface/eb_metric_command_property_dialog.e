note
	description: "Dialog to setup external command criterion"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_COMMAND_PROPERTY_DIALOG

inherit
	PROPERTY_DIALOG [
		TUPLE [command: STRING; working_directory: STRING; input: STRING; input_as_file: BOOLEAN;
			   output: STRING; output_enabled: BOOLEAN; output_as_file: BOOLEAN;
			   error: STRING; error_enabled: BOOLEAN; error_as_file: BOOLEAN; error_redirected_to_output: BOOLEAN;
			   exit_code: INTEGER; exit_code_enabled: BOOLEAN
		]]
		redefine
			initialize,
			on_ok,
			on_cancel
		end

	EB_CONSTANTS
		undefine
			copy,
			default_create
		end

	EV_UTILITIES
		undefine
			copy,
			default_create
		end

feature{NONE} -- Initialization

	initialize
			-- Initialize.
		local
			l_main: EV_VERTICAL_BOX
			l_cmd_line: EV_HORIZONTAL_BOX
			l_dir_line: EV_HORIZONTAL_BOX
			l_input_lbl_line: EV_HORIZONTAL_BOX
			l_input_line: EV_HORIZONTAL_BOX
			l_output_lbl_line: EV_HORIZONTAL_BOX
			l_output_line: EV_HORIZONTAL_BOX
			l_error_lbl_line: EV_HORIZONTAL_BOX
			l_error_line: EV_HORIZONTAL_BOX
			l_exit_code_line: EV_HORIZONTAL_BOX

			l_cmd_lbl: EV_LABEL
			l_dir_lbl: EV_LABEL
			l_input_lbl: EV_LABEL
			l_output_lbl: EV_LABEL
			l_error_lbl: EV_LABEL
			l_exit_code_lbl: EV_LABEL
			l_cell: EV_CELL
			l_browse_btn: EV_BUTTON
			l_dir_dlg: EV_DIRECTORY_DIALOG
			l_clear_input_tb: EV_TOOL_BAR
			l_clear_output_tb: EV_TOOL_BAR
			l_clear_error_tb: EV_TOOL_BAR
			l_pixmaps: EB_SHARED_PIXMAPS
			l_complete: EB_METRIC_CRITERION_PROVIDER
		do
			create l_browse_btn.make_with_text ("...")
			create ok_actions
			create cancel_actions
			create command_field
			create l_complete.make (placeholder_list)
			l_complete.set_code_completable (command_field)
			command_field.set_completion_possibilities_provider (l_complete)
			create working_directory_field
			create input_field
			create output_field
			create error_field
			create exit_code_field
			create output_enabled_check.make_with_text (metric_names.l_enabled)
			create error_enabled_check.make_with_text (metric_names.l_enabled)
			create error_redirected_check.make_with_text (metric_names.l_redirected_to_output)
			create exit_code_enabled_check.make_with_text (metric_names.l_enabled)
			create input_as_file_check.make_with_text (metric_names.l_as_file_name)
			create output_as_file_check.make_with_text (metric_names.l_as_file_name)
			create error_as_file_check.make_with_text (metric_names.l_as_file_name)
			create l_dir_dlg.make_with_title (interface_names.l_working_directory)
			l_dir_dlg.ok_actions.extend (agent set_working_directory (l_dir_dlg))
			l_browse_btn.select_actions.extend (agent l_dir_dlg.show_modal_to_window (Current))

				-- Initialize tool bars to clear input/ouput/error.
			create l_pixmaps
			create clear_input_btn
			create clear_output_btn
			create clear_error_btn
			create l_clear_input_tb
			create l_clear_output_tb
			create l_clear_error_tb
			clear_input_btn.set_pixmap (l_pixmaps.icon_pixmaps.general_reset_icon)
			clear_output_btn.set_pixmap (l_pixmaps.icon_pixmaps.general_reset_icon)
			clear_error_btn.set_pixmap (l_pixmaps.icon_pixmaps.general_reset_icon)
			l_clear_input_tb.extend (clear_input_btn)
			l_clear_output_tb.extend (clear_output_btn)
			l_clear_error_tb.extend (clear_error_btn)
			clear_input_btn.select_actions.extend (agent input_field.set_text (""))
			clear_output_btn.select_actions.extend (agent output_field.set_text (""))
			clear_error_btn.select_actions.extend (agent error_field.set_text (""))

			Precursor {PROPERTY_DIALOG}

			create l_main
			create l_cmd_line
			create l_dir_line
			create l_input_lbl_line
			create l_input_line
			create l_output_lbl_line
			create l_output_line
			create l_error_lbl_line
			create l_error_line
			create l_exit_code_line

				-- Setup main layout.
			extend_widget_in_box (l_cmd_line, False, l_main)
			extend_widget_in_box (l_dir_line, False, l_main)
			extend_cell_in_box (10, 10, False, l_main)
			extend_widget_in_box (l_input_lbl_line, False, l_main)
			extend_widget_in_box (l_input_line, True, l_main)
			extend_cell_in_box (10, 10, False, l_main)
			extend_widget_in_box (l_output_lbl_line, False, l_main)
			extend_widget_in_box (l_output_line, True, l_main)
			extend_cell_in_box (10, 10, False, l_main)
			extend_widget_in_box (l_error_lbl_line, False, l_main)
			extend_widget_in_box (l_error_line, True, l_main)
			extend_cell_in_box (10, 10, False, l_main)
			extend_widget_in_box (l_exit_code_line, False, l_main)

				-- Setup command line.
			create l_cmd_lbl.make_with_text (external_output_names.t_command_name)
			l_cmd_lbl.set_minimum_width (150)
			extend_widget_in_box (l_cmd_lbl, False, l_cmd_line)
			extend_widget_in_box (command_field, True, l_cmd_line)
			extend_cell_in_box (30, 10, False, l_cmd_line)

				-- Setup workding directory line
			create l_dir_lbl.make_with_text (metric_names.coloned_string (interface_names.l_working_directory, True))
			l_dir_lbl.set_minimum_width (150)
			extend_widget_in_box (l_dir_lbl, False, l_dir_line)
			l_dir_line.extend (working_directory_field)
			l_browse_btn.set_minimum_width (30)
			extend_widget_in_box (l_browse_btn, False, l_dir_line)

				-- Setup input label line.
			create l_input_lbl.make_with_text (metric_names.coloned_string (external_output_names.l_input, True))
			l_input_lbl.set_minimum_width (80)
			extend_widget_in_box (l_input_lbl, False, l_input_lbl_line)
			extend_cell_in_box (10, 10, False, l_input_lbl_line)
			input_as_file_check.set_minimum_width (150)
			extend_widget_in_box (input_as_file_check, False, l_input_lbl_line)
			extend_cell_in_box (10, 10, True, l_input_lbl_line)
			extend_widget_in_box (l_clear_input_tb, False, l_input_lbl_line)

				-- Setup input line.
			l_input_line.extend (input_field)

				-- Setup output label line.
			create l_output_lbl.make_with_text (metric_names.coloned_string (external_output_names.l_output, True))
			l_output_lbl.set_minimum_width (80)
			extend_widget_in_box (l_output_lbl, False, l_output_lbl_line)
			extend_cell_in_box (10, 10, False, l_output_lbl_line)
			output_as_file_check.set_minimum_width (150)
			extend_widget_in_box (output_as_file_check, False, l_output_lbl_line)
			extend_cell_in_box (10, 10, False, l_output_lbl_line)
			output_enabled_check.set_minimum_width (100)
			extend_widget_in_box (output_enabled_check, False, l_output_lbl_line)
			extend_cell_in_box (10, 10, True, l_output_lbl_line)
			extend_widget_in_box (l_clear_output_tb, False, l_output_lbl_line)

				-- Setup output line.
			l_output_line.extend (output_field)

				-- Setup error label line.
			create l_error_lbl.make_with_text (metric_names.coloned_string (interface_names.l_error, True))
			l_error_lbl.set_minimum_width (80)
			extend_widget_in_box (l_error_lbl, False, l_error_lbl_line)
			extend_cell_in_box (10, 10, False, l_error_lbl_line)

			error_as_file_check.set_minimum_width (150)
			extend_widget_in_box (error_as_file_check, False, l_error_lbl_line)
			extend_cell_in_box (10, 10, False, l_error_lbl_line)
			error_enabled_check.set_minimum_width (100)
			extend_widget_in_box (error_enabled_check, False, l_error_lbl_line)
			extend_cell_in_box (10, 10, False, l_error_lbl_line)
			extend_widget_in_box (error_redirected_check, False, l_error_lbl_line)
			extend_cell_in_box (10, 10, True, l_error_lbl_line)
			extend_widget_in_box (l_clear_error_tb, False, l_error_lbl_line)

				-- Setup error line.
			l_error_line.extend (error_field)

				-- Setup exit code line.
			create l_exit_code_lbl.make_with_text (metric_names.coloned_string (metric_names.l_exit_code, True))
			l_exit_code_lbl.set_minimum_width (80)
			extend_widget_in_box (l_exit_code_lbl, False, l_exit_code_line)

			exit_code_field.set_minimum_width (50)
			extend_widget_in_box (exit_code_field, False, l_exit_code_line)

			create l_cell
			l_cell.set_minimum_width (10)
			l_exit_code_line.extend (l_cell)
			l_exit_code_line.disable_item_expand (l_cell)
			l_exit_code_line.extend (exit_code_enabled_check)
			l_exit_code_line.disable_item_expand (exit_code_enabled_check)

			set_title (metric_names.l_setup_external_command)
			set_icon_pixmap (pixmaps.icon_pixmaps.tool_metric_icon)
			element_container.extend (l_main)

			show_actions.extend (agent on_show)

			l_cmd_lbl.align_text_left
			l_dir_lbl.align_text_left
			l_input_lbl.align_text_left
			l_output_lbl.align_text_left
			l_error_lbl.align_text_left
			l_exit_code_lbl.align_text_left

			input_as_file_check.select_actions.extend (agent update_ui)
			output_as_file_check.select_actions.extend (agent update_ui)
			error_as_file_check.select_actions.extend (agent update_ui)
			output_enabled_check.select_actions.extend (agent update_ui)
			error_enabled_check.select_actions.extend (agent update_ui)
			error_redirected_check.select_actions.extend (agent update_ui)
			exit_code_enabled_check.select_actions.extend (agent update_ui)
		end

feature -- Access

	ok_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when "OK" button is pressed

	cancel_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when "Cancel" button is pressed

	command_field: COMPLETABLE_TEXT_FIELD
			-- Text field to set command line

	working_directory_field: EV_TEXT_FIELD
			-- Text field to set command working directory

	input_field: EV_TEXT
			-- Text area to set command input

	output_field: EV_TEXT
			-- Text area to set command output

	error_field: EV_TEXT
			-- Text area to set command error

	output_enabled_check: EV_CHECK_BUTTON
			-- Check box to enable/disable output

	error_enabled_check: EV_CHECK_BUTTON
			-- Check box to enable/disable error

	error_redirected_check: EV_CHECK_BUTTON
			-- Check box to enable/disable error redirection to output

	exit_code_field: EV_TEXT_FIELD
			-- Text field to set exit code

	exit_code_enabled_check: EV_CHECK_BUTTON
			-- Check box to enable/disable exit code

	input_as_file_check: EV_CHECK_BUTTON
			-- Check box to enable/disable text in `input_field' as file name

	output_as_file_check: EV_CHECK_BUTTON
			-- Check box to enable/disable text in `output_field' as file name			

	error_as_file_check: EV_CHECK_BUTTON
			-- Check box to enable/disable text in `error_field' as file name			

	clear_input_btn: EV_TOOL_BAR_BUTTON
			-- Button to clear `input_field'

	clear_output_btn: EV_TOOL_BAR_BUTTON
			-- Button to clear `output_field'

	clear_error_btn: EV_TOOL_BAR_BUTTON
			-- Button to clear `error_field'

feature{NONE} -- Actions

	on_show
			-- Action to be performed when Current dialog is shown
		local
			l_value: like value
		do
			l_value := value
			if l_value = Void then
				l_value := ["", "", "", False, "", False, False, "", False, False, False, 0, False]
			end

			set_is_ui_update_blocked (True)
			command_field.set_text (l_value.command.as_string_32)
			working_directory_field.set_text (l_value.working_directory.as_string_32)
			input_field.set_text (l_value.input.as_string_32)
			output_field.set_text (l_value.output.as_string_32)
			error_field.set_text (l_value.error.as_string_32)
			exit_code_field.set_text (l_value.exit_code.out.as_string_32)

			update_checkbox_status (output_enabled_check, l_value.output_enabled)
			update_checkbox_status (error_enabled_check, l_value.error_enabled)
			update_checkbox_status (error_redirected_check, l_value.error_redirected_to_output)
			update_checkbox_status (exit_code_enabled_check, l_value.exit_code_enabled)
			update_checkbox_status (input_as_file_check, l_value.input_as_file)
			update_checkbox_status (output_as_file_check, l_value.output_as_file)
			update_checkbox_status (error_as_file_check, l_value.error_as_file)
			set_is_ui_update_blocked (False)
			update_ui
		end

	on_ok
			-- Action to be performed when "OK" button is pressed
		local
			l_value: like value
			l_exit_code: INTEGER
		do
			if ok_button.has_focus then
				if exit_code_field.text.is_integer then
					l_exit_code := exit_code_field.text.to_integer
				end
				l_value := [
						command_field.text.as_string_8,
						working_directory_field.text.as_string_8,
						input_field.text.as_string_8,
						input_as_file_check.is_selected,
						output_field.text.as_string_8,
						output_enabled_check.is_selected,
						output_as_file_check.is_selected,
						error_field.text.as_string_8,
						error_enabled_check.is_selected,
						error_as_file_check.is_selected,
						error_redirected_check.is_selected,
						l_exit_code,
						exit_code_enabled_check.is_selected
					]

				l_value.compare_objects
				set_value (l_value)
				Precursor {PROPERTY_DIALOG}
				ok_actions.call (Void)
			end
		end

	on_cancel
			-- Action to be performed when "Cancel" button is pressed
		do
			Precursor
			cancel_actions.call (Void)
		end

feature{NONE} -- Implementation

	is_ui_update_blocked: BOOLEAN
			-- Is `update_ui' blocked?

	set_is_ui_update_blocked (b: BOOLEAN)
			-- Set `is_ui_update_blocked' with `b'.
		do
			is_ui_update_blocked := b
		ensure
			is_ui_update_blocked_set: is_ui_update_blocked = b
		end


	update_ui
			-- Update interface.
		local
			l_text: EV_TEXT
			l_lbl: EV_LABEL
			l_sensitive_bg_color: EV_COLOR
			l_insensitive_bg_color: EV_COLOR
			l_color: SD_SYSTEM_COLOR_IMP
		do
			create l_text
			create l_lbl
			create l_color.make
			l_sensitive_bg_color := l_text.background_color
			l_insensitive_bg_color := l_color.default_background_color
			if not is_ui_update_blocked then
				if output_enabled_check.is_selected then
					output_as_file_check.enable_sensitive
					output_field.enable_sensitive
					output_field.set_background_color (l_sensitive_bg_color)
					clear_output_btn.enable_sensitive
				else
					output_as_file_check.disable_sensitive
					output_field.disable_sensitive
					output_field.set_background_color (l_insensitive_bg_color)
					clear_output_btn.disable_sensitive
				end

				if error_enabled_check.is_selected then
					error_redirected_check.enable_sensitive
					if error_redirected_check.is_selected then
						error_as_file_check.disable_sensitive
						error_field.disable_sensitive
					else
						error_as_file_check.enable_sensitive
						error_field.enable_sensitive
					end
				else
					error_as_file_check.disable_sensitive
					error_redirected_check.disable_sensitive
					error_field.disable_sensitive
				end
				if error_field.is_sensitive then
					error_field.set_background_color (l_sensitive_bg_color)
					clear_error_btn.enable_sensitive
				else
					error_field.set_background_color (l_insensitive_bg_color)
					clear_error_btn.disable_sensitive
				end

				if exit_code_enabled_check.is_selected then
					exit_code_field.enable_sensitive
				else
					exit_code_field.disable_sensitive
				end
			end
		end

	update_checkbox_status (a_checkbox: EV_CHECK_BUTTON; a_selected: BOOLEAN)
			-- Update selection status of `a_checkbox' with `a_selected'.
		require
			a_checkbox_attached: a_checkbox /= Void
		do
			if a_selected then
				a_checkbox.enable_select
			else
				a_checkbox.disable_select
			end
		end

	extend_cell_in_box (a_width, a_height: INTEGER; a_expand_allowed: BOOLEAN; a_box: EV_BOX)
			-- Insert an EV_CELL with (`a_width', `a_height') as mininum width and height into `a_box'.
			-- If `a_expanded_allowed' is True, allow that inserted EV_CELL to expand.
		require
			a_box_attached: a_box /= Void
		local
			l_cell: EV_CELL
		do
			create l_cell
			l_cell.set_minimum_size (a_width, a_height)
			a_box.extend (l_cell)
			if not a_expand_allowed then
				a_box.disable_item_expand (l_cell)
			end
		end

	extend_widget_in_box (a_widget: EV_WIDGET; a_allow_expand: BOOLEAN; a_box: EV_BOX)
			-- Insert `a_widget' into `a_box'.
		require
			a_widget_attached: a_widget /= Void
			a_box_attached: a_box /= Void
		do
			a_box.extend (a_widget)
			if not a_allow_expand then
				a_box.disable_item_expand (a_widget)
			end
		end

	set_working_directory (a_dir_dlg: EV_DIRECTORY_DIALOG)
			-- Set text of `working_directory_field' with directory specified in `a_dir_dlg'.
		require
			a_dir_dlg_attached: a_dir_dlg /= Void
		do
			working_directory_field.set_text (a_dir_dlg.directory)
		end

	show_dialog (a_dialog: EV_STANDARD_DIALOG)
			-- Show `a_dialog'.
		require
			a_dialog_attached: a_dialog /= Void
		do
			a_dialog.show_modal_to_window (parent_window (Current))
		end

	placeholder_list: SORTABLE_ARRAY [NAME_FOR_COMPLETION]
			-- Placeholder list
		do
			if placeholder_list_internal = Void then
				create placeholder_list_internal.make (1, 12)
				placeholder_list_internal.put (create {NAME_FOR_COMPLETION}.make ("$file_name"), 1)
				placeholder_list_internal.put (create {NAME_FOR_COMPLETION}.make ("$path"), 2)
				placeholder_list_internal.put (create {NAME_FOR_COMPLETION}.make ("$file"), 3)
				placeholder_list_internal.put (create {NAME_FOR_COMPLETION}.make ("$class_name"), 4)
				placeholder_list_internal.put (create {NAME_FOR_COMPLETION}.make ("$directory_name"), 5)
				placeholder_list_internal.put (create {NAME_FOR_COMPLETION}.make ("$group_name"), 6)
				placeholder_list_internal.put (create {NAME_FOR_COMPLETION}.make ("$group_directory"), 7)
				placeholder_list_internal.put (create {NAME_FOR_COMPLETION}.make ("$project_directory"), 8)
				placeholder_list_internal.put (create {NAME_FOR_COMPLETION}.make ("$target_directory"), 9)
				placeholder_list_internal.put (create {NAME_FOR_COMPLETION}.make ("$f_code"), 10)
				placeholder_list_internal.put (create {NAME_FOR_COMPLETION}.make ("$w_code"), 11)
				placeholder_list_internal.put (create {NAME_FOR_COMPLETION}.make ("$target_name"), 12)
				placeholder_list_internal.sort
			end
			Result := placeholder_list_internal
		ensure
			result_attached: Result /= Void
		end

	placeholder_list_internal: like placeholder_list
			-- Implementation of `placeholder_list'

end


