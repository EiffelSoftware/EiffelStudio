indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PROJECT_WINDOW

inherit
	EB_TOOL_WINDOW
		redefine
			make, make_top_level
		end

	WINDOW_ATTRIBUTES

	SYSTEM_CONSTANTS

	SHARED_APPLICATION_EXECUTION

	SHARED_EIFFEL_PROJECT

	PROJECT_CONTEXT

	WIDGET_ROUTINES

	INTERFACE_NAMES

creation
	make, make_top_level

feature -- Initialization

	make (par: EV_WINDOW) is
			-- Create a project application.
		do
			Precursor (par)

			create tool.make (Current)

			initialize_main_menu

--			base_make (Icon_id.out, a_screen)

			add_destroy_command (tool.close_cmd, Void)
--			set_font_to_default
--			set_default_position
		end

	make_top_level is
			-- Create a project application.
		do
			Precursor

			create tool.make (Current)

			initialize_main_menu

--			base_make (Icon_id.out, a_screen)

--			add_destroy_command (tool.close_cmd, Void)
--			set_font_to_default
--			set_default_position
		end
	
feature -- Access

	tool: EB_PROJECT_TOOL

	popdown: EV_ARGUMENT1 [ANY] is
		once
			create Result.make (Void)
		end

	remapped: EV_ARGUMENT1 [ANY] is
		once
			create Result.make (Void)
		end

	icon_id: INTEGER is
			-- Icon id of Current window (for windows)
		do
			Result := Interface_names.i_Project_id
		end

feature -- Window Settings

	force_raise is
			-- Raise the project tool.
		do
--			raise
		end

	set_default_size is
		do
		end

	set_default_position is
			-- Display the project tool at the 
			-- upper left corner of the screen.
		local
			default_x, default_y: INTEGER
		do
			default_x := Project_resources.tool_x.actual_value
			default_y := Project_resources.tool_y.actual_value
			set_x_y (default_x, default_y)
		end
 
	set_initialized is
			-- Set `initialized' to true.
		do
			initialized := true
		ensure
			initialized = true
		end

feature -- Window Properties

	initialized: BOOLEAN
			-- Is the workbench created?

	is_system_tool_hidden: BOOLEAN
			-- Is the system tool hidden?

	is_project_tool_hidden: BOOLEAN
			-- Is the project tool hidden?

	is_preference_tool_hidden: BOOLEAN
			-- Is the preference tool hidden?

	is_profile_tool_hidden: BOOLEAN
			-- Is the profile tool hidden?

	tool_name: STRING is
			-- Name of the tool.
		do
				--| If the tool already has a name, we keep it, otherwise
				--| we return the default name.
			if title /= Void then
				Result := title
			else
				Result := Interface_names.t_Project
			end
		end

feature -- Window Holders

	stop_points_hole_holder: HOLE_HOLDER

	system_hole_holder: HOLE_HOLDER

	class_hole_holder: HOLE_HOLDER

	routine_hole_holder: HOLE_HOLDER

	dynamic_lib_hole_holder: HOLE_HOLDER

	object_hole_holder: HOLE_HOLDER

	explain_hole_holder: HOLE_HOLDER

feature -- Pulldown Menus

	file_menu: EV_MENU
			-- Menu for project file management.

	special_menu: EV_MENU
			-- ID Menu for commands.
			-- Only used during debugging

	format_menu: EV_MENU
			-- ID Menu for formats.
			-- Only used during debugging

	compile_menu: EV_MENU
			-- Compile ID menu.

	debug_menu: EV_MENU
			-- Debug ID menu.

	window_menu: EV_MENU
			-- Window ID menu.

	open_classes_menu: EV_MENU_ITEM
			-- ID Menu for open class tools

	open_features_menu: EV_MENU_ITEM
			-- ID Menu for open feature tools

	open_objects_menu: EV_MENU_ITEM
			-- ID Menu for open object tools

	open_explains_menu: EV_MENU_ITEM
			-- ID Menu for open explain tools

	edit_feature_menu: EV_MENU_ITEM
			-- ID Edit menu specific for the feature part

	special_feature_menu: EV_MENU_ITEM
			-- ID Special menu specific for the feature part

	format_feature_menu: EV_MENU_ITEM
			-- ID Format menu specific for the feature part

	edit_object_menu: EV_MENU_ITEM
			-- ID Edit menu specific for the object part

	special_object_menu: EV_MENU_ITEM
			-- ID Special menu specific for the object part

	format_object_menu: EV_MENU_ITEM
			-- ID Format menu specific for the object part

	recent_project_menu: INTEGER is 16
			-- ID Recent project menu for the file menu

	active_menus (erase: BOOLEAN) is
			-- Enable all the menus and if `erase' clean
			-- the content of the Project tool.
		do
--			compile_menu.set_insensitive (False)
--			debug_menu.set_insensitive (False)
--			format_menu.set_insensitive (False)
--			special_menu.set_insensitive (False)
--			window_menu.set_insensitive (False)
--			if erase then
--				text_window.clear_window
--			end
		end

	disable_menus is
			-- Disable all the menus.
		do
--			compile_menu.set_insensitive (True)
--			debug_menu.set_insensitive (True)
--			format_menu.set_insensitive (True)
--			special_menu.set_insensitive (True)
--			window_menu.set_insensitive (True)
		end

feature -- Modifiable menus

	melt_menu_item: EV_MENU_ITEM
			-- Melt menu entry

	quick_melt_menu_item: EV_MENU_ITEM
			-- Quick-Melt menu entry

	freeze_menu_item: EV_MENU_ITEM
			-- Freeze menu entry

	finalize_menu_item: EV_MENU_ITEM
			-- Finalize menu entry

	precompile_menu_item: EV_MENU_ITEM
			-- Precompile menu entry

feature -- Progress Dialog

	progress_dialog: DEGREE_OUTPUT
			-- Progress dialog associated with the project.
			-- It can be a graphical one or a text mode one.

	set_progress_dialog (new_progress_dialog: DEGREE_OUTPUT) is
			-- Set `progress_dialog' to `new_progress_dialog'.
			-- Set also `Eiffel_project' progress_dialog which needs to know
			-- that we changed the kind of `progress_dialog'.
		local
--			graphical_version: GRAPHICAL_DEGREE_OUTPUT
		do
--			progress_dialog := new_progress_dialog
--			Eiffel_project.set_degree_output (progress_dialog)
--
--				-- If `process_dialog' is a graphical dialog then
--				-- We need to give him its parent.
--			graphical_version ?= progress_dialog
--			if graphical_version /= Void then
--				graphical_version.set_parent_window (implementation)
--			end
		end

feature -- Update

	close_windows is
			-- Close associated windows.
		do
		end

	initialize_main_menu is
			-- Build the menu bar
		local
			sep: SEPARATOR
			case_storage_cmd: CASE_STORAGE
			case_storage_menu_entry: EB_MENU_ENTRY
			document_submenu: EV_MENU
			generate_doc_cmd: DOCUMENT_GENERATION
			generate_menu_entry: EB_MENU_ENTRY
			generate_submenu: EV_MENU
		do
			create menu_bar.make (Current)
			create file_menu.make_with_text (menu_bar, Interface_names.m_File)
--			create edit_menu.make_with_text (menu_bar, Interface_names.m_Edit)
			create compile_menu.make_with_text (menu_bar, Interface_names.m_Compile)

			create debug_menu.make_with_text (menu_bar, Interface_names.m_Debug)
			create format_menu.make_with_text (menu_bar, Interface_names.m_Formats)
			create special_menu.make_with_text (menu_bar, Interface_names.m_Special)
			create window_menu.make_with_text (menu_bar, Interface_names.m_Windows)

			build_file_menu
			build_compile_menu
			build_toolbar_menu
			build_windows_menu
--			build_help_menu

				--| Creation of empty menus that are disabled goes here,
				--| for we want to create the object and / or feature portion
				--| on demand and not on purpose.
--			create edit_feature_menu.make_with_text (edit_menu, Interface_names.m_Feature)
--			local_menu.button.set_insensitive
--
--			create edit_object_menu.make_with_text (edit_menu, Interface_names.m_Object)
--			local_menu.button.set_insensitive
--
--			create sep.make (edit_menu)
--
--			create format_feature_menu.make (Interface_names.m_Feature, format_menu)
--			local_menu.button.set_insensitive
--
--			create format_object_menu.make (Interface_names.m_Object, format_menu)
--			local_menu.button.set_insensitive
--
--			create sep.make (Interface_names.t_Empty, format_menu)
--
--			create special_feature_menu.make (Interface_names.m_Feature, special_menu)
--			local_menu.button.set_insensitive
--
--			create special_object_menu.make (Interface_names.m_Object, special_menu)
--			local_menu.button.set_insensitive
--
--			create sep.make (Interface_names.t_Empty, special_menu)
--			create case_storage_cmd
--			create case_storage_menu_entry.make_default (case_storage_cmd, special_menu)
--			create generate_submenu.make (Interface_names.m_Document, special_menu)
--			create generate_doc_cmd.make_flat
--			create generate_menu_entry.make (generate_doc_cmd, generate_submenu)
--			create generate_doc_cmd.make_flat_short
--			create generate_menu_entry.make (generate_doc_cmd, generate_submenu)
--			create generate_doc_cmd.make_short
--			create generate_menu_entry.make (generate_doc_cmd, generate_submenu)
--			create generate_doc_cmd.make_text
--			create generate_menu_entry.make (generate_doc_cmd, generate_submenu)

			build_top
		end

	build_file_menu is
			-- Build the file menu.
		local
			new_cmd: EB_NEW_PROJECT_CMD
			new_menu_item: EV_MENU_ITEM
			open_cmd: EB_OPEN_PROJECT_CMD
			open_menu_item: EV_MENU_ITEM
--			quit_cmd: QUIT_PROJECT
			quit_menu_item: EV_MENU_ITEM
		do
			create new_cmd.make (tool)
			create new_menu_item.make_with_text (file_menu, m_New_project)
			new_menu_item.add_select_command (new_cmd, Void)

			create open_cmd.make (tool)
			create open_menu_item.make_with_text (file_menu, m_Open_project)
			open_menu_item.add_select_command (open_cmd, Void)

--			build_print_menu_entry
--
--			build_recent_project_menu_entries

--			create quit_cmd.make (tool)
			create quit_menu_item.make_with_text (file_menu, m_Exit_project)
--			create quit_cmd_holder.make_plain (quit_cmd)
--			quit_cmd_holder.set_menu_entry (quit_menu_entry)
		end

	build_compile_menu is
			-- Build the compile menu.
		local
			melt_cmd: EB_MELT_PROJECT_CMD
			quick_melt_cmd: EB_QUICK_MELT_PROJECT_CMD
--			freeze_cmd: FREEZE_PROJECT
--			finalize_cmd: FINALIZE_PROJECT
--			precompile_cmd: PRECOMPILE_PROJECT
			c_compilation: EB_C_COMPILATION_CMD
			c_compile_menu: EV_MENU_ITEM
			i: EV_MENU_ITEM
			arg: EV_ARGUMENT1 [EB_PROJECT_TOOL]
--			sep: SEPARATOR
		do
--			!! special_cmd.make (Current)
--			!! special_cmd_holder.make_plain (special_cmd)
-- This becomes a general purpose about box.

			create arg.make (tool)

			create melt_cmd.make (tool)
			create melt_menu_item.make_with_text (compile_menu, m_Update)
			melt_menu_item.add_select_command (melt_cmd, arg)

			create quick_melt_cmd.make (tool)
			create quick_melt_menu_item.make_with_text (compile_menu, m_Quick_update)
			quick_melt_menu_item.add_select_command (quick_melt_cmd, arg)

--			create freeze_cmd.make (tool)
			create freeze_menu_item.make_with_text (compile_menu, m_Freeze)
--			freeze_menu_item.add_select_command (freeze_cmd, arg)

--			create finalize_cmd.make (tool)
			create finalize_menu_item.make_with_text (compile_menu, m_Finalize)
--			finalize_menu_itemi.add_select_command (finalize_cmd, arg)

--			create precompile_cmd.make (tool)
			create precompile_menu_item.make_with_text (compile_menu, m_Precompile)
--			precompile_menu_item.add_select_command (precompile_cmd, arg)

--			create sep.make (Interface_names.t_Empty, compile_menu)

			create c_compile_menu.make_with_text (compile_menu, Interface_names.m_C_compilation)
			create c_compilation.make_workbench
			create i.make_with_text (c_compile_menu, Interface_names.m_Workbench_mode)
			i.add_select_command (c_compilation, Void)
			create c_compilation.make_final
			create i.make_with_text (c_compile_menu, Interface_names.m_Final_mode)
			i.add_select_command (c_compilation, Void)
		end
		
	build_toolbar_menu is
			-- Build the toolbar menu under the special sub menu.
		local
--			sep: EV_SEPARATOR
			toolbar_t: EV_CHECK_MENU_ITEM
		do
--			create sep.make (special_menu)
			create toolbar_t.make_with_text (special_menu,"") -- project_toolbar.identifier)
			toolbar_t.set_selected (True)
			create toolbar_t.make_with_text (special_menu,"") -- format_bar.identifier)
			toolbar_t.set_selected (True)
			create toolbar_t.make_with_text (special_menu,"") -- selector_part.identifier)
			toolbar_t.set_selected (True)
		end

	build_windows_menu is
		local
			tool_action: EB_TOOL_BROADCASTER

			create_explain_cmd: EB_CREATE_EXPLAIN_CMD
			explain_menu_item: EV_MENU_ITEM

			create_class_cmd: EB_CREATE_CLASS_CMD
			class_menu_item: EV_MENU_ITEM

			create_feature_cmd: EB_CREATE_FEATURE_CMD
			feature_menu_item: EV_MENU_ITEM

			create_object_cmd: EB_CREATE_OBJECT_CMD
			object_menu_item: EV_MENU_ITEM

			show_profiler: EB_SHOW_PROFILE_TOOL
			show_preferences: EB_SHOW_PREFERENCE_TOOL
			i: EV_MENU_ITEM
		do
			create tool_action

			create i.make_with_text (window_menu, m_Close_all_tools)
			i.add_select_command (tool_action, tool_action.Close_all)

			create i.make_with_text (window_menu, m_Raise_all_tools)
			i.add_select_command (tool_action, tool_action.Raise_all)

				-- Sub menus for open tools.
			create open_explains_menu.make_with_text (window_menu, Interface_names.m_Explain_tools)
			create open_classes_menu.make_with_text (window_menu, Interface_names.m_Class_tools)
			create open_features_menu.make_with_text (window_menu, Interface_names.m_Feature_tools)
			create open_objects_menu.make_with_text (window_menu, Interface_names.m_Object_tools)

			create create_explain_cmd.make (tool)
			create explain_menu_item.make_with_text (open_explains_menu, Interface_names.m_New_explain)
			explain_menu_item.add_select_command (create_explain_cmd, Void)

			create create_class_cmd.make (tool)
			create class_menu_item.make_with_text (open_classes_menu, Interface_names.m_New_class)
			class_menu_item.add_select_command (create_class_cmd, Void)

			create create_feature_cmd.make (tool)
			create feature_menu_item.make_with_text (open_features_menu, Interface_names.m_New_routine)
				-- routine should be replaced by feature later
			feature_menu_item.add_select_command (create_feature_cmd, Void)

			create create_object_cmd.make (tool)
			create object_menu_item.make_with_text (open_objects_menu, Interface_names.m_New_object)
			object_menu_item.add_select_command (create_object_cmd, Void)

			create show_profiler
			create i.make_with_text (window_menu, Interface_names.m_Profile_tool)
			i.add_select_command (show_profiler, Void)

			create show_preferences.make
			create i.make_with_text (window_menu, Interface_names.m_Preferences)
			i.add_select_command (show_preferences, Void)
		end

	build_top is
			--
		local
--			tool_action: TOOLS_MANAGEMENT
--			tool_action_menu_entry: EV_MENU_ITEM
--			explain_cmd: EXPLAIN_HOLE
--			explain_menu_entry: EV_MENU_ITEM
--			system_cmd: SYSTEM_HOLE
--			system_menu_entry: EV_MENU_ITEM

--			shell_cmd: SHELL_COMMAND
--			clear_bp_cmd: DEBUG_CLEAR_STOP_POINTS_HOLE
--			clear_bp_menu_entry: EB_MENU_ENTRY
--			stop_points_cmd: DEBUG_STOPIN_HOLE
--			stop_points_menu_entry: EB_MENU_ENTRY
--			stop_points_status_cmd: STOPPOINTS_STATUS
--			stop_points_status_menu_entry: EB_MENU_ENTRY

--			dynamic_lib_cmd: DYNAMIC_LIB_HOLE
--			dynamic_lib_button: EB_BUTTON_HOLE
--			dynamic_lib_menu_entry: EB_MENU_ENTRY

--			show_pref_cmd: EB_LAUNCHER1
--			show_pref_menu_entry: EB_MENU_ENTRY

--			show_prof_cmd: EB_SHOW_PROFILE_TOOL
--			show_prof_menu_entry: EB_MENU_ENTRY

--			sep: SEPARATOR
--			sep1, sep2: THREE_D_SEPARATOR
--			display_feature_cmd: DISPLAY_ROUTINE_PORTION
--			display_feature_button: EB_BUTTON
--			display_feature_menu_entry: EB_MENU_ENTRY
--			display_object_cmd: DISPLAY_OBJECT_PORTION
--			display_object_button: EB_BUTTON
--			display_object_menu_entry: EB_MENU_ENTRY
--			update_cmd: UPDATE_PROJECT
--			update_button: EB_BUTTON
--			quick_update_cmd: UPDATE_PROJECT
--			quick_update_button: EB_BUTTON
--  			version_button: PUSH_B

--			about_menu_entry: EB_MENU_ENTRY
--			about_cmd: EB_LAUNCHER3
--			about_tool: EB_ABOUT_WINDOW
			local_menu: EV_MENU_ITEM
--			do_nothing_cmd: DO_NOTHING_CMD
		do

			-- Help Menu
--			create version_button.make (Version_number, help_menu)

--			create about_tool.make ("About_Dialog", screen)
--			create about_cmd.make (about_tool)
--			create about_menu_entry.make_default (about_cmd, help_menu)

				-- Edit Menu
--			build_edit_menu (project_toolbar)

--			create sep.make (Interface_names.t_Empty, edit_menu)
--			create show_pref_cmd.make (Project_resources)
--			create show_pref_menu_entry.make_default (show_pref_cmd, edit_menu)

				-- Close all command
--			create tool_action.make_close_all
--			create tool_action_menu_entry.make_default (tool_action, window_menu)

--			create tool_action.make_raise_all
--			create tool_action_menu_entry.make_default (tool_action, window_menu)

--			create sep.make (Interface_names.t_Empty, window_menu)

--			create sep.make (window_menu)

				-- Regular menu entries.
--			create explain_cmd.make (Current)
--			create explain_button.make (explain_cmd, project_toolbar)
--			create explain_menu_entry.make (explain_cmd, open_explain_menu)
--			create explain_hole_holder.make (explain_cmd, explain_button, explain_menu_entry)

--			create system_cmd.make (Current)
--			create system_button.make (system_cmd, project_toolbar)
--			create system_menu_entry.make (system_cmd, window_menu)
--			create system_hole_holder.make (system_cmd, system_button, system_menu_entry)
			
--			create dynamic_lib_cmd.make (Current)
--			create dynamic_lib_button.make (dynamic_lib_cmd, project_toolbar)
--			create dynamic_lib_menu_entry.make (dynamic_lib_cmd, window_menu)
--			create dynamic_lib_hole_holder.make (dynamic_lib_cmd, dynamic_lib_button, dynamic_lib_menu_entry)

--			create shell_cmd.make (Current)
--			create shell_button.make (shell_cmd, project_toolbar)
--			shell_button.add_third_button_action

--			create stop_points_cmd.make (Current)
--			create stop_points_button.make (stop_points_cmd, project_toolbar)
--			create stop_points_menu_entry.make (stop_points_cmd, debug_menu)
--			create stop_points_hole_holder.make (stop_points_cmd, stop_points_button, stop_points_menu_entry)

--			create clear_bp_cmd.make (Current)
--			create clear_bp_button.make (clear_bp_cmd, project_toolbar)
--			clear_bp_button.set_action ("c<Btn1Down>", 
--						clear_bp_cmd, clear_bp_cmd.clear_it_action)
--			create clear_bp_menu_entry.make (clear_bp_cmd, debug_menu)
--			create clear_bp_cmd_holder.make (clear_bp_cmd, clear_bp_button, clear_bp_menu_entry)

--			create stop_points_status_cmd.make_enabled
--			create stop_points_status_menu_entry.make_default (stop_points_status_cmd, debug_menu)
--			create stop_points_status_cmd.make_disabled
--			create stop_points_status_menu_entry.make_default (stop_points_status_cmd, debug_menu)
--			create sep.make (Interface_names.t_Empty, debug_menu)

--			create show_prof_cmd
--			create show_prof_menu_entry.make_default (show_prof_cmd, window_menu)

--			create display_feature_cmd.make (Current)
--			create display_feature_button.make (display_feature_cmd, project_toolbar)
--			create display_feature_menu_entry.make (display_feature_cmd, format_menu)
--			create display_feature_cmd_holder.make (display_feature_cmd, display_feature_button, display_feature_menu_entry)
--			display_feature_cmd.set_holder (display_feature_cmd_holder)
--
--			create display_object_cmd.make (Current)
--			create display_object_button.make (display_object_cmd, project_toolbar)
--			create display_object_menu_entry.make (display_object_cmd, format_menu)
--			create display_object_cmd_holder.make (display_object_cmd, display_object_button, display_object_menu_entry)
--			display_object_cmd.set_holder (display_object_cmd_holder)
--
--			create update_cmd.make (Current)
--			create update_button.make (update_cmd, project_toolbar)
--			update_button.set_action ("c<Btn1Down>", update_cmd, update_cmd.generate_code_only)
--			create melt_menu_entry.make (update_cmd, compile_menu)
--			create update_cmd_holder.make (update_cmd, update_button, melt_menu_entry)
--
--			create quick_update_cmd.make (Current)
--			quick_update_cmd.set_quick_melt
--			create quick_update_button.make (quick_update_cmd, project_toolbar)
--			quick_update_button.set_action ("c<Btn1Down>", quick_update_cmd, quick_update_cmd.generate_code_only)
--			create quick_melt_menu_entry.make (quick_update_cmd, compile_menu)
--			create quick_update_cmd_holder.make (quick_update_cmd, quick_update_button, quick_melt_menu_entry)
--
--			create sep1.make (interface_names.t_empty, project_toolbar)
--			sep1.set_horizontal (False)
--
--			create sep2.make (interface_names.t_empty, project_toolbar)
--			sep2.set_horizontal (False)
--
--			create do_nothing_cmd
--			project_toolbar.set_action ("c<Btn1Down>", do_nothing_cmd, Void)
		end

--	build_recent_project_menu_entries is
--			-- Add the last open projects entries
--		local
--			environment_variable: EXECUTION_ENVIRONMENT
--			last_opened_projects, project_file_name: STRING
--			i, nb, pos, old_pos: INTEGER
--			local_menu: MENU_PULL
--			sep: SEPARATOR
--			open_cmd: OPEN_PROJECT
--			open_menu_entry: EB_MENU_ENTRY
--		do
--			create environment_variable
--
--				--| Need to put the string in SYSTEM_CONSTANTS
--			last_opened_projects := environment_variable.get (Bench_Recent_Files)
--			create recent_project_list.make	
--			recent_project_list.compare_objects
--
--			if last_opened_projects /= Void then
--				from
--					create recent_project_menu.make (Interface_names.m_Recent_project, file_menu)
--					nb := last_opened_projects.occurrences (';')
--					old_pos := 1
--					i := 0
--				until
--					i >= nb
--				loop
--					pos := last_opened_projects.index_of (';', old_pos + 1)
--					project_file_name := last_opened_projects.substring (old_pos, pos - 1)
--					old_pos := pos + 1
--					i := i + 1
--					create open_cmd.make_from_project_file (Current, project_file_name)
--					create open_menu_entry.make (open_cmd, recent_project_menu)
--					recent_project_list.extend (project_file_name)
--				end
--				if nb > 0 then
--					create sep.make (Interface_names.t_Empty, file_menu)
--				end
--			end
--		end

 
feature {NONE} -- Implementation

--	add_tool_to_menu (a_tool: BAR_AND_TEXT a_menu: MENU_PULL) is
--			-- Add a menu entry reflecting `a_tool' to `a_menu'.
--		local
--			sep: SEPARATOR
--			entry: TOOL_MENU_ENTRY
--			cmd: RAISE_TOOL_CMD
--			a_font: FONT
--			a_color: COLOR
--		do
--			if a_menu.children_count = 1 then
--				create sep.make (Interface_names.t_Empty, a_menu)
--			end
--			create cmd.make (a_tool)
--			create entry.make (cmd, a_menu, a_tool)
--			a_font := Graphical_resources.font.actual_value
--			if a_font /= Void then
--				entry.set_font (a_font)
--			end
--			a_color := Graphical_resources.background_color.actual_value
--			if a_color /= Void then
--				entry.set_background_color (a_color)
--			end
--			a_color := Graphical_resources.foreground_color.actual_value
--			if a_color /= Void then
--				entry.set_foreground_color (a_color)
--			end
--		end

--	change_tool_in_menu (a_tool: BAR_AND_TEXT a_menu: MENU_PULL) is
--			-- Change the entry in `a_menu' reflecting `a_tool'
--			-- so that the entry has `a_tool.title' as text.
--		local
--			done: BOOLEAN
--			list: ARRAYED_LIST [WIDGET]
--			menu_entry: TOOL_MENU_ENTRY
--			raise_cmd: RAISE_TOOL_CMD
--		do
--			from
--				list := a_menu.children
--				list.start
--			until
--				list.after or done
--			loop
--					-- Get rid of the separators.
--				menu_entry ?= list.item
--				if menu_entry /= Void and then menu_entry.tool = a_tool then
--					menu_entry.set_text (a_tool.title)
--					done := True
--				else
--					list.forth
--				end
--			end
--		end

--	remove_tool_from_menu (a_tool: EB_EDITOR; a_menu: EV_MENU) is
--			-- Remove menu entry reflecting `a_tool' from
--			-- `a_menu'.
--		local
--			done: BOOLEAN
--			list: ARRAYED_LIST [EV_WIDGET]
--			menu_entry: TOOL_MENU_ENTRY
--			raise_cmd: RAISE_TOOL_CMD
--		do
--			from
--				list := a_menu.children
--				list.start
--			until
--				list.after or done
--			loop
--					-- Get rid of the separators.
--				menu_entry ?= list.item
--				if menu_entry /= Void and then menu_entry.tool = a_tool then
--					menu_entry.destroy
--					done := True
--				else
--					list.forth
--				end
--			end
--			if list.count = 3 then
--				remove_separator (list)
--			end
--		end

--	remove_separator (list: ARRAYED_LIST [EV_WIDGET]) is
--			-- Remove the separator item from `list'
--		require
--			list_count_is_three: list.count = 3
--		local
--			done: BOOLEAN
--			sep: EV_SEPARATOR
--		do
--			from
--				list.start
--			until
--				list.after or done
--			loop
--				sep ?= list.item
--				if sep /= Void then
--					sep.destroy
--					done := True
--				else
--					list.forth
--				end
--			end
--		end

	saved_cursor: CURSOR
			-- Saved cursor position for displaying the stack

feature -- Compile menu update

	update_compile_menu (is_precompiling: BOOLEAN) is
			-- When `is_precompiling' is True, we need to disable all the others entry.
			-- When `is_precompiling' is False, we need to disable the precompile entry.
		do
			melt_menu_item.set_insensitive (is_precompiling)
			quick_melt_menu_item.set_insensitive (is_precompiling)
			freeze_menu_item.set_insensitive (is_precompiling)
			finalize_menu_item.set_insensitive (is_precompiling)
			precompile_menu_item.set_insensitive (not is_precompiling)
		end

end -- class EB_PROJECT_WINDOW
