indexing
	description	: "Tool where output and error of external commands are displayed."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: ""

class
	ES_C_OUTPUT_TOOL_PANEL

inherit
	ES_OUTPUT_TOOL_PANEL
		undefine
			Ev_application
		redefine
			make,
			clear, internal_recycle, scroll_to_end,set_focus,
			quick_refresh_editor,quick_refresh_margin,
			is_general,
			attach_to_docking_manager,
			build_docking_content,
			show,
			pixmap_failure,
			pixmap_success
		end

	EB_EXTERNAL_OUTPUT_CONSTANTS

	SHARED_PLATFORM_CONSTANTS

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	EB_CONSTANTS

	PROJECT_CONTEXT

	SHARED_WORKBENCH

	EB_TEXT_OUTPUT_TOOL

	SHARED_FLAGS

	SYSTEM_CONSTANTS

	SHARED_CODE_FILES

	SHARED_GENERATION

create
	make

feature{NONE} -- Initialization

	make (a_tool: EB_DEVELOPMENT_WINDOW; a_desc: like tool_descriptor) is
			-- Create a new external output tool.
		do
			develop_window := a_tool
			tool_descriptor := a_desc
			initialization (a_tool)
			widget := l_ev_vertical_box_1
			c_compilation_output_manager.extend (Current)
		end

	build_docking_content (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Build docking content.
		do
			Precursor {ES_OUTPUT_TOOL_PANEL}(a_docking_manager)
			content.drop_actions.extend (agent set_stone)
		end

	initialization (a_tool: EB_DEVELOPMENT_WINDOW) is
			-- Initialize interface.
		local
			l_ev_tool_bar_separator_1: SD_TOOL_BAR_SEPARATOR
			l_ev_tool_bar_1: SD_TOOL_BAR
			l_ev_save_toolbar: SD_TOOL_BAR
			l_ev_h_area_1: EV_HORIZONTAL_BOX
			l_cell: EV_CELL
			l_locale_lbl: EV_LABEL
		do
			create l_ev_vertical_box_1
			create l_ev_tool_bar_1.make
			create save_output_btn.make
			create l_ev_tool_bar_separator_1.make
			create w_code_btn.make
			create f_code_btn.make
			create l_ev_h_area_1
			create clear_output_btn.make
			create l_ev_save_toolbar.make
			create open_editor_btn.make
			create message_label
			create project_dir_btn.make
			create l_cell
			create l_locale_lbl

			message_label.align_text_left
			l_ev_h_area_1.extend (message_label)
			locale_combo.set_minimum_width (200)
			l_ev_h_area_1.extend (l_locale_lbl)
			l_ev_h_area_1.extend (locale_combo)
			l_cell.set_minimum_height (10)
			l_ev_h_area_1.extend (l_cell)
			l_ev_h_area_1.extend (l_ev_save_toolbar)
			l_ev_h_area_1.extend (l_ev_tool_bar_1)
			l_ev_h_area_1.disable_item_expand (l_cell)
			l_ev_h_area_1.disable_item_expand (l_locale_lbl)
			l_ev_h_area_1.disable_item_expand (locale_combo)
			l_ev_h_area_1.disable_item_expand (l_ev_save_toolbar)
			l_ev_h_area_1.disable_item_expand (l_ev_tool_bar_1)

				-- Build_widget_structure.
			l_ev_vertical_box_1.extend (output_text)
			l_ev_save_toolbar.extend (open_editor_btn)
			l_ev_save_toolbar.extend (save_output_btn)
			l_ev_save_toolbar.extend (clear_output_btn)
			l_ev_tool_bar_1.extend (l_ev_tool_bar_separator_1)
			l_ev_tool_bar_1.extend (project_dir_btn)
			l_ev_tool_bar_1.extend (w_code_btn)
			l_ev_tool_bar_1.extend (f_code_btn)
			l_ev_vertical_box_1.extend (l_ev_h_area_1)
			l_ev_vertical_box_1.disable_item_expand (l_ev_h_area_1)

			open_editor_btn.set_tooltip (interface_names.e_open_selection_in_editor)
			open_editor_btn.set_pixmap (stock_pixmaps.command_send_to_external_editor_icon)
			open_editor_btn.set_pixel_buffer (stock_pixmaps.command_send_to_external_editor_icon_buffer)
			open_editor_btn.select_actions.extend (agent on_open_selected_text_in_external_editor)

			save_output_btn.set_pixmap (stock_pixmaps.general_save_icon)
			save_output_btn.set_pixel_buffer (stock_pixmaps.general_save_icon_buffer)
			save_output_btn.set_tooltip (interface_names.e_save_c_compilation_output)
			save_output_btn.select_actions.extend (agent on_save_output_to_file)

			w_code_btn.set_text (interface_names.e_w_code)
			w_code_btn.set_pixmap (stock_pixmaps.general_open_icon)
			w_code_btn.set_pixel_buffer (stock_pixmaps.general_open_icon_buffer)
			w_code_btn.select_actions.extend (agent on_go_to_w_code)
			w_code_btn.set_tooltip (concatenated_tooltip (interface_names.e_go_to_w_code_dir, interface_names.e_open_c_file))
			w_code_btn.pointer_button_press_actions.extend (agent on_open_w_code_in_file_browser)
			w_code_btn.drop_actions.extend (agent on_open_c_file (?, True))

			f_code_btn.set_text (interface_names.e_f_code)
			f_code_btn.set_pixmap (stock_pixmaps.general_open_icon)
			f_code_btn.set_pixel_buffer (stock_pixmaps.general_open_icon_buffer)
			f_code_btn.select_actions.extend (agent on_go_to_f_code)
			f_code_btn.pointer_button_press_actions.extend (agent on_open_f_code_in_file_browser)
			f_code_btn.set_tooltip (concatenated_tooltip (interface_names.e_go_to_f_code_dir, interface_names.e_open_c_file))
			f_code_btn.drop_actions.extend (agent on_open_c_file (?, False))

			project_dir_btn.set_text (interface_names.e_open_project)
			project_dir_btn.set_pixmap (stock_pixmaps.document_eiffel_project_icon)
			project_dir_btn.set_pixel_buffer (stock_pixmaps.document_eiffel_project_icon_buffer)
			project_dir_btn.select_actions.extend (agent on_go_to_project_dir)
			project_dir_btn.pointer_button_press_actions.extend (agent on_open_project_dir_in_file_browser)
			project_dir_btn.set_tooltip (interface_names.e_go_to_project_dir)
			project_dir_btn.drop_actions.extend (agent on_pebble_drop)

			clear_output_btn.set_pixmap (stock_pixmaps.general_reset_icon)
			clear_output_btn.set_pixel_buffer (stock_pixmaps.general_reset_icon_buffer)
			clear_output_btn.set_tooltip (f_clear_output)
			clear_output_btn.select_actions.extend (agent on_clear_output_window)

			output_text.drop_actions.extend (agent drop_class)
			output_text.drop_actions.extend (agent drop_feature)
			output_text.drop_actions.extend (agent drop_cluster)
			output_text.drop_actions.extend (agent drop_breakable)

			output_text.change_actions.extend (agent on_text_change)

			on_text_change

			output_text.set_foreground_color (preferences.editor_data.normal_text_color)
			output_text.set_background_color (preferences.editor_data.normal_background_color)
			output_text.set_font (preferences.editor_data.font)
			output_text.disable_edit
			message_label.set_foreground_color ((create{EV_STOCK_COLORS}).red)

			l_ev_tool_bar_1.compute_minimum_size
			l_ev_save_toolbar.compute_minimum_size

			l_locale_lbl.set_text (interface_names.l_locale)
		end

	pixmap_failure: EV_PIXMAP is
			-- Pixmap shown when c compilation failed.
		do
			Result := stock_pixmaps.tool_c_output_failed_icon
		end

	pixmap_success: EV_PIXMAP is
			-- Pixmap shown when c compilation successed.
		do
			Result := stock_pixmaps.tool_c_output_successful_icon
		end

feature -- Command

	attach_to_docking_manager (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Attach to docking manager
		do
			build_docking_content (a_docking_manager)

			check friend_tool_created: develop_window.tools.external_output_tool /= Void end
			check not_already_has: not a_docking_manager.has_content (content) end
			a_docking_manager.contents.extend (content)
		end

	set_stone (a_stone: ANY) is
			-- Set `a_stone' into Current.
		do
			on_open_c_file (a_stone, True)
		end

feature -- Basic operation

	clear is
			-- Clear window
		do
			output_text.set_text ("")
			on_text_change
			message_label.set_text ("")
		end

	scroll_to_end is
			-- Scroll the console to the bottom.
		do
			output_text.scroll_to_end
		end

	set_focus is
			-- Give the focus to the editor.
		do
		end

	quick_refresh_editor is
			-- Refresh the editor.
		do
		end

	quick_refresh_margin is
			-- Refresh the editor's margin.
		do
		end

--	process_block_text (text_block: EB_PROCESS_IO_DATA_BLOCK) is
--			-- Print `text_block' on `console'.
--		local
--			str: STRING
--		do
--			str ?= text_block.data
--			if str /= Void then
--				if source_encoding /= Void and then destination_encoding /= Void then
--					output_text.append_text (source_encoding.convert_to (destination_encoding, str))
--				else
--					output_text.append_text (str)
--				end
--			end
--		end

	show is
			-- Show tool.
		do
			Precursor {ES_OUTPUT_TOOL_PANEL}
			if text_area /= Void then
				text_area.editor_drawing_area.set_focus
			end
		end

feature -- Action

	on_c_compilation_output_finished is
			-- Action to be performed when all output from c compilation has been finished
		do
			on_text_change
		end

	on_save_output_to_file is
			-- Called when user press Save output button.
		local
			save_tool: EB_SAVE_STRING_TOOL
		do
			if process_manager.is_c_compilation_running then
				show_error_dialog (Warning_messages.w_cannot_save_when_c_compilation_running, develop_window.window)
			else
				create save_tool.make_and_save (output_text.text, develop_window.window)
			end
		end

	on_clear_output_window is
			-- Clear output window.
		do
			if process_manager.is_c_compilation_running then
				show_error_dialog (Warning_messages.w_cannot_clear_when_c_compilation_running, develop_window.window)
			else
				clear
			end
		end

	on_go_to_w_code is
			-- Go to W_code directory of current Eiffel system.		
		do
			go_to_dir (file_location (True))
		end

	on_go_to_f_code is
			-- Go to F_code directory of current Eiffel system.
		do
			go_to_dir (file_location (False))
		end

	on_open_selected_text_in_external_editor is
			-- Open selected text from `output_text' as file name in external editor.
		local
			req: COMMAND_EXECUTOR
		do
			if has_selected_file then
				check
					selected_file_exists: selected_file_path /= Void
				end
				create req
				req.execute (preferences.misc_data.external_editor_cli (selected_file_path, 1))
			end
		end

	on_text_change is
			-- Action performed when text changes in `output_text'
		local
			l_save_and_clear_need_sensitive: BOOLEAN
		do
			if output_text.text_length > 0 and then not process_manager.is_c_compilation_running then
				l_save_and_clear_need_sensitive := True
			end
			if l_save_and_clear_need_sensitive then
				if not save_output_btn.is_sensitive then
					save_output_btn.enable_sensitive
				end
				if not clear_output_btn.is_sensitive then
					clear_output_btn.enable_sensitive
				end
			else
				if save_output_btn.is_sensitive then
					save_output_btn.disable_sensitive
				end
				if clear_output_btn.is_sensitive then
					clear_output_btn.disable_sensitive
				end
			end
			if output_text.text_length > 0 then
				if not open_editor_btn.is_sensitive then
					open_editor_btn.enable_sensitive
				end
			else
				if open_editor_btn.is_sensitive then
					open_editor_btn.disable_sensitive
				end
			end
		end

	on_open_w_code_in_file_browser (x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
			-- Action to be performed when open W_code in file browser
		do
			if button = {EV_POINTER_CONSTANTS}.right then
				open_dir_in_file_browser (project_location.workbench_path)
			end
		end

	on_open_f_code_in_file_browser (x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
			-- Action to be performed when open F_code in file browser
		do
			if button = {EV_POINTER_CONSTANTS}.right then
				open_dir_in_file_browser (project_location.final_path)
			end
		end

	on_go_to_project_dir is
			-- Go to project directory of current Eiffel system.
		do
			if workbench.system_defined then
				go_to_dir (project_location.path)
			else
				show_no_system_defined_dlg
			end
		end

	on_open_project_dir_in_file_browser (x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
			-- Action to be performed when open project in file browser
		do
			if button = {EV_POINTER_CONSTANTS}.right then
				open_dir_in_file_browser (project_location.path)
			end
		end

	on_pebble_drop (a_pebble: ANY) is
			-- Action to be performed when `a_pebble' is dropped on `w_code_btn', `f_code_btn' or `project_dir_btn'.
		local
			l_class_stone: CLASSI_STONE
			l_cluster_stone: CLUSTER_STONE
			l_path: STRING
		do
			l_class_stone ?= a_pebble
			if l_class_stone /= Void then
				l_path := l_class_stone.class_i.group.location.build_path (l_class_stone.class_i.path, "")
			else
				l_cluster_stone ?= a_pebble
				if l_cluster_stone /= Void then
					if not l_cluster_stone.path.is_empty then
							-- For a folder
						l_path := l_cluster_stone.group.location.build_path (l_cluster_stone.path, "")
					else
						l_path := l_cluster_stone.group.location.evaluated_path
					end
				end
			end
			if l_path /= Void then
				open_dir_in_file_browser (l_path)
			end
		end

	on_open_c_file (a_pebble: ANY; a_workbench: BOOLEAN) is
			-- Action to be performed to open generated c file for stone `a_pebble'.
			-- `a_workbench' is True means workbench mode, otherwise finalized mode.
		local
			l_class_stone: CLASSC_STONE
			l_feature_stone: FEATURE_STONE
			l_mapper: EB_EIFFEL_C_FUNCTION_MAPPER
			l_table: HASH_TABLE [CLASS_TYPE, STRING]
		do
			if workbench.system_defined then
				l_feature_stone ?= a_pebble
				if l_feature_stone /= Void then
					create l_mapper.create_with_feature (l_feature_stone.e_feature, a_workbench)
				else
					l_class_stone ?= a_pebble
					if l_class_stone /= Void then
						create l_mapper.create_with_class (l_class_stone.e_class, a_workbench)
					end
				end
				if l_mapper /= Void then
					l_table := l_mapper.valid_c_file_table
					if l_table.count = 1 then
						l_table.start
						open_c_file_in_editor (l_table.key_for_iteration, l_mapper.line_number (l_table.key_for_iteration))
					elseif l_table.count > 1 then
						c_file_dialog.set_mapper (l_mapper)
						c_file_dialog.show_modal_to_window (develop_window.window)
					end
				end
			end
		end

feature -- Status reporting

	owner_development_window: EB_DEVELOPMENT_WINDOW is
			-- Development window which `Current' is belonged to
		do
			Result := develop_window
		end

	is_general: BOOLEAN is false
			-- Is general output tool?	

feature -- C output pixmap management

	start_c_output_pixmap_timer is
			-- Start timer to draw pixmap animation on c output panel
		do
			c_output_timer_counter := 1
			c_output_pixmap_timer.set_interval (300)
		end

	stop_c_output_pixmap_timer is
			-- Stop timer to draw pixmap animation on c output panel
		do
			c_output_pixmap_timer.set_interval (0)
			-- When stop c output, we set pixmap base on the C compilation result.

			if develop_window.finalizing_launcher.is_last_c_compilation_successful then
				draw_pixmap_on_tab (pixmap_success)
			else
				draw_pixmap_on_tab (pixmap_failure)
			end
		end

	c_output_timer_counter: INTEGER
			-- Counter to indicate which pixmap should be displayed

	c_output_pixmap_timer: EV_TIMEOUT is
			-- Timer to draw c output pixmap
		once
			Create Result
			Result.set_interval (0)
			Result.actions.extend (agent on_draw_c_output_pixmap)
		end

	on_draw_c_output_pixmap is
			-- Draw pixmap animation for C output.
		do
			draw_pixmap_on_tab (stock_pixmaps.compile_animation_anim.item (c_output_timer_counter))
			c_output_timer_counter := c_output_timer_counter + 1
			if c_output_timer_counter > 10 then
				c_output_timer_counter := 1
			end
		end

	draw_pixmap_on_tab (a_pixmap: EV_PIXMAP) is
			-- Draw `a_pixmap' on `a_tab'.
			-- If `a_pixmap' is Void, clear any existing pixmap on `a_tab'.
		do
			content.set_pixmap (a_pixmap)
		end

feature{NONE}	-- Implementation

	go_to_dir (a_dir: STRING) is
			-- Open a console and go to directory `a_dir'.
		local
			prc_launcher: EB_PROCESS_LAUNCHER
		do
			if a_dir /= Void and then not a_dir.is_empty then
				prc_launcher := external_launcher
				prc_launcher.open_console_in_dir (a_dir)
			else
				show_no_system_defined_dlg
			end
		end

	open_dir_in_file_browser (a_dir: STRING) is
			-- Open `a_dir' in file browser.
		require
			a_dir_not_void: a_dir /= Void
			a_dir_not_empty: not a_dir.is_empty
		local
			prc_launcher: EB_PROCESS_LAUNCHER
		do
			if workbench.system_defined then
				prc_launcher := external_launcher
				prc_launcher.open_dir_in_file_browser (a_dir)
			else
				show_no_system_defined_dlg
			end
		end

	show_no_system_defined_dlg is
			-- Show a dialog warning no eiffel system defined.
		do
			show_error_dialog (warning_messages.w_no_system_defined, develop_window.window)
		end

	show_error_dialog (msg: STRING_GENERAL; a_window: EV_WINDOW) is
			-- Show a error dialog containing message `msg' in `a_window'.
		require
			msg_not_void: msg /= Void
			msg_not_empty: not msg.is_empty
			a_window_not_void: a_window /= Void
		local
			l_error: ES_ERROR_PROMPT
		do
			create l_error.make_standard (msg)
			l_error.show (a_window)
		end

	has_selected_file: BOOLEAN is
			-- Does selected text (if any) in `output_text' represent a correct file name?
		local
			l_file: RAW_FILE
			l_path: ARRAYED_LIST [STRING]
			l_selected_text: STRING
		do
			if output_text.has_selection then
				display_status_message (interface_names.l_searching_selected_file)
				l_selected_text := output_text.selected_text.twin
				create l_file.make (l_selected_text)
				if l_file.exists then
					Result := True
					selected_file_path := output_text.selected_text.twin
				end
				if not Result then
					create l_path.make (2)
					if is_last_c_compilation_freezing then
						l_path.extend (project_location.workbench_path)
						l_path.extend (project_location.final_path)
					else
						l_path.extend (project_location.final_path)
						l_path.extend (project_location.workbench_path)
					end
					l_selected_text.left_adjust
					l_selected_text.right_adjust
					if not l_selected_text.is_empty then
						selected_file_path := file_in_path (l_path.i_th (1), l_selected_text)
						Result := selected_file_path /= Void
						if not Result then
							selected_file_path := file_in_path (l_path.i_th (2), l_selected_text)
							Result := selected_file_path /= Void
						end
					end
				end
				if selected_file_path /= Void then
					display_status_message ("")
				else
					display_status_message (interface_names.l_selected_file_not_found)
				end
			else
				display_status_message (interface_names.e_no_text_is_selected)
			end
		end

	file_in_path (start_path: STRING; keyword: STRING): STRING is
			-- Find file whose path contains `keyword' starting from `start_path'.
			-- If found, return final path of the file, otherwise, return Void.
		require
			start_path_attached: start_path /= Void
			keyword_attached: keyword /= Void
			not_keyword_is_empty: not keyword.is_empty
		local
			l_dir: DIRECTORY
			l_file: RAW_FILE
			l_path: STRING
			l_end_with_separator: BOOLEAN
			l_start_with_separator: BOOLEAN
			l_name: STRING
			l_dot: STRING
			l_dotdot: STRING
		do
			create l_dir.make (start_path)
			if l_dir.exists then
				l_start_with_separator := path_start_with_dir_separator (keyword)
				l_end_with_separator := path_end_with_dir_separator (start_path)
				l_name := start_path.twin
				if not l_start_with_separator and not l_end_with_separator then
					l_name.append_character (directory_separator)
				end
				l_name.append (keyword)
				create l_file.make (l_name)
				if l_file.exists and then not l_file.is_directory then
					Result := l_name
				else
					l_dot := once "."
					l_dotdot := once ".."
					create l_dir.make_open_read (start_path)
					create l_path.make (start_path.count + 50)
					l_path.append (start_path)
					if not l_end_with_separator then
						l_path.append (directory_separator.out)
					end
					from
						l_dir.readentry
					until
						l_dir.lastentry = Void or Result /= Void
					loop
						if not
							(l_dir.lastentry.is_equal (l_dot) or
							l_dir.lastentry.is_equal (l_dotdot))
						then
							l_name := l_path.twin
							l_name.append (l_dir.lastentry)
							create l_file.make (l_name)
							if l_file.is_directory then
								Result := file_in_path (l_name, keyword)
							end
						end
						l_dir.readentry
					end
				end
			end
		end

	display_status_message (a_msg: STRING_GENERAL) is
			-- Display message `a_msg' in `message_label'.
		require
			a_msg_attached: a_msg /= Void
		do
			check message_label /= Void end
			message_label.set_text (a_msg)
		ensure
			message_set: message_label.text.is_equal (a_msg)
		end

	open_c_file_in_editor (a_file_name: STRING; a_line_number: INTEGER) is
			-- Open `a_file_name' in external editor and scroll to line `a_line_number'.
		local
			req: COMMAND_EXECUTOR
		do
			create req
			req.execute (preferences.misc_data.external_editor_cli (a_file_name, a_line_number))
		end

feature{NONE} -- Implementation

	l_ev_vertical_box_1: EV_VERTICAL_BOX

	save_output_btn: SD_TOOL_BAR_BUTTON
			-- Button to save c compilation output to a file

	w_code_btn: SD_TOOL_BAR_BUTTON
			-- Button to go to W_code directory

	f_code_btn: SD_TOOL_BAR_BUTTON
			-- Button to go to F_code directory

	project_dir_btn: SD_TOOL_BAR_BUTTON
			-- Button to open directory of current project

	save_file_dlg: EV_FILE_SAVE_DIALOG
			-- File dialog to let user choose a file.

	clear_output_btn: SD_TOOL_BAR_BUTTON;
			-- Button to clear output window.

	open_editor_btn: SD_TOOL_BAR_BUTTON
			-- Button to open selected text in `console' in an external editor

	directory_separator: CHARACTER is
			-- Directory separator
		local
			l_obj: ANY
		once
			create l_obj
			Result := l_obj.operating_environment.directory_separator
		end

	path_end_with_dir_separator (path: STRING): BOOLEAN is
			-- Does `path' end with dir separator of current running system?
		require
			path_not_void: path /= Void
		do
			if not path.is_empty then
				Result := path.item (path.count) = path.operating_environment.directory_separator
			end
		ensure
			Result_set: Result implies (not path.is_empty and then (path.item (path.count) = path.operating_environment.directory_separator))
		end

	path_start_with_dir_separator (path: STRING): BOOLEAN is
			-- Does `path' start with dir separator of current running system?
		require
			path_not_void: path /= Void
		do
			if not path.is_empty then
				Result := path.item (1) = path.operating_environment.directory_separator
			end
		ensure
			Result_set: Result implies (not path.is_empty and then (path.item (1) = path.operating_environment.directory_separator))
		end

	selected_file_path: STRING
			-- Final path of selected file

	message_label: EV_LABEL;
			-- Status message label

	file_location (a_bench: BOOLEAN): STRING is
			-- Workbench location of Current project if `a_bench' is True,
			-- otherwise finalized location.
			-- Void if no project has been initialized.
		do
			if workbench.system_defined then
				if a_bench then
					Result := project_location.workbench_path
				else
					Result := project_location.final_path
				end
			end
		end

	c_file_dialog: EB_C_FUNCTION_LIST_DIALOG is
			-- Dialog to choose among different class versions
		do
			if c_file_dialog_internal = Void then
				create c_file_dialog_internal
			end
			Result := c_file_dialog_internal
			Result.set_open_file_agent (agent open_c_file_in_editor)
		ensure
			result_attached: Result /= Void
		end

	c_file_dialog_internal: like c_file_dialog
			-- Implementation of `c_file_dialog'

	concatenated_tooltip (a_first, a_second: STRING_GENERAL): STRING_GENERAL is
			-- Tooltip which is `a_first' concatenated with `a_second' with a new-line character in between
		require
			a_first_attached: a_first /= Void
			a_second_attached: a_second /= Void
		do
			Result := a_first.twin
			Result.append ("%N")
			Result.append (a_second)
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Recycle

	internal_recycle is
			-- To be called before destroying this objects
		do
			c_compilation_output_manager.prune (Current)
			Precursor {ES_OUTPUT_TOOL_PANEL}
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

end -- class EB_C_COMPILATION_OUTPUT_TOOL
