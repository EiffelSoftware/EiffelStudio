indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DYNAMIC_LIB_TOOL

inherit
	EB_MULTIFORMAT_EDIT_TOOL
		rename
			edit_bar as dynamic_lib_toolbar
--			Dynamic_lib_resources as resources
		redefine
			make,
-- create_toolbar, build_toolbar_menu, 
--			build_format_bar, hole,
--			tool_name, open_cmd_holder, save_cmd_holder,
--			editable,
 reset, build_interface,
			close_windows,
-- resize_action,
 stone,
-- stone_type,
			synchronize,
-- process_class_syntax,
--			process_feature, process_class, process_classi,
--			compatible,
 set_mode_for_editing,
			has_editable_text,
--			process_feature_error,
			able_to_edit, format_list,
--			help_index,
 icon_id,
			build_file_menu, close_cmd,
			save_text,
			empty_tool_name,
			close, parse_file,
			set_default_format,
--			display, hide,
			update_save_symbol
		end

	EB_SYSTEM_TOOL_DATA
		rename
			System_resources as resources
		end			

	SHARED_COMPILATION_MODES
	SHARED_EIFFEL_PROJECT
	COMPILER_EXPORTER

creation
	make

feature -- Initialization

	make (man: EB_TOOL_MANAGER) is
		do
--			resources.add_user (Current)
			Precursor (man)
 			create stone
--			set_default_size
--			set_default_format
--			set_default_position
			dynamic_lib_exports := Eiffel_dynamic_lib.dynamic_lib_exports
		end

	init_formatters is
		do
			create format_list.make (Current)
			set_last_format (format_list.default_format)
		end

feature {EB_TOOL_MANAGER} -- Initialization

	build_interface is
		do
			Precursor

--			create_toolbar (global_form)

--			build_menus
--			build_format_bar
--			fill_menus
--			build_toolbar_menu

--			if resources.command_bar.actual_value = False then
--				dynamic_lib_toolbar.hide
--			end
			show
		end

feature -- Representation

	dynamic_lib_exports: HASH_TABLE [LINKED_LIST[DYNAMIC_LIB_EXPORT_FEATURE],INTEGER]

feature -- Properties

	stone: DYNAMIC_LIB_STONE

--	stone_type: INTEGER is
--			-- Accept any type stone
--		do
--			Result := Dynamic_lib_type
--		end

	in_use: BOOLEAN
			-- Is the system tool used (not hidden)?

	is_clickable: BOOLEAN

	set_clickable (val:BOOLEAN) is
		do
			is_clickable := val
		end

--	help_index: INTEGER is 8

	icon_id: INTEGER is
			-- Icon id of Current window (only for windows)
		do
			Result := Interface_names.i_Dynamic_lib_id
		end

feature -- Access

	format_bar_is_used: BOOLEAN is False

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
--			Result :=
--				a_stone.stone_type = Routine_type or else
--				a_stone.stone_type = Breakable_type 
--				--or else
--				--a_stone.stone_type = Class_type
		end


feature -- Status setting

	set_in_use (b: BOOLEAN) is
			-- Assign `b' to `in_use'.
		do
			in_use := b
		end

	set_mode_for_reading_only is
			-- Set the text mode to be read only.
		do
			text_window.set_editable (False)
		end

	set_mode_for_editing is
			-- Set the text mode to be editable.
		do
			text_window.set_editable (True)
		end

feature -- Update

	update_save_symbol is
			-- Update the save symbol in tool.
		do
--			if save_cmd /= Void then
--				if Eiffel_dynamic_lib.modified then
--					save_cmd.change_state (False)
--				else
--					save_cmd.change_state (True)
--				end
--			end
		end
	
feature -- Stone process

	process (d_class:CLASS_C; d_creation:E_FEATURE; 
			 d_routine:E_FEATURE; d_index:INTEGER; d_alias: STRING) is
		local
			wd: EV_WARNING_DIALOG
		do
			if d_routine.is_attribute then
				create wd.make_default (parent, Interface_names.t_Warning, "An attribute can not be exported.")
			elseif d_routine.is_deferred then
				create wd.make_default (parent, Interface_names.t_Warning, "A deferred feature can not be exported.%N")
			else
				Eiffel_dynamic_lib.add_export_feature (d_class, d_creation, d_routine, d_index, d_alias)
			end
			synchronize
		end
 
	process_classi (s: CLASSI_STONE) is
		local
			class_i: CLASS_I
		do
			class_i := s.class_i
			text_window.put_string (class_i.name)
			text_window.put_string ("%N")
		end
 
	process_class (s: CLASSC_STONE) is
		local
			e_class: CLASS_C
		do
			e_class := s.e_class
			text_window.put_string (e_class.name)
			text_window.put_string ("%N")
		end

	process_feature (s: FEATURE_STONE) is
			-- Proces feature stone.
		local
			f: EXPORTED_FEATURE_NAME_STONE
		do
			f ?= s
			if f = Void then
				process (s.e_class, Void, s.e_feature, 0, Void)
			else
				process (s.e_class, Void, s.e_feature, 0, f.alias_name)
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
		local
--			local_showflat_frmt_holder: FORMAT_HOLDER
--			local_showclick_frmt_holder: FORMAT_HOLDER
		do
			display_clickable_dynamic_lib_exports(False)
			update_save_symbol
		end

	show_file_content (a_file_name: STRING) is
			-- Display content of file named `a_file_name'
			-- do not change title, nor file_name
		local
			a_file: PLAIN_TEXT_FILE
			content:STRING
			wd: EV_WARNING_DIALOG
		do
			create a_file.make_open_read (a_file_name)
			a_file.readstream (a_file.count)

			if not Eiffel_dynamic_lib.parse_exports_from_file(a_file) then 
				create wd.make_default (parent, Interface_names.t_Warning, "Error in the eiffel def file%N")
			end
			a_file.close

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

			create st.make
			st.add_string ("%N-- EXPORTED FEATURE(s) OF THE SHARED LIBRARY %N-- SYSTEM : " )

			st.add_string( eiffel_system.name )
			st.add_string( "%N" )

			from
				dynamic_lib_exports.start
			until
				dynamic_lib_exports.after
			loop
				st.add_string( "%N-- CLASS [" )

				class_name := clone(dynamic_lib_exports.item_for_iteration.item.compiled_class.name)

				class_name.to_upper
				st.add_string(class_name)

				st.add_string( "]%N" )
				from 
					dynamic_lib_exports.item_for_iteration.start
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

						if (dl_exp.creation_routine /=Void) and then (dl_exp.routine.id /= dl_exp.creation_routine.id) then
							st.add_string (" (")
							if is_clickable then
--  								st.add_feature_name (dl_exp.creation_routine, dl_exp.creation_routine.name)
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
--  								st.add_exported_feature_name (dl_exp.routine, dl_exp.routine.name, dl_exp.alias_name)
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

						st.add_string ("%N")

						dynamic_lib_exports.item_for_iteration.forth
					end
				end
				dynamic_lib_exports.forth
			end

			text_window.freeze
   			text_window.clear_window
			text_window.process_text (st)
--			text_window.set_top_character_position (0)
 			text_window.thaw
			text_window.set_changed(False)
		end

	set_default_format is
			-- Default format of windows.
		local
		do
			if stone /= Void then
				set_last_format (format_list.default_format)
			else
				set_last_format (format_list.default_format)
			end
		end

feature -- Update
	
	reset is
			-- Reset the window contents
		do
			Precursor
			reset_format_buttons
		end

	reset_format_buttons is
			-- Reset the format buttons to the original state.
		do
--			showtext_frmt_holder.set_sensitive (True)
--			showclick_frmt_holder.set_sensitive (True)
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
--			{EB_MULTIFORMAT_TOOL} Precursor
		end


feature -- Formats

	format_list: EB_DYNAMIC_LIB_FORMATTER_LIST

--	showflat_frmt_holder: FORMAT_HOLDER

--	showclick_frmt_holder: FORMAT_HOLDER


feature -- Graphical Interface

	display is
			-- Display the dynamic lib tool
		obsolete
			"Use show or raise"
		do
--			{BAR_AND_TEXT} Precursor
--			if not shown then
--				set_default_format
--				set_default_position
--				init_text_window
--				show
--			end
			raise
--			set_in_use (True)
		end

	build_toolbar_menu is
			-- Build the toolbar menu under the special sub menu.
		local
--			sep: SEPARATOR
--			toolbar_t: TOGGLE_B
		do
--			!! sep.make (Interface_names.t_Empty, special_menu)
--			!! toolbar_t.make (dynamic_lib_toolbar.identifier, special_menu)
--			dynamic_lib_toolbar.init_toggle (toolbar_t)
		end

	create_toolbar (a_parent: EV_CONTAINER) is
			-- Create a toolbar_parent with parent `a_parent'.
		local
--			sep: THREE_D_SEPARATOR
		do
--			!! toolbar_parent.make (new_name, a_parent)
--			!! sep.make (Interface_names.t_Empty, toolbar_parent)
--			toolbar_parent.set_column_layout
--			toolbar_parent.set_free_size	
--			toolbar_parent.set_margin_height (0)
--			toolbar_parent.set_spacing (1)
--			!! dynamic_lib_toolbar.make (Interface_names.n_Tool_bar_name, toolbar_parent)
--			if not Platform_constants.is_windows then
--				!! sep.make (Interface_names.t_Empty, toolbar_parent)
--			else
--				dynamic_lib_toolbar.set_height (22)
--			end
		end

	raise_shell_popup is
			-- Raise the shell command popup window if it is popped up.
		local
--			shell_window: SHELL_W
--			shell_cmd: SHELL_COMMAND
		do
--			shell_cmd ?= shell.associated_command
--			shell_window := shell_cmd.shell_window
--			if shell_window /= Void and then shell_window.is_popped_up then
--				shell_window.raise
--			end
		end

feature {NONE} -- Properties Window Properties

	editable: BOOLEAN is True
			-- Is Current editable?

	empty_tool_name: STRING is
			-- The name of this tool.
		do
			Result := "Dynamic Lib tool"
		end

--	hole: DYNAMIC_LIB_HOLE
			-- Hole caraterizing current
 
	format_label: EV_LABEL

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
			raise
		end


feature

	save_text is
			-- launches the save command, if any.
		do
			save_cmd.execute (Void, Void)
		end


feature {NONE, QUIT_DYNAMIC_LIB, OPEN_DYNAMIC_LIB} -- Commands

--	open_cmd: COMMAND_HOLDER

	save_cmd: EB_SAVE_FILE_CMD

	shell_cmd: EB_OPEN_SHELL_CMD

	filter_cmd: EB_FILTER_CMD

feature -- D'OH!

	close_cmd: EB_CLOSE_EDITOR_CMD

feature {EB_TOOL_MANAGER} -- Menus Implementation

	build_file_menu (a_menu: EV_MENU_ITEM_HOLDER) is
		local
			i: EV_MENU_ITEM
		do
--			create open_cmd.make (Current)
			create i.make_with_text (a_menu, Interface_names.m_Open)
--			i.add_select_command (open_cmd, Void)

--			create save_cmd.make (Current)
			create i.make_with_text (a_menu, Interface_names.m_Save)
--			i.add_select_command (save_cmd, Void)

--			create save_as_cmd.make (Current)
			create i.make_with_text (a_menu, Interface_names.m_Save_as)
--			i.add_select_command (save_as_cmd, Void)

			create i.make_with_text (a_menu, Interface_names.m_Exit)
--			i.add_select_command (close_cmd, Void)

			create i.make_with_text (a_menu, Interface_names.m_Exit_project)
			i.add_select_command (exit_app_cmd, Void)

		end

	build_special_menu (a_menu: EV_MENU_ITEM_HOLDER) is
		local
			i: EV_MENU_ITEM
		do
			create shell_cmd.make (Current)
			create i.make_with_text (a_menu, Interface_names.m_Shell)
			i.add_select_command (shell_cmd, Void)

			create filter_cmd.make (Current)
			create i.make_with_text (a_menu, Interface_names.m_Filter)
			i.add_select_command (filter_cmd, Void)
		end

feature {NONE} -- Implementation Graphical Interface

	build_edit_bar (a_toolbar: EV_BOX) is
		local
--			quit_cmd: QUIT_DYNAMIC_LIB
--			quit_button: EB_BUTTON
--			quit_menu_entry: EB_MENU_ENTRY
--			exit_menu_entry: EB_MENU_ENTRY
--			open_cmd: OPEN_DYNAMIC_LIB
--			open_button: EB_BUTTON
--			open_menu_entry: EB_MENU_ENTRY
--			save_cmd: SAVE_FILE
--			save_button: EB_BUTTON
--			save_menu_entry: EB_MENU_ENTRY
--			history_list_cmd: LIST_HISTORY
		do
--			!! open_cmd.make (Current)
--			!! open_button.make (open_cmd, dynamic_lib_toolbar)
--			!! open_menu_entry.make (open_cmd, file_menu)
--			!! open_cmd_holder.make (open_cmd, open_button, open_menu_entry)
--			!! save_cmd.make (Current)
--			!! save_button.make (save_cmd, dynamic_lib_toolbar)
--			!! save_menu_entry.make (save_cmd, file_menu)
--			!! save_cmd_holder.make (save_cmd, save_button, save_menu_entry)
--			build_save_as_menu_entry
--			build_print_menu_entry
--			!! quit_cmd.make (Current)
--			!! quit_menu_entry.make (quit_cmd, file_menu)
--			if General_resources.close_button.actual_value then
--				!! quit_button.make (quit_cmd, dynamic_lib_toolbar)
--			end
--			!! quit_cmd_holder.make (quit_cmd, quit_button, quit_menu_entry)
--			!! exit_menu_entry.make (Project_tool.quit_cmd_holder.associated_command, file_menu)
--			!! exit_cmd_holder.make_plain (Project_tool.quit_cmd_holder.associated_command)
--			exit_cmd_holder.set_menu_entry (exit_menu_entry)
--			build_edit_menu (dynamic_lib_toolbar)

			create format_bar.make (a_toolbar)
		end

--	build_format_bar is
--			-- Build formatting buttons in `dynamic_lib_toolbar'.
--		local
--			version_menu_entry: EB_MENU_ENTRY
--			shell_cmd: SHELL_COMMAND
--			shell_button: EB_BUTTON_HOLE
--			shell_menu_entry: EB_MENU_ENTRY
--			tex_cmd: SHOW_TEXT_DYNAMIC_LIB
--			tex_button: FORMAT_BUTTON
--			tex_menu_entry: EB_TICKABLE_MENU_ENTRY
--			click_cmd: SHOW_CLICK_DYNAMIC_LIB
--			click_button: FORMAT_BUTTON
--			click_menu_entry: EB_TICKABLE_MENU_ENTRY
--			sep: SEPARATOR
--			sep1, sep2, sep3: THREE_D_SEPARATOR
--		do
--			!! shell_cmd.make (Current)
--			!! shell_button.make (shell_cmd, dynamic_lib_toolbar)
--			shell_button.add_third_button_action
--			!! shell_menu_entry.make (shell_cmd, special_menu)
--			!! shell.make (shell_cmd, shell_button, shell_menu_entry)
--
--			build_filter_menu_entry
--
--			!! sep.make (new_name, special_menu)
--
--				-- First we create all objects.
--			!! tex_cmd.make (Current)
--			!! tex_button.make (tex_cmd, dynamic_lib_toolbar)
--			!! tex_menu_entry.make (tex_cmd, format_menu)
--			!! showtext_frmt_holder.make (tex_cmd, tex_button, tex_menu_entry)
--
--			!! click_cmd.make (Current)
--			!! click_button.make (click_cmd, dynamic_lib_toolbar)
--			!! click_menu_entry.make (click_cmd, format_menu)
--			!! showclick_frmt_holder.make (click_cmd, click_button, click_menu_entry)
--
--			!! hole.make (Current)
--			!! hole_button.make (hole, dynamic_lib_toolbar)
--			!! hole_holder.make_plain (hole)
--			hole_holder.set_button (hole_button)
--
--			create_edit_buttons
--		end

end -- class EB_DYNAMIC_LIB_TOOL
