indexing
	description: "Window describing an Eiffel class."
	date: "$Date$"
	revision: "$Revision$"

class DYNAMIC_LIB_W 

inherit

	BAR_AND_TEXT
		rename
			edit_bar as dynamic_lib_toolbar,
			Dynamic_lib_resources as resources
		redefine
			make, create_toolbar, build_toolbar_menu, 
			build_format_bar, hole,
			tool_name, open_cmd_holder, save_cmd_holder,
			editable, reset, build_widgets,
			close_windows, resize_action, stone, stone_type,
			synchronize, process_class_syntax,
			process_feature, process_class, process_classi,
			compatible, set_mode_for_editing, editable_text_window,
			set_editable_text_window, has_editable_text, read_only_text_window,
			set_read_only_text_window, process_feature_error,
			able_to_edit,
			help_index, icon_id,
			close, set_title, parse_file,
			set_default_format,
			display, hide,
			update_save_symbol
		end

	SHARED_COMPILATION_MODES
	SHARED_EIFFEL_PROJECT
	COMPILER_EXPORTER

creation
	make

feature -- Initialization

	make (a_screen: SCREEN) is
		do
			resources.add_user (Current)
			{BAR_AND_TEXT} Precursor (a_screen)
 			!! stone
			set_default_size
			set_default_format
			set_default_position
			eb_shell.display
			dynamic_lib_exports := Eiffel_dynamic_lib.dynamic_lib_exports
			init_text_window
		end

feature -- Representation

	dynamic_lib_exports: HASH_TABLE [LINKED_LIST[DYNAMIC_LIB_EXPORT_FEATURE],INTEGER]

feature -- Properties

	stone: DYNAMIC_LIB_STONE

	stone_type: INTEGER is
			-- Accept any type stone
		do
			Result := Dynamic_lib_type
		end

	in_use: BOOLEAN
			-- Is the system tool used (not hidden)?

	is_clickable: BOOLEAN

	set_clickable (val:BOOLEAN) is
		do
			is_clickable := val
		end

	editable_text_window: TEXT_WINDOW
			-- Text window that can be edited

	read_only_text_window: TEXT_WINDOW
			-- Text window that only reads text

	help_index: INTEGER is 8

	icon_id: INTEGER is
			-- Icon id of Current window (only for windows)
		do
			Result := Interface_names.i_Dynamic_lib_id
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
			--Result := last_format = showtext_frmt_holder
			Result := False
		end

	compatible (a_stone: STONE): BOOLEAN is
			-- Is Current hole compatible with `a_stone'?
		do
			Result :=
				a_stone.stone_type = Routine_type or else
				a_stone.stone_type = Breakable_type 
				--or else
				--a_stone.stone_type = Class_type
		end


feature -- Status setting

	set_in_use (b: BOOLEAN) is
			-- Assign `b' to `in_use'.
		do
			in_use := b
		end

	set_title (s: STRING) is
			-- Set `title' to `s'.
		do
			if is_a_shell then
				eb_shell.set_title (s)
			end
		end

	set_mode_for_reading_only is
			-- Set the text mode to be read only.
		do
			text_window.set_read_only
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

feature -- Update

	update_save_symbol is
			-- Update the save symbol in tool.
		do
			if save_cmd_holder /= Void then
				if Eiffel_dynamic_lib.modified then
					save_cmd_holder.change_state (False)
				else
					save_cmd_holder.change_state (True)
				end
			end
		end
	
feature -- Stone process

	process (d_class:CLASS_C; d_creation:E_FEATURE; 
			 d_routine:E_FEATURE; d_index:INTEGER; d_alias, d_call_type: STRING) is
		do
			if d_routine.is_attribute then
				warner (eb_shell).gotcha_call ("An attribute can not be exported.")
			elseif d_routine.is_deferred then
				warner (eb_shell).gotcha_call ("A deferred feature can not be exported.%N")
			else
				Eiffel_dynamic_lib.add_export_feature (d_class, d_creation, d_routine, d_index, d_alias, d_call_type)
			end
			synchronize
		end
 
	process_classi (s: CLASSI_STONE) is
		local
			class_i: CLASS_I
		do
			class_i := s.class_i
			editable_text_window.put_string (class_i.name)
			editable_text_window.put_string ("%N")
		end
 
	process_class (s: CLASSC_STONE) is
		local
			e_class: CLASS_C
		do
			e_class := s.e_class
			editable_text_window.put_string (e_class.name)
			editable_text_window.put_string ("%N")
		end

	process_feature (s: FEATURE_STONE) is
			-- Proces feature stone.
		local
			f: EXPORTED_FEATURE_NAME_STONE
		do
			f ?= s
			if f = Void then
				process (s.e_class, Void, s.e_feature, 0, Void, Void)
			else
				process (s.e_class, Void, s.e_feature, 0, f.alias_name, Void)
			end
		end

	process_feature_error (s: FEATURE_ERROR_STONE) is
			-- Process feature stone.
		do
		end
 
	process_class_syntax (s: CL_SYNTAX_STONE) is
			-- Process class syntax.
		do
		end
 
	synchronize is
		do
			display_clickable_dynamic_lib_exports(False)
			update_save_symbol
		end

	show_file_content (a_file_name: STRING) is
			-- Display content of file named `a_file_name'
			-- do not change title, nor file_name
		local
			a_file: PLAIN_TEXT_FILE
		do
			create a_file.make (a_file_name)
			if a_file.exists and then a_file.is_readable and then a_file.is_plain then
				a_file.open_read
				if a_file.count > 0 then
					a_file.readstream (a_file.count)
					if not Eiffel_dynamic_lib.parse_exports_from_file(a_file) then 
						warner (eb_shell).gotcha_call ("Error in the Eiffel def file `" +
													a_file_name + "'%N")
					end
				end
				a_file.close
			else
				warner (eb_shell).gotcha_call ("Error in the Eiffel def file `" +
												a_file_name + "'%N")
			end

			display_clickable_dynamic_lib_exports (False)
			set_file_name (a_file_name)
			set_mode_for_reading_only 

			update_save_symbol
			--reset_stone
		ensure
			up_to_date: not text_window.changed
			--no_stone: stone = Void
		end

	display_clickable_dynamic_lib_exports (is_click:BOOLEAN) is
		local
			dl_exp:DYNAMIC_LIB_EXPORT_FEATURE
			class_name: STRING
			st:STRUCTURED_TEXT
		do

			!! st.make
			st.add_string ("%N-- EXPORTED FEATURE(s) OF THE SHARED LIBRARY %N-- SYSTEM : " )

			st.add_string( eiffel_system.name )
			st.add_string( "%N" )

			from
				dynamic_lib_exports.start
			until
				dynamic_lib_exports.after
			loop
				st.add_string( "%N-- CLASS [" )

				dynamic_lib_exports.item_for_iteration.start
				class_name := clone(dynamic_lib_exports.item_for_iteration.item.compiled_class.name)

				class_name.to_upper
				st.add_string(class_name)

				st.add_string( "]%N" )
				from 
				until
					dynamic_lib_exports.item_for_iteration.after
				loop
					if (dynamic_lib_exports.item_for_iteration /= Void) 
						and then (dynamic_lib_exports.item_for_iteration.item /=Void)
					then

						dl_exp := dynamic_lib_exports.item_for_iteration.item

						class_name := clone(dl_exp.compiled_class.name)
						class_name.to_upper
						if is_clickable then
							st.add_classi (dl_exp.compiled_class.lace_class, class_name)
						else
							st.add_string (class_name)
						end

						if (dl_exp.creation_routine /=Void) and then (dl_exp.routine.feature_id /= dl_exp.creation_routine.feature_id) then
							st.add_string (" (")
							if is_clickable then
-- 								st.add_feature_name (dl_exp.creation_routine, dl_exp.creation_routine.name)
								st.add_feature_name (dl_exp.creation_routine.name,dl_exp.compiled_class)
							else
								st.add_string (dl_exp.creation_routine.name)
							end
							st.add_string (")")
						elseif (dl_exp.creation_routine =Void) then
							st.add_string (" (!!)")
						end
						if (dl_exp.routine /= Void) then
							st.add_string (" : ")
							if is_clickable then
-- 								st.add_exported_feature_name (dl_exp.routine, dl_exp.routine.name, dl_exp.alias_name)
								st.add_exported_feature_name (dl_exp.routine.name, dl_exp.compiled_class, dl_exp.alias_name)
							else
								st.add_string (dl_exp.routine.name)
							end
						end
						if (dl_exp.index /= 0) then
							st.add_string (" @ ")
							st.add_int (dl_exp.index)
						end

						if dl_exp.alias_name /= Void then
							st.add_string (" alias ")
							st.add_string (dl_exp.alias_name)
						end

						if dl_exp.call_type /= Void then
							st.add_string (" call_type ")
							st.add_string (dl_exp.call_type)
						end
						st.add_string ("%N")

						dynamic_lib_exports.item_for_iteration.forth
					end
				end
				dynamic_lib_exports.forth
			end

			text_window.hide
   			text_window.clear_window
			text_window.process_text (st)
			text_window.set_top_character_position (0)
 			text_window.show
			text_window.display
			text_window.set_changed(False)
		end

	set_default_format is
			-- Default format of windows.
		local
		do
			if stone /= Void then
				set_last_format (default_format)
			else
				set_last_format (default_format)
			end
		end

feature -- Update
	
	reset is
			-- Reset the window contents
		do
			{BAR_AND_TEXT} Precursor
			reset_format_buttons
		end

	reset_format_buttons is
			-- Reset the format buttons to the original state.
		do
			showtext_frmt_holder.set_sensitive (True)
			showclick_frmt_holder.set_sensitive (True)
		end

	parse_file: BOOLEAN is
			-- Parse the file if possible.
			-- (By default, do nothing).
		do
			Eiffel_dynamic_lib.set_modified(False)
			Result := True
		end

feature -- Window Settings

	close is
			-- Close Current
		do
			hide
			reset
		end

	close_windows is
			-- Close sub-windows.
		do
			{BAR_AND_TEXT} Precursor
		end


feature -- Formats

	showflat_frmt_holder: FORMAT_HOLDER

	showclick_frmt_holder: FORMAT_HOLDER


feature -- Graphical Interface

	display is
			-- Display the dynamic lib tool
		do
--			{BAR_AND_TEXT} Precursor
			if not shown then
				set_default_format
				set_default_position
				init_text_window
				show
			end
			raise
			set_in_use (True)
		end

	hide is
		do
			--stone := Void
			if realized then
				eb_shell.hide
				set_in_use (False)
			end
		end

	build_widgets is
		do
			create_toolbar (global_form)

			build_text_windows (global_form)
			build_menus
			build_format_bar
			fill_menus
			build_toolbar_menu
			set_last_format (default_format)

			if resources.command_bar.actual_value = False then
				dynamic_lib_toolbar.remove
			end

			attach_all
		end

	build_toolbar_menu is
			-- Build the toolbar menu under the special sub menu.
		local
			sep: SEPARATOR
			toolbar_t: TOGGLE_B
		do
			!! sep.make (Interface_names.t_Empty, special_menu)
			!! toolbar_t.make (dynamic_lib_toolbar.identifier, special_menu)
			dynamic_lib_toolbar.init_toggle (toolbar_t)
		end

	create_toolbar (a_parent: COMPOSITE) is
			-- Create a toolbar_parent with parent `a_parent'.
		local
			sep: THREE_D_SEPARATOR
		do
			!! toolbar_parent.make (new_name, a_parent)
			!! sep.make (Interface_names.t_Empty, toolbar_parent)
			toolbar_parent.set_column_layout
			toolbar_parent.set_free_size	
			toolbar_parent.set_margin_height (0)
			toolbar_parent.set_spacing (1)
			!! dynamic_lib_toolbar.make (Interface_names.n_Tool_bar_name, toolbar_parent)
			if not Platform_constants.is_windows then
				!! sep.make (Interface_names.t_Empty, toolbar_parent)
			else
				dynamic_lib_toolbar.set_height (22)
			end
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
			Result := "Dynamic Lib tool"
		end

	hole: DYNAMIC_LIB_HOLE
			-- Hole caraterizing current
 
	format_label: LABEL

feature {NONE} -- Implemetation Window Settings

	set_format_label (s: STRING) is
			-- Set the format label to `s'.
		require
			valid_arg: (s /= Void) and then not s.is_empty
		do
			format_label.set_text (s)
		end

	resize_action is 
			-- If the window is moved or resized, raise
			-- popups with an exclusive grab.
			-- Move also the choice window and update the text field.
		do
			raise_grabbed_popup
		end


feature {NONE, QUIT_DYNAMIC_LIB, OPEN_DYNAMIC_LIB} -- Commands

	open_cmd_holder: COMMAND_HOLDER

	save_cmd_holder: TWO_STATE_CMD_HOLDER

	shell: COMMAND_HOLDER

feature {NONE} -- Implementation Graphical Interface

	create_edit_buttons is
		local
			quit_cmd: QUIT_DYNAMIC_LIB
			quit_button: EB_BUTTON
			quit_menu_entry: EB_MENU_ENTRY
			exit_menu_entry: EB_MENU_ENTRY
			open_cmd: OPEN_DYNAMIC_LIB
			open_button: EB_BUTTON
			open_menu_entry: EB_MENU_ENTRY
			save_cmd: SAVE_FILE
			save_button: EB_BUTTON
			save_menu_entry: EB_MENU_ENTRY
		do
			!! open_cmd.make (Current)
			!! open_button.make (open_cmd, dynamic_lib_toolbar)
			!! open_menu_entry.make (open_cmd, file_menu)
			!! open_cmd_holder.make (open_cmd, open_button, open_menu_entry)
			!! save_cmd.make (Current)
			!! save_button.make (save_cmd, dynamic_lib_toolbar)
			!! save_menu_entry.make (save_cmd, file_menu)
			!! save_cmd_holder.make (save_cmd, save_button, save_menu_entry)
			build_save_as_menu_entry
			build_print_menu_entry
			!! quit_cmd.make (Current)
			!! quit_menu_entry.make (quit_cmd, file_menu)
			if General_resources.close_button.actual_value then
				!! quit_button.make (quit_cmd, dynamic_lib_toolbar)
			end
			!! quit_cmd_holder.make (quit_cmd, quit_button, quit_menu_entry)
			!! exit_menu_entry.make (Project_tool.quit_cmd_holder.associated_command, file_menu)
			!! exit_cmd_holder.make_plain (Project_tool.quit_cmd_holder.associated_command)
			exit_cmd_holder.set_menu_entry (exit_menu_entry)
			build_edit_menu (dynamic_lib_toolbar)
		end

	build_format_bar is
			-- Build formatting buttons in `dynamic_lib_toolbar'.
		local
			shell_cmd: SHELL_COMMAND
			shell_button: EB_BUTTON_HOLE
			shell_menu_entry: EB_MENU_ENTRY
			tex_cmd: SHOW_TEXT_DYNAMIC_LIB
			tex_button: FORMAT_BUTTON
			tex_menu_entry: EB_TICKABLE_MENU_ENTRY
			click_cmd: SHOW_CLICK_DYNAMIC_LIB
			click_button: FORMAT_BUTTON
			click_menu_entry: EB_TICKABLE_MENU_ENTRY
			sep: SEPARATOR
			sep1, sep2, sep3: THREE_D_SEPARATOR
		do
			!! shell_cmd.make (Current)
			!! shell_button.make (shell_cmd, dynamic_lib_toolbar)
			shell_button.add_third_button_action
			!! shell_menu_entry.make (shell_cmd, special_menu)
			!! shell.make (shell_cmd, shell_button, shell_menu_entry)

			build_filter_menu_entry

			!! sep.make (new_name, special_menu)

				-- First we create all objects.
			!! tex_cmd.make (Current)
			!! tex_button.make (tex_cmd, dynamic_lib_toolbar)
			!! tex_menu_entry.make (tex_cmd, format_menu)
			!! showtext_frmt_holder.make (tex_cmd, tex_button, tex_menu_entry)

			!! click_cmd.make (Current)
			!! click_button.make (click_cmd, dynamic_lib_toolbar)
			!! click_menu_entry.make (click_cmd, format_menu)
			!! showclick_frmt_holder.make (click_cmd, click_button, click_menu_entry)

			!! hole.make (Current)
			!! hole_button.make (hole, dynamic_lib_toolbar)
			!! hole_holder.make_plain (hole)
			hole_holder.set_button (hole_button)

			create_edit_buttons

			!! sep1.make (interface_names.t_empty, dynamic_lib_toolbar)
			sep1.set_height (20)
			sep1.set_horizontal (False)

			!! sep2.make (interface_names.t_empty, dynamic_lib_toolbar)
			sep2.set_height (20)
			sep2.set_horizontal (False)

			!! sep3.make (interface_names.t_empty, dynamic_lib_toolbar)
			sep3.set_height (20)
			sep3.set_horizontal (False)

			dynamic_lib_toolbar.attach_top (open_cmd_holder.associated_button, 0)
			dynamic_lib_toolbar.attach_left (open_cmd_holder.associated_button, 5)
			dynamic_lib_toolbar.attach_top (save_cmd_holder.associated_button, 0)
			dynamic_lib_toolbar.attach_left_widget (open_cmd_holder.associated_button, save_cmd_holder.associated_button, 0)

			dynamic_lib_toolbar.attach_top (sep1, 0)
			dynamic_lib_toolbar.attach_left_widget (save_cmd_holder.associated_button, sep1, 5)

			dynamic_lib_toolbar.attach_top (search_cmd_holder.associated_button, 0)
			dynamic_lib_toolbar.attach_left_widget (sep1, search_cmd_holder.associated_button, 0)
			
			dynamic_lib_toolbar.attach_top (sep2, 0)
			dynamic_lib_toolbar.attach_left_widget (search_cmd_holder.associated_button, sep2, 5)

			dynamic_lib_toolbar.attach_top (shell_button, 0)
			dynamic_lib_toolbar.attach_left_widget (sep2, shell_button, 0)

			dynamic_lib_toolbar.attach_top (hole_button, 0)
			dynamic_lib_toolbar.attach_left_widget (shell_button, hole_button, 5)

			dynamic_lib_toolbar.attach_top (sep3, 0)
			dynamic_lib_toolbar.attach_left_widget (hole_button, sep3, 5)
			
			dynamic_lib_toolbar.attach_top (tex_button,0)
			dynamic_lib_toolbar.attach_left_widget (sep3, tex_button, 5)

			dynamic_lib_toolbar.attach_top (click_button,0)
			dynamic_lib_toolbar.attach_left_widget (tex_button,click_button,0)

			if quit_cmd_holder.associated_button /= Void then
				dynamic_lib_toolbar.attach_top (quit_cmd_holder.associated_button, 0)
				dynamic_lib_toolbar.attach_right (quit_cmd_holder.associated_button, 5)
			end
		end

end -- class DYNAMIC_LIB_W

