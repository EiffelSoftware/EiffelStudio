indexing
	description: "Window holding a project tool"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PROJECT_WINDOW

inherit
	EB_TOOL_WINDOW
		undefine
			build_windows_menu
		redefine
			make, make_top_level
		end

	SYSTEM_CONSTANTS

	SHARED_APPLICATION_EXECUTION

	SHARED_EIFFEL_PROJECT

	PROJECT_CONTEXT

	NEW_EB_CONSTANTS

	INTERFACE_NAMES

creation
	make, make_top_level

feature -- Initialization

	make (par: EV_WINDOW) is
			-- Create a project application.
		do
			Precursor (par)

			create tool.make (Current)
			tool.build_interface

			initialize_main_menu
			tool.update
			debug_tool.update

			add_close_command (tool.close_cmd, Void)

--			set_font_to_default
--			set_default_position
		end

	make_top_level is
			-- Create a project application.
		do
			Precursor

			create tool.make (Current)
			tool.build_interface

			initialize_main_menu
			tool.update
			debug_tool.update

			add_close_command (tool.close_cmd, Void)

--			set_font_to_default
--			set_default_position
		end
	
feature -- Access

	tool: EB_PROJECT_TOOL

feature -- Window Settings

	set_default_size is
		do
		end

	set_default_position is
			-- Display the project tool at the 
			-- upper left corner of the screen.
		local
			default_x, default_y: INTEGER
		do
--			default_x := Project_resources.tool_x.actual_value
--			default_y := Project_resources.tool_y.actual_value
--			set_x_y (default_x, default_y)
		end
 
feature -- Window Properties

	is_system_tool_hidden: BOOLEAN
			-- Is the system tool hidden?

	is_project_tool_hidden: BOOLEAN
			-- Is the project tool hidden?

	is_preference_tool_hidden: BOOLEAN
			-- Is the preference tool hidden?

	is_profile_tool_hidden: BOOLEAN
			-- Is the profile tool hidden?

feature -- Pulldown Menus

	file_menu: EV_MENU
			-- Menu for project file management.

	edit_menu: EV_MENU

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

	help_menu: EV_MENU
			-- Window ID menu.

	open_classes_menu: EV_MENU_ITEM
			-- ID Menu for open class tools

	open_features_menu: EV_MENU_ITEM
			-- ID Menu for open feature tools

	open_objects_menu: EV_MENU_ITEM
			-- ID Menu for open object tools

	open_clusters_menu: EV_MENU_ITEM
			-- ID Menu for open cluster tools

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

feature -- Update

	close_windows is
			-- Close associated windows.
		do
		end

	initialize_main_menu is
			-- Build the menu bar
		local
--			case_storage_cmd: CASE_STORAGE
--			generate_doc_cmd: DOCUMENT_GENERATION
		do
			create menu_bar.make (Current)
			create file_menu.make_with_text (menu_bar, Interface_names.m_File)
			create edit_menu.make_with_text (menu_bar, Interface_names.m_Edit)
			create compile_menu.make_with_text (menu_bar, Interface_names.m_Compile)

			create debug_menu.make_with_text (menu_bar, Interface_names.m_Debug)
			create format_menu.make_with_text (menu_bar, Interface_names.m_Formats)
			create special_menu.make_with_text (menu_bar, Interface_names.m_Special)
			create window_menu.make_with_text (menu_bar, Interface_names.m_Windows)
			create help_menu.make_with_text (menu_bar, Interface_names.m_Help)

			build_file_menu (file_menu)
			build_compile_menu
			debug_tool.build_edit_menu (debug_menu)
			debug_tool.build_debug_menu (debug_menu)
			build_special_menu
			build_windows_menu (window_menu)
			build_help_menu (help_menu)

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
--			create case_storage_menu_item.make_with_text_default (case_storage_cmd, special_menu)
--			create generate_submenu.make (Interface_names.m_Document, special_menu)
--			create generate_doc_cmd.make_flat
--			create generate_menu_item.make_with_text (generate_doc_cmd, generate_submenu)
--			create generate_doc_cmd.make_flat_short
--			create generate_menu_item.make_with_text (generate_doc_cmd, generate_submenu)
--			create generate_doc_cmd.make_short
--			create generate_menu_item.make_with_text (generate_doc_cmd, generate_submenu)
--			create generate_doc_cmd.make_text
--			create generate_menu_item.make_with_text (generate_doc_cmd, generate_submenu)
		end

	build_file_menu (a_menu: EV_MENU_ITEM_HOLDER) is
			-- Build the file menu.
		local
			new_cmd: EB_NEW_PROJECT_CMD
			new_menu_item: EV_MENU_ITEM
			open_cmd: EB_OPEN_PROJECT_CMD
			open_menu_item: EV_MENU_ITEM
			quit_menu_item: EV_MENU_ITEM
		do
			create new_cmd.make (tool)
			create new_menu_item.make_with_text (a_menu, m_New_project)
			new_menu_item.add_select_command (new_cmd, Void)

			create open_cmd.make (tool)
			create open_menu_item.make_with_text (a_menu, m_Open_project)
			open_menu_item.add_select_command (open_cmd, Void)

--			build_recent_project_menu_entries

			create quit_menu_item.make_with_text (a_menu, m_Exit_project)
			quit_menu_item.add_select_command (tool.exit_app_cmd, Void)
		end

	build_compile_menu is
			-- Build the compile menu.
		local
			melt_cmd: EB_MELT_PROJECT_CMD
			quick_melt_cmd: EB_QUICK_MELT_PROJECT_CMD
			freeze_cmd: EB_FREEZE_PROJECT_CMD
			finalize_cmd: EB_FINALIZE_PROJECT_CMD
			precompile_cmd: EB_PRECOMPILE_PROJECT_CMD
			c_compilation: EB_C_COMPILATION_CMD
			c_compile_menu: EV_MENU_ITEM
			i: EV_MENU_ITEM
			arg: EV_ARGUMENT1 [EB_PROJECT_TOOL]
--			sep: EV_SEPARATOR
		do
--			create special_cmd.make (Current)
--			create special_cmd_holder.make_plain (special_cmd)
-- This becomes a general purpose about box.

			create arg.make (tool)

			create melt_cmd.make (tool)
			create melt_menu_item.make_with_text (compile_menu, m_Update)
			melt_menu_item.add_select_command (melt_cmd, arg)

			create quick_melt_cmd.make (tool)
			create quick_melt_menu_item.make_with_text (compile_menu, m_Quick_update)
			quick_melt_menu_item.add_select_command (quick_melt_cmd, arg)

			create freeze_cmd.make (tool)
			create freeze_menu_item.make_with_text (compile_menu, m_Freeze)
			freeze_menu_item.add_select_command (freeze_cmd, arg)

			create finalize_cmd.make (tool)
			create finalize_menu_item.make_with_text (compile_menu, m_Finalize)
			finalize_menu_item.add_select_command (finalize_cmd, arg)

			create precompile_cmd.make (tool)
			create precompile_menu_item.make_with_text (compile_menu, m_Precompile)
			precompile_menu_item.add_select_command (precompile_cmd, arg)

--			create sep.make (compile_menu)

			create c_compile_menu.make_with_text (compile_menu, Interface_names.m_C_compilation)
			create c_compilation.make_workbench
			create i.make_with_text (c_compile_menu, Interface_names.m_Workbench_mode)
			i.add_select_command (c_compilation, Void)
			create c_compilation.make_final
			create i.make_with_text (c_compile_menu, Interface_names.m_Final_mode)
			i.add_select_command (c_compilation, Void)
		end
		
	build_special_menu is
			-- Build the special menu
		local
			open_case_cmd: EB_OPEN_CASE_CMD
			i: EV_MENU_ITEM
		do
			create open_case_cmd
			create i.make_with_text (special_menu, "Case tool...")
			i.add_select_command (open_case_cmd, Void)
			tool.build_special_menu (special_menu)
			debug_tool.build_special_menu (special_menu)
		end

	build_windows_menu (a_menu: EV_MENU_ITEM_HOLDER) is
		local
			tool_action: EB_TOOL_BROADCASTER

			create_cluster_cmd: EB_CREATE_CLUSTER_CMD
			cluster_menu_item: EV_MENU_ITEM

			create_class_cmd: EB_CREATE_CLASS_CMD
			class_menu_item: EV_MENU_ITEM

			create_feature_cmd: EB_CREATE_FEATURE_CMD
			feature_menu_item: EV_MENU_ITEM

			create_object_cmd: EB_CREATE_OBJECT_CMD
			object_menu_item: EV_MENU_ITEM

			show_system_tool: EB_SHOW_SYSTEM_TOOL
			show_dynamic_lib_tool: EB_SHOW_DYNAMIC_LIB_TOOL
			show_profiler: EB_SHOW_PROFILE_TOOL
			show_preferences: EB_SHOW_PREFERENCE_TOOL

			i: EV_MENU_ITEM
		do
			create tool_action

			create i.make_with_text (a_menu, m_Close_all_tools)
			i.add_select_command (tool_action, tool_action.Close_all)

			create i.make_with_text (a_menu, m_Raise_all_tools)
			i.add_select_command (tool_action, tool_action.Raise_all)

				-- Sub menus for open tools.
			create open_clusters_menu.make_with_text (a_menu, Interface_names.m_Explain_tools)
			create open_classes_menu.make_with_text (a_menu, Interface_names.m_Class_tools)
			create open_features_menu.make_with_text (a_menu, Interface_names.m_Feature_tools)
			create open_objects_menu.make_with_text (a_menu, Interface_names.m_Object_tools)

			create create_cluster_cmd.make (tool)
			create cluster_menu_item.make_with_text (open_clusters_menu, Interface_names.m_New_explain)
			cluster_menu_item.add_select_command (create_cluster_cmd, Void)

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

			create show_system_tool.make (Current)
			create i.make_with_text (a_menu, Interface_names.m_System)
			i.add_select_command (show_system_tool, Void)

			create show_dynamic_lib_tool.make (Current)
			create i.make_with_text (a_menu, Interface_names.m_New_dynamic_lib)
			i.add_select_command (show_dynamic_lib_tool, Void)

			create show_profiler
			create i.make_with_text (a_menu, Interface_names.m_Profile_tool)
			i.add_select_command (show_profiler, Void)

			create show_preferences.make
			create i.make_with_text (a_menu, Interface_names.m_Preferences)
			i.add_select_command (show_preferences, Void)
		end

	build_help_menu (a_menu: EV_MENU_ITEM_HOLDER) is
		local
			i: EV_MENU_ITEM
			s: STRING
			about_cmd: EB_ABOUT_COMMAND
		do
			s := clone(Interface_names.f_About)
			s.append(" ")
			s.append(version_number)
			create i.make_with_text (a_menu, s)
			create about_cmd.make (tool)
			i.add_select_command (about_cmd, Void) 
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
--			open_menu_entry: EV_MENU_ITEM
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
--					create open_menu_item.make_with_text (open_cmd, recent_project_menu)
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
--			create item.make_with_text (cmd, a_menu, a_tool)
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
