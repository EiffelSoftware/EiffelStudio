indexing
	description: "Window describing an Eiffel class."
	date: "$Date$"
	revision: "$Revision$"

class CLASS_W 

inherit
	BAR_AND_TEXT
		rename
			Class_resources as resources,
			class_type as stone_type
		redefine
			build_format_bar, hole,
			tool_name, open_cmd_holder, save_cmd_holder,
			editable, build_bar, reset, build_widgets,
			close_windows, resize_action,
			synchronize, set_stone, process_class_syntax,
			process_feature, process_class, process_classi,
			compatible, set_mode_for_editing, editable_text_window,
			set_editable_text_window, has_editable_text, read_only_text_window,
			set_read_only_text_window, process_feature_error,
			able_to_edit,
			help_index, icon_id,
			close, set_title, parse_file, history_window_title,
			set_default_format
		end

	SHARED_COMPILATION_MODES


creation
	make, form_create

feature -- Initialization

	form_create (a_form: FORM file_m, edit_m, format_m, special_m: MENU_PULL) is
			-- Create a feature tool from a form.
		require
			valid_args: a_form /= Void and then edit_m /= Void and then	
				format_m /= Void and then special_m /= Void
		do
--			is_in_project_tool := True
--			file_menu := file_m
--			edit_menu := edit_m
--			format_menu := format_m
--			special_menu := special_m
			make_form (a_form)
			init_text_window
			set_composite_attributes (a_form)
--			set_composite_attributes (file_m)
--			set_composite_attributes (edit_m)
--			set_composite_attributes (format_m)
--			set_composite_attributes (special_m)
		end

feature -- Properties

	editable_text_window: TEXT_WINDOW
			-- Text window that can be edited

	read_only_text_window: TEXT_WINDOW
			-- Text window that only reads text

	version_cmd: CLASS_VERSIONS

	help_index: INTEGER is 6

	icon_id: INTEGER is
			-- Icon id of Current window (only for windows)
		do
			Result := Interface_names.i_Class_id
		end

feature -- Access

	has_editable_text: BOOLEAN is
			-- Does Current tool have an editable text window?
		do
			Result := True
		end

	able_to_edit: BOOLEAN is
			-- Are we able to edit the text?
		do
			Result := last_format = showtext_frmt_holder
		end

	compatible (a_stone: STONE): BOOLEAN is
			-- Is Current hole compatible with `a_stone'?
		do
			Result :=
				a_stone.stone_type = Routine_type or else
				a_stone.stone_type = Breakable_type or else
				a_stone.stone_type = stone_type
		end

	cluster: CLUSTER_I is
			-- Cluster associated with root_stone
		local
			c: CLASSC_STONE
			ci: CLASSI_STONE
		do
			c ?= stone
			ci ?= stone
			if c /= Void then
				Result := c.e_class.cluster
			elseif ci /= Void then
				Result := ci.class_i.cluster
			end
		end

	history_window_title: STRING is
			-- Title of the history window
		do
			Result := Interface_names.t_Select_class
		end

feature -- Status setting

	set_title (s: STRING) is
			-- Set `title' to `s'.
		do
			if is_a_shell then
				eb_shell.set_title (s)
				Project_tool.change_class_entry (Current)
			end
		end
 
	set_stone (s: like stone) is
		local
			c: CLASSC_STONE
			ci: CLASSI_STONE
		do
			{BAR_AND_TEXT} precursor (s)
			c ?= stone
			ci ?= stone
			if c /= Void then
				update_class_name (clone (c.e_class.name))
			elseif ci /= Void then
				update_class_name (clone (ci.class_i.name))
			end
		end

	set_mode_for_editing is
			-- Set the text mode to be editable.
		do
			text_window.set_editable
		end

	set_editable_text_window (ed: like editable_text_window) is
			-- Set `editable_text_window' to `ed'.
		do
			editable_text_window := ed
		end

	set_read_only_text_window (ed: like read_only_text_window) is
			-- Set `read_only_text_window' to `ed'.
		do
			read_only_text_window := ed
		end

	execute_last_format (s: STONE) is
			-- Execute the last format with stone `s'.
			-- If `last_format' is not allowed for `s' (when
			-- class is a precompile and is hidden) default
			-- `last_format' to a valid format.
		require
			valid_s: s /= Void and then s.is_valid
		local
			c: CLASSC_STONE
			ci: CLASSI_STONE
			class_i: CLASS_I
		do
			c ?= s
			ci ?= s
			if c /= Void then
				class_i := c.e_class.lace_class	
			else
				class_i := ci.class_i	
			end
			if class_i.hide_implementation then
				showtext_frmt_holder.set_sensitive (False)
				showflat_frmt_holder.set_sensitive (False)
				showclick_frmt_holder.set_sensitive (False)
				if 
					last_format = showtext_frmt_holder or else
					last_format = showflat_frmt_holder or else
					last_format = showclick_frmt_holder 
				then
					last_format.set_selected (False)
					last_format := showshort_frmt_holder
				end
			else
				reset_format_buttons
			end
			last_format.execute (s)
			add_to_history (s)
		end
 
feature -- Stone process
 
	process_classi (s: CLASSI_STONE) is
		do
			execute_last_format (s)
		end
 
	process_class (s: CLASSC_STONE) is
		do
			execute_last_format (s)
		end
 
	process_feature_error (s: FEATURE_ERROR_STONE) is
			-- Proces feature stone.
		local
			cl_stone: CLASSC_STONE
			e_class: E_CLASS
			txt: STRING
			pos, end_pos: INTEGER
		do
			e_class := s.e_feature.written_class
			!! cl_stone.make (e_class)

			if e_class.lace_class.hide_implementation then
				set_default_format
				process_class (cl_stone)
				text_window.search_stone (s)
			else
				showtext_frmt_holder.execute (cl_stone)
				add_to_history (stone)
				text_window.deselect_all
				pos := s.error_position
				txt := text_window.text
				if txt.count > pos then
					if txt.item (pos) = '%N' then	
						end_pos := txt.index_of ('%N', pos + 1)
					else
						end_pos := txt.index_of ('%N', pos)
					end
					if pos /= 0 then
						text_window.highlight_selected (pos, end_pos)
					end
				end
				text_window.set_cursor_position (pos)
			end
		end
 
	process_feature (s: FEATURE_STONE) is
			-- Proces feature stone.
		local
			cl_stone: CLASSC_STONE
			e_class: E_CLASS
		do
			e_class := s.e_feature.written_class
			!! cl_stone.make (e_class)

			if e_class.lace_class.hide_implementation then
				set_default_format
				process_class (cl_stone)
				text_window.search_stone (s)
			else
				showtext_frmt_holder.execute (cl_stone)
				add_to_history (stone)
				text_window.deselect_all
				text_window.set_cursor_position (s.start_position)
				text_window.highlight_selected (s.start_position, s.end_position)
			end
		end
 
	process_class_syntax (s: CL_SYNTAX_STONE) is
			-- Process class syntax.
		local
			cl_stone: CLASSC_STONE
		do
			!! cl_stone.make (s.associated_class)
			showtext_frmt_holder.execute (cl_stone)
			text_window.deselect_all
			text_window.set_cursor_position (s.start_position)
			text_window.highlight_selected (s.start_position, s.end_position)
		end
 
	synchronize is
			-- Synchronize clickable elements with text, if possible.
		do
			synchronise_stone
			if stone = Void then
				class_text_field.clear
			end
		end

	set_default_format is
			-- Default format of windows.
		local
			c: CLASSC_STONE
			ci: CLASSI_STONE
			class_i: CLASS_I
		do
			if stone /= Void then
				c ?= stone
				ci ?= stone
				if c /= Void then
					class_i := c.e_class.lace_class	
				else
					class_i := ci.class_i	
				end
				if class_i.hide_implementation then
					set_last_format (showshort_frmt_holder)
				else
					set_last_format (default_format)
				end
			else
				set_last_format (default_format)
			end
		end

feature -- Update

	reset is
			-- Reset the window contents
		do
			{BAR_AND_TEXT} precursor
			reset_format_buttons
			class_text_field.clear
		end

	reset_format_buttons is
			-- Reset the format buttons to the original state.
		do
			showtext_frmt_holder.set_sensitive (True)
			showflat_frmt_holder.set_sensitive (True)
			showclick_frmt_holder.set_sensitive (True)
		end

	update_class_name (s: STRING) is
		require
			valid_arg: s /= Void
		do
			s.to_upper
			class_text_field.set_text (s)
		end

	update_clickable_format (e_class: E_CLASS) is
		local
			new_title: STRING
		do
			if not has_class_name_changed (e_class) then
					-- Update the clickable position of the tool.
				text_window.update_clickable_from_stone (stone)
			else
					-- Changed the title of the corresponding tool.
				new_title := clone (new_class_name (e_class))
				new_title.to_upper
				new_title.prepend ("New class: ")
				new_title.append (" (Not in System)")
				set_title (new_title)
				Compilation_modes.set_need_melt
			end
		end

	parse_file: BOOLEAN is
			-- Parse the file if possible.
			-- (By default, do nothing).
		local
			syn_error: SYNTAX_ERROR
			classc_stone: CLASSC_STONE
			syn_stone: CL_SYNTAX_STONE
			e_class: E_CLASS
			txt, msg: STRING
			error_message: STRING
			error_code: INTEGER
		do
			classc_stone ?= stone
			if classc_stone /= Void then
				e_class := classc_stone.e_class
				if not e_class.is_precompiled then
						-- Only interested in compiled classes.
					e_class.parse_ast
					syn_error := e_class.last_syntax_error


					if syn_error /= Void then	
						txt := "Class has syntax error"
						msg := syn_error.syntax_message
						error_message := syn_error.error_message
						error_code := syn_error.error_code
						if not msg.empty then
							txt.append (" (")
							txt.append (msg)
							txt.extend (')')
						end
						if error_code /= Void then
							txt.append ("%N<")
							txt.append_integer (error_code)
							txt.append ("> ")
							txt.append (error_message)
						end
						txt.append (".%NSee highlighted area.")

							-- syntax error occurred
						!! syn_stone.make (syn_error, e_class)
						process_class_syntax (syn_stone)
						e_class.clear_syntax_error
						warner (popup_parent).gotcha_call (txt)
					else
						update_clickable_format (e_class)
						Result := not has_class_name_changed (e_class)
					end
				end
			end
		end

feature -- Window Settings

	close is
			-- Close Current
		do
			Project_tool.remove_class_entry (Current)
			hide
			reset
		end

	close_windows is
			-- Close sub-windows.
		do
			{BAR_AND_TEXT} precursor
			class_text_field.close_choice_window
			version_cmd.close_choice_window
		end

feature -- Widgets

	class_text_field: CLASS_TEXT_FIELD

feature -- Formats

	showflat_frmt_holder: FORMAT_HOLDER

	showflatshort_frmt_holder: FORMAT_HOLDER

	showancestors_frmt_holder: FORMAT_HOLDER

	showdescendants_frmt_holder: FORMAT_HOLDER

	showclients_frmt_holder: FORMAT_HOLDER

	showsuppliers_frmt_holder: FORMAT_HOLDER

	showattributes_frmt_holder: FORMAT_HOLDER

	showroutines_frmt_holder: FORMAT_HOLDER

	showshort_frmt_holder: FORMAT_HOLDER

	showclick_frmt_holder: FORMAT_HOLDER

	showdeferreds_frmt_holder: FORMAT_HOLDER

	showexternals_frmt_holder: FORMAT_HOLDER

	showonces_frmt_holder: FORMAT_HOLDER

	showexported_frmt_holder: FORMAT_HOLDER

feature -- Grahpical Interface

	build_widgets is
		do
			create_toolbar (global_form)

			build_text_windows (global_form)
			build_menus
			build_bar
			build_format_bar
			build_command_bar
			fill_menus
			build_toolbar_menu
			set_last_format (default_format)

			if resources.command_bar.actual_value = False then
				edit_bar.remove
			end
			if resources.format_bar.actual_value = False then
				format_bar.remove
			end

			attach_all
		end

	raise_shell_popup is
			-- Raise the shell command popup window if it is popped up.
		local
			shell_window: SHELL_W
			shell_cmd: SHELL_COMMAND
		do
			shell_cmd ?= shell.associated_command
			shell_window := shell_cmd.shell_window
			if shell_window /= Void and then shell_window.is_popped_up then
				shell_window.raise
			end
		end
			
feature {NONE} -- Properties Window Properties

	editable: BOOLEAN is True
			-- Is Current editable?

	tool_name: STRING is
			-- The name of this tool.
		do
			Result := Interface_names.t_Empty_class
		end

	hole: CLASS_HOLE
			-- Hole caraterizing current
 
	format_label: LABEL

	class_name_tf: TEXT_FIELD

feature {NONE} -- Implemetation Window Settings

	set_format_label (s: STRING) is
			-- Set the format label to `s'.
		require
			valid_arg: (s /= Void) and then not s.empty
		do
			format_label.set_text (s)
		end

	resize_action is 
			-- If the window is moved or resized, raise
			-- popups with an exclusive grab.
			-- Move also the choice window and update the text field.
		do
			raise_grabbed_popup
			class_text_field.update_text
			class_text_field.update_choice_position
		end

feature {SHOW_HTML_TEXT} -- Parsing checking

	has_class_name_changed (e_class: E_CLASS): BOOLEAN is
			-- Has the name of the class been changed during its editing?
		do
			Result := not e_class.lace_class.name.is_equal (new_class_name (e_class))
		end
	
	new_class_name (e_class: E_CLASS): STRING is
		local
			class_as_b: CLASS_AS_B
		do
			class_as_b ?= e_class.click_list.area.item (0).node
			if class_as_b /= Void then
					--| Should not be void.
				Result := clone (class_as_b.class_name)
			end
		end

feature -- Exported Commands

	save_cmd_holder: TWO_STATE_CMD_HOLDER

feature {NONE} -- Commands

	open_cmd_holder: COMMAND_HOLDER

	shell: COMMAND_HOLDER

	current_target_cmd_holder: COMMAND_HOLDER

	previous_target_cmd_holder: COMMAND_HOLDER

	next_target_cmd_holder: COMMAND_HOLDER

feature {NONE} -- Implementation Graphical Interface

	create_edit_buttons is
		local
			quit_cmd: QUIT_FILE
			quit_button: EB_BUTTON
			quit_menu_entry: EB_MENU_ENTRY
			exit_menu_entry: EB_MENU_ENTRY
			open_cmd: OPEN_FILE
			open_button: EB_BUTTON
			open_menu_entry: EB_MENU_ENTRY
			save_cmd: SAVE_FILE
			save_button: EB_BUTTON
			save_menu_entry: EB_MENU_ENTRY
			sep: SEPARATOR
			history_list_cmd: LIST_HISTORY
		do
			!! class_text_field.make (edit_bar, Current)
			!! open_cmd.make (Current)
			!! open_button.make (open_cmd, edit_bar)
			!! open_menu_entry.make (open_cmd, file_menu)
			!! open_cmd_holder.make (open_cmd, open_button, open_menu_entry)
			!! save_cmd.make (Current)
			!! save_button.make (save_cmd, edit_bar)
			!! save_menu_entry.make (save_cmd, file_menu)
			!! save_cmd_holder.make (save_cmd, save_button, save_menu_entry)
			build_save_as_menu_entry
			build_print_menu_entry
			!! quit_cmd.make (Current)
			!! quit_button.make (quit_cmd, edit_bar)
			!! quit_menu_entry.make (quit_cmd, file_menu)
			!! quit_cmd_holder.make (quit_cmd, quit_button, quit_menu_entry)
			!! exit_menu_entry.make (Project_tool.quit_cmd_holder.associated_command, file_menu)
			!! exit_cmd_holder.make_plain (Project_tool.quit_cmd_holder.associated_command)
			exit_cmd_holder.set_menu_entry (exit_menu_entry)
			build_edit_menu (edit_bar)
		end

	build_command_bar is
		local
			version_menu_entry: EB_MENU_ENTRY
			shell_cmd: SHELL_COMMAND
			shell_button: EB_BUTTON_HOLE
			shell_menu_entry: EB_MENU_ENTRY
			previous_target_cmd: PREVIOUS_TARGET
			previous_target_button: EB_BUTTON
			previous_target_menu_entry: EB_MENU_ENTRY
			next_target_cmd: NEXT_TARGET
			next_target_button: EB_BUTTON
			next_target_menu_entry: EB_MENU_ENTRY
			current_target_cmd: CURRENT_CLASS
			current_target_button: EB_BUTTON
			current_target_menu_entry: EB_MENU_ENTRY
			super_melt_cmd: SUPER_MELT
			sep: SEPARATOR
			history_list_cmd: LIST_HISTORY
			super_melt_menu_entry: EB_MENU_ENTRY
			new_class_button: EB_BUTTON_HOLE
		do
			!! version_cmd.make (Current)
			!! version_menu_entry.make (version_cmd, special_menu)
			!! shell_cmd.make (Current)
			!! shell_button.make (shell_cmd, edit_bar)
			shell_button.add_third_button_action
			!! shell_menu_entry.make (shell_cmd, special_menu)
			!! shell.make (shell_cmd, shell_button, shell_menu_entry)
			build_filter_menu_entry
			!! super_melt_cmd.make (Current)
			!! super_melt_menu_entry.make (super_melt_cmd, special_menu)

			!! current_target_cmd.make (Current)
			!! sep.make (new_name, special_menu)
			!! current_target_menu_entry.make (current_target_cmd, special_menu)
			!! current_target_cmd_holder.make_plain (current_target_cmd)
			current_target_cmd_holder.set_menu_entry (current_target_menu_entry)
			!! next_target_cmd.make (Current)
			!! next_target_button.make (next_target_cmd, edit_bar)
			!! next_target_menu_entry.make (next_target_cmd, special_menu)
			!! next_target_cmd_holder.make (next_target_cmd, next_target_button, next_target_menu_entry)
			!! previous_target_cmd.make (Current)
			!! previous_target_button.make (previous_target_cmd, edit_bar)
			!! previous_target_menu_entry.make (previous_target_cmd, special_menu)
			!! previous_target_cmd_holder.make (previous_target_cmd, previous_target_button, previous_target_menu_entry)

			!! history_list_cmd.make (Current)
			next_target_button.add_button_press_action (3, history_list_cmd, next_target_button)
			previous_target_button.add_button_press_action (3, history_list_cmd, previous_target_button)

			!! new_class_button.make (Project_tool.class_hole_holder.associated_command,	edit_bar)
			edit_bar.attach_left_widget (hole_button, shell_button, 0)
			edit_bar.attach_left_widget (shell_button, new_class_button, 0)
			edit_bar.attach_top (shell_button, 0)
			edit_bar.attach_top (new_class_button, 0)

			edit_bar.attach_top (next_target_button, 0)
			edit_bar.attach_top (previous_target_button, 0)
			edit_bar.attach_right_widget (class_text_field, next_target_button, 2)
			edit_bar.attach_right_widget (next_target_button, previous_target_button, 0)
		end

	build_format_bar is
			-- Build formatting buttons in `format_bar'.
		local
			anc_cmd: SHOW_ANCESTORS
			anc_button: FORMAT_BUTTON
			anc_menu_entry: EB_TICKABLE_MENU_ENTRY
			des_cmd: SHOW_DESCENDANTS
			des_button: FORMAT_BUTTON
			des_menu_entry: EB_TICKABLE_MENU_ENTRY
			cli_cmd: SHOW_CLIENTS
			cli_button: FORMAT_BUTTON
			cli_menu_entry: EB_TICKABLE_MENU_ENTRY
			sup_cmd: SHOW_SUPPLIERS
			sup_button: FORMAT_BUTTON
			sup_menu_entry: EB_TICKABLE_MENU_ENTRY
			att_cmd: SHOW_ATTRIBUTES
			att_button: FORMAT_BUTTON
			att_menu_entry: EB_TICKABLE_MENU_ENTRY
			rou_cmd: SHOW_ROUTINES
			rou_button: FORMAT_BUTTON
			rou_menu_entry: EB_TICKABLE_MENU_ENTRY
			def_cmd: SHOW_DEFERREDS
			def_button: FORMAT_BUTTON
			def_menu_entry: EB_TICKABLE_MENU_ENTRY
			ext_cmd: SHOW_EXTERNALS
			ext_button: FORMAT_BUTTON
			ext_menu_entry: EB_TICKABLE_MENU_ENTRY
			onc_cmd: SHOW_ONCES
			onc_button: FORMAT_BUTTON
			onc_menu_entry: EB_TICKABLE_MENU_ENTRY
			exp_cmd: SHOW_EXPORTED
			exp_button: FORMAT_BUTTON
			exp_menu_entry: EB_TICKABLE_MENU_ENTRY
			tex_cmd: SHOW_HTML_TEXT
			tex_button: FORMAT_BUTTON
			tex_menu_entry: EB_TICKABLE_MENU_ENTRY
			fla_cmd: SHOW_FLAT
			fla_button: FORMAT_BUTTON
			fla_menu_entry: EB_TICKABLE_MENU_ENTRY
			fs_cmd: SHOW_FS
			fs_button: FORMAT_BUTTON
			fs_menu_entry: EB_TICKABLE_MENU_ENTRY
			sho_cmd: SHOW_SHORT
			sho_button: FORMAT_BUTTON
			sho_menu_entry: EB_TICKABLE_MENU_ENTRY
			click_cmd: SHOW_CLICK_CL
			click_button: FORMAT_BUTTON
			click_menu_entry: EB_TICKABLE_MENU_ENTRY
			sep: SEPARATOR
		do
				-- First we create all objects.
			!! tex_cmd.make (Current)
			!! tex_button.make (tex_cmd, format_bar)
			!! tex_menu_entry.make (tex_cmd, format_menu)
			!! showtext_frmt_holder.make (tex_cmd, tex_button, tex_menu_entry)
			!! click_cmd.make (Current)
			!! click_button.make (click_cmd, format_bar)
			!! click_menu_entry.make (click_cmd, format_menu)
			!! showclick_frmt_holder.make (click_cmd, click_button, click_menu_entry)
			!! fla_cmd.make (Current)
			!! fla_button.make (fla_cmd, format_bar)
			!! fla_menu_entry.make (fla_cmd, format_menu)
			!! showflat_frmt_holder.make (fla_cmd, fla_button, fla_menu_entry)
			!! sho_cmd.make (Current)
			!! sho_button.make (sho_cmd, format_bar)
			!! sho_menu_entry.make (sho_cmd, format_menu)
			!! showshort_frmt_holder.make (sho_cmd, sho_button, sho_menu_entry)
			!! fs_cmd.make (Current)
			!! fs_button.make (fs_cmd, format_bar)
			!! fs_menu_entry.make (fs_cmd, format_menu)
			!! showflatshort_frmt_holder.make (fs_cmd, fs_button, fs_menu_entry)
			!! sep.make (new_name, format_menu)
			!! anc_cmd.make (Current)
			!! anc_button.make (anc_cmd, format_bar)
			!! anc_menu_entry.make (anc_cmd, format_menu)
			!! showancestors_frmt_holder.make (anc_cmd, anc_button, anc_menu_entry)
			!! des_cmd.make (Current)
			!! des_button.make (des_cmd, format_bar)
			!! des_menu_entry.make (des_cmd, format_menu)
			!! showdescendants_frmt_holder.make (des_cmd, des_button, des_menu_entry)
			!! cli_cmd.make (Current)
			!! cli_button.make (cli_cmd, format_bar)
			!! cli_menu_entry.make (cli_cmd, format_menu)
			!! showclients_frmt_holder.make (cli_cmd, cli_button, cli_menu_entry)
			!! sup_cmd.make (Current)
			!! sup_button.make (sup_cmd, format_bar)
			!! sup_menu_entry.make (sup_cmd, format_menu)
			!! sep.make (new_name, format_menu)
			!! showsuppliers_frmt_holder.make (sup_cmd, sup_button, sup_menu_entry)
			!! att_cmd.make (Current)
			!! att_button.make (att_cmd, format_bar)
			!! att_menu_entry.make (att_cmd, format_menu)
			!! showattributes_frmt_holder.make (att_cmd, att_button, att_menu_entry)
			!! rou_cmd.make (Current)
			!! rou_button.make (rou_cmd, format_bar)
			!! rou_menu_entry.make (rou_cmd, format_menu)
			!! showroutines_frmt_holder.make (rou_cmd, rou_button, rou_menu_entry)
			!! def_cmd.make (Current)
			!! def_button.make (def_cmd, format_bar)
			!! def_menu_entry.make (def_cmd, format_menu)
			!! showdeferreds_frmt_holder.make (def_cmd, def_button, def_menu_entry)
			!! ext_cmd.make (Current)
			!! ext_button.make (ext_cmd, format_bar)
			!! ext_menu_entry.make (ext_cmd, format_menu)
			!! showexternals_frmt_holder.make (ext_cmd, ext_button, ext_menu_entry)
			!! exp_cmd.make (Current)
			!! exp_button.make (exp_cmd, format_bar)
			!! exp_menu_entry.make (exp_cmd, format_menu)
			!! showexported_frmt_holder.make (exp_cmd, exp_button, exp_menu_entry)
			!! onc_cmd.make (Current)
			!! onc_button.make (onc_cmd, format_bar)
			!! onc_menu_entry.make (onc_cmd, format_menu)
			!! showonces_frmt_holder.make (onc_cmd, onc_button, onc_menu_entry)

				-- And now we attach everything (this is done this way
				-- because of speed)
			format_bar.attach_top (tex_button, 0)
			format_bar.attach_left (tex_button, 0)
			format_bar.attach_top (fla_button, 0)
			format_bar.attach_left_widget (tex_button, click_button, 0)
			format_bar.attach_top (fs_button, 0)
			format_bar.attach_left_widget (click_button, fla_button, 0)
			format_bar.attach_top (sho_button, 0)
			format_bar.attach_left_widget (fla_button, sho_button, 0)
			format_bar.attach_top (click_button, 0)
			format_bar.attach_left_widget (sho_button, fs_button, 0)
			format_bar.attach_top (anc_button, 0)
			format_bar.attach_left_widget (fs_button, anc_button, 15)
			format_bar.attach_top (des_button, 0)
			format_bar.attach_left_widget (anc_button, des_button, 0)
			format_bar.attach_top (cli_button, 0)
			format_bar.attach_left_widget (des_button, cli_button, 0)
			format_bar.attach_top (sup_button, 0)
			format_bar.attach_left_widget (cli_button, sup_button, 0)
			format_bar.attach_top (att_button, 0)
			format_bar.attach_right_widget (rou_button, att_button, 0)
			format_bar.attach_top (rou_button, 0)
			format_bar.attach_right_widget (def_button, rou_button, 0)
			format_bar.attach_top (def_button, 0)
			format_bar.attach_right_widget (onc_button, def_button, 0)
			format_bar.attach_top (onc_button, 0)
			format_bar.attach_right_widget (ext_button, onc_button, 0)
			format_bar.attach_top (ext_button, 0)
			format_bar.attach_right_widget (exp_button, ext_button, 0)
			format_bar.attach_top (exp_button, 0)
			format_bar.attach_right (exp_button, 0)
		end

	build_bar is
			-- Build top bar: editing commands
		do
			edit_bar.set_fraction_base (21)
			!! hole.make (Current)
			!! hole_button.make (hole, edit_bar)
			!! hole_holder.make_plain (hole)
			hole_holder.set_button (hole_button)
			create_edit_buttons

			edit_bar.attach_left (hole_button, 0)
			edit_bar.attach_top (hole_button, 0)

			edit_bar.attach_top (class_text_field, 0)
			edit_bar.attach_left_position (class_text_field, 7)
			edit_bar.attach_right_widget (open_cmd_holder.associated_button, class_text_field, 2)
			edit_bar.attach_right (quit_cmd_holder.associated_button, 0)
			edit_bar.attach_top (quit_cmd_holder.associated_button, 0)
			edit_bar.attach_top (search_cmd_holder.associated_button, 0)
			edit_bar.attach_right_widget (quit_cmd_holder.associated_button, search_cmd_holder.associated_button, 5)
			edit_bar.attach_top (save_cmd_holder.associated_button, 0)
			edit_bar.attach_right_widget (search_cmd_holder.associated_button, save_cmd_holder.associated_button, 0)
			edit_bar.attach_top (open_cmd_holder.associated_button, 0)
			edit_bar.attach_right_widget (save_cmd_holder.associated_button, open_cmd_holder.associated_button, 0)
		end

end -- class CLASS_W
