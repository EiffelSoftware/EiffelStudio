indexing
	description: "EiffelBench project tool."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PROJECT_TOOL

inherit
	EB_TOOL
		rename
--			edit_bar as project_toolbar,
--			progress_dialog as shared_progress_dialog,
			default_name as empty_tool_name
		redefine
			make, empty_tool_name
--			process_system, process_error,
--			process_object, process_breakable, process_class,
--			process_classi, compatible, process_feature,
--			process_class_syntax, process_ace_syntax,
--			process_call_stack,
--			update_graphical_resources
		end

	EB_PROJECT_TOOL_DATA

	EB_GENERAL_DATA

	EV_COMMAND

	EB_MULTIPLE_MANAGER

	EB_SHARED_INTERFACE_TOOLS
		undefine
			progress_dialog
		end

	SHARED_APPLICATION_EXECUTION

	SHARED_EIFFEL_PROJECT

	PROJECT_CONTEXT

creation
	make

feature {NONE} -- Initialization

	make (man: EB_TOOL_MANAGER) is
			-- Create a project application.
		local
			t_s: EB_TOOL_SUPERVISOR
		do
			precursor (man)
			create t_s.make (parent)
			set_tool_supervisor (t_s)
			create history.make
			init_list
		end

feature {EB_TOOL_MANAGER} -- Initialization

	build_interface is
			-- Build widgets.
		local
			hide_split_windows: BOOLEAN
--			display_feature_cmd: DISPLAY_ROUTINE_PORTION
--			display_object_cmd: DISPLAY_OBJECT_PORTION
			app_stopped_cmd: EB_APPLICATION_STOPPED_CMD

			v_split: EV_VERTICAL_SPLIT_AREA
		do
			set_title (empty_tool_name)
--			set_icon_name (empty_tool_name)

--			if Pixmaps.bm_Project_icon.is_valid then
--				set_icon_pixmap (Pixmaps.bm_Project_icon)
--			end
--			set_action ("<Unmap>,<Prop>", Current, popdown)
--			set_action ("<Configure>", Current, remapped)
--			set_action ("<Visible>", Current, remapped)
			create app_stopped_cmd
			Application.set_before_stopped_command (app_stopped_cmd)
			Application.set_after_stopped_command (app_stopped_cmd)

--			set_font_to_default
--			set_default_position

--			set_composite_attributes (Current)
--			feature_part.init_text_window
--			object_part.init_text_window

			create container.make (parent)

				-- toolbar creation
			create project_toolbar.make (container)
			container.set_child_expandable (project_toolbar, False)

			build_from_tree (container, default_tree)

				-- now that the debug tool is created,
				-- we can make the toolbar.
			build_top (project_toolbar)

			set_default_size

--			display_feature_cmd ?= display_feature_cmd_holder.associated_command
--			display_object_cmd ?= display_object_cmd_holder.associated_command
--
--			if hide_split_windows or else not Project_resources.feature_window.actual_value then
--				display_feature_cmd.hide
--			else
--				display_feature_cmd.show
--			end
--
--			if hide_split_windows or else not Project_resources.object_window.actual_value then
--				display_object_cmd.hide
--			else
--				display_object_cmd.show
--			end

				-- Make all the entry disabled.
			disable_menus

			debug_tool.display_welcome_info
		end
		
feature -- Resource Update

	register is
			-- Ask the resource manager to notify Current (i.e. to call `update') each
			-- time one of the resources he needs has changed.
			-- Is called by `make'.
		do
			register_to ("project_tool_x")
			register_to ("project_tool_y")
			register_to ("project_tool_width")
			register_to ("project_tool_height")
			register_to ("project_tool_bar")
		end

	update is
			-- Update Current with the registred resources.
		do
			if project_toolbar_visible then
				project_toolbar.show
			else
				project_toolbar.hide
			end
			if project_toolbar_menu_item /= Void then
				project_toolbar_menu_item.set_selected (project_toolbar_visible)
			end
			Eiffel_project.set_filter_path (general_filter_path)
			Eiffel_project.set_profile_path (general_profile_path)
			Eiffel_project.set_tmp_directory (general_tmp_path)
		end

	unregister is
			-- Ask the resource manager not to notify Current anymore
			-- when a resource has changed.
			-- Is called by `destroy'.
		do
			unregister_to ("project_tool_x")
			unregister_to ("project_tool_y")
			unregister_to ("project_tool_width")
			unregister_to ("project_tool_height")
			unregister_to ("project_tool_bar")
		end

--	update_integer_resource (old_res, new_res: EB_INTEGER_RESOURCE) is
--		local
--			pr: like resources
--		do
--			pr := resources
--			if new.actual_value >= 0 then
--				if old_res = pr.tool_x then
--					set_x (new.actual_value)
--				elseif old_res = pr.tool_y then
--					set_y (new.actual_value)
--				elseif old_res = pr.tool_width then
--					if new.actual_value /= 0 then
--						set_width (new.actual_value)
--					else
--						set_width (1)
--					end
--				elseif old_res = pr.tool_height then
--					if new.actual_value /= 0 then
--						if shown_portions = 1 then
--							set_height (new.actual_value)
--							hori_split_window.set_height (new.actual_value)
--						end
--					else
--						if shown_portions = 1 then
--							set_height (1)
--							hori_split_window.set_height (1)
--						end
--					end
--				elseif old_res = pr.debugger_object_height then
--					object_form.set_height (new.actual_value)
--				elseif old_res = pr.debugger_feature_height then
--					feature_form.set_height (new.actual_value)
--				elseif old_res = General_resources.tab_step then
--					set_tab_length (new.actual_value)
--					tool_supervisor.feature_tool_mgr.set_tab_length (tab_length)
--					tool_supervisor.class_tool_mgr.set_tab_length (tab_length)
--					tool_supervisor.object_tool_mgr.set_tab_length (tab_length)
--					tool_supervisor.cluster_tool_mgr.set_tab_length (tab_length)
--					if system_tool_is_valid then
--						System_tool.set_tab_length (tab_length)
--						System_tool.update_save_symbol
--					end
--					if feature_part /= Void and then feature_form.managed then
--						feature_part.set_tab_length (tab_length) 
--					end
--					if object_part /= Void and then object_form.managed then 
--						object_part.set_tab_length (tab_length) 
--					end
--				end
--			end
--		end

	update_graphical_resources is
			-- Synchronize clickable elements with text, if possible
			-- and update the graphical values in text window.
		do
--			initialize_text_window_resources
--			synchronize
--			if feature_part /= Void then
--				feature_part.update_graphical_resources
--			end
--			if object_part /= Void then
--				object_part.update_graphical_resources
--			end
		end
	
feature -- Access

	history: STONE_HISTORY
			-- History list for Current.

	popdown: EV_ARGUMENT1 [ANY] is
		once
			create Result.make (Void)
		end

	remapped: EV_ARGUMENT1 [ANY] is
		once
			create Result.make (Void)
		end

feature -- Window Settings

	set_default_size is
		local
			default_width, default_height: INTEGER
		do
--			if screen.width < 800 then
--				default_width := 400
--				default_height := 350
--				hide_split_windows := True
--			elseif screen.width = 800 then
--				default_width := screen.visible_width
--				default_height := screen.visible_height
--				set_maximized_state
--			else
				default_width := project_tool_width
				default_height := project_tool_height
--			end
			set_size (default_width, default_height)
		end
--| FIXME
--| Christophe, 21 oct 1999
--| to be rewritten when screen function are availible

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

	system_tool_is_hidden: BOOLEAN
			-- Is the system tool hidden?

	project_tool_is_hidden: BOOLEAN
			-- Is the project tool hidden?

	preference_tool_is_hidden: BOOLEAN
			-- Is the preference tool hidden?

	profile_tool_is_hidden: BOOLEAN
			-- Is the profile tool hidden?

	empty_tool_name: STRING is
			-- Default name of the tool.
			-- Used when no projects are opened yet.
		do
			Result := Interface_names.t_Project
		end

feature -- Window Holders

--	stop_points_hole_holder: HOLE_HOLDER
--	system_hole_holder: HOLE_HOLDER
--	class_hole_holder: HOLE_HOLDER
--	routine_hole_holder: HOLE_HOLDER
--	dynamic_lib_hole_holder: HOLE_HOLDER
--	object_hole_holder: HOLE_HOLDER
--	cluster_hole_holder: HOLE_HOLDER
--| FIXME
--| Christophe, 21 oct 1999 
--| Drag-and-Drop not implemented yet.

feature -- Pulldown Menus

	active_menus (erase: BOOLEAN) is
			-- Enable all the menus and if `erase' clean
			-- the content of the Project tool.
		do
--			manager.active_menus (erase)
		end

	disable_menus is
			-- Disable all the menus.
		do
--			manager.disable_menus
		end

feature -- Window Forms

	global_verti_split_window: EV_HORIZONTAL_SPLIT_AREA
			-- Global Vertical Split window

	hori_split_window: EV_VERTICAL_SPLIT_AREA
			-- Horizontal Split window

	top_verti_split_window: EV_HORIZONTAL_SPLIT_AREA
			-- Top vertical Split window

	bottom_verti_split_window: EV_HORIZONTAL_SPLIT_AREA
			-- Bottom vertical split window

feature -- Progress Dialog

	progress_dialog: DEGREE_OUTPUT
			-- Progress dialog associated with the project.
			-- It can be a graphical one or a text mode one.

	set_progress_dialog (new_progress_dialog: DEGREE_OUTPUT) is
			-- Set `progress_dialog' to `new_progress_dialog'.
			-- Set also `Eiffel_project' progress_dialog which needs to know
			-- that we changed the kind of `progress_dialog'.
		do
			progress_dialog := new_progress_dialog
			Eiffel_project.set_degree_output (progress_dialog)

				-- If `process_dialog' is a graphical dialog then
				-- Its parent has been specified.
		end

feature -- Execution Implementation

	execute (arg: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
			-- Resize xterm window when drawing area is resized
		do
--			if arg = remapped then
--				if project_tool_is_hidden then
--						-- The project tool is being deiconified.
--					project_tool_is_hidden := False
--					tool_supervisor.show_all_editors
--					if profile_tool_is_hidden then
--						profile_tool_is_hidden := False
--						Profile_tool.show
--					end
--					if preference_tool_is_hidden then
--						preference_tool_is_hidden := False
--						Preference_tool.show
--					end
--					if is_system_tool_created then
--						if system_tool_is_hidden then
--							system_tool.show
--							system_tool_is_hidden := False
--						elseif system_tool.in_use then
--							system_tool.show
--						end
--					end
--					raise
--				else
--						-- The project tool is being raised, moved or resized.
--						-- Raise popups with an exclusive grab.
--					raise_grabbed_popup
--				end
--			elseif arg = popdown then
--				project_tool_is_hidden := True
--				tool_supervisor.hide_all_editors
--				if
--					system_tool /= Void and then
--					system_tool.destroyed and then
--					system_tool.shown
--				then
--					system_tool.hide
--					system_tool.close_windows
--					system_tool_is_hidden := True
--				end
--				if Preference_tool /= Void and then Preference_tool.shown then
--					Preference_tool.hide
--					preference_tool_is_hidden := True
--				end
--				if Profile_tool /= Void and then Profile_tool.shown then
--					Profile_tool.hide
--					profile_tool_is_hidden := True
--				end
--			end
		end

feature -- Update

--	synchronize_routine_tool_to_default is
--			-- Synchronize the feature tool to the debug format.
--		do
--			if feature_part /= Void and then feature_form.managed then	
--				feature_part.set_debug_format
--			end
--		end

	close_windows is
			-- Close associated windows.
		do
		end

--	clear_object_tool is
--			-- Clear the contents of the object tool if shown.
--		do
--			if object_part /= Void and then object_form.managed then	
--				object_part.reset
--			end
--		end

	add_feature_entry (f_t: EB_FEATURE_TOOL) is
		do
--			add_tool_to_menu (f_t, menus @ open_features_menu)
			select_tool.add_tool_entry (f_t)
		end

	change_feature_entry (f_t: EB_FEATURE_TOOL) is
		do
--			change_tool_in_menu (f_t, menus @ open_features_menu)
			select_tool.change_tool_entry (f_t)
		end

	remove_feature_entry (f_t: EB_FEATURE_TOOL) is
		do
--			remove_tool_from_menu (f_t, menus @ open_features_menu)
			select_tool.remove_tool_entry (f_t)
		end

	add_class_entry (c_t: EB_CLASS_TOOL) is
		do
--			add_tool_to_menu (c_t, menus @ open_classes_menu)
			select_tool.add_tool_entry(c_t)
		end

	change_class_entry (c_t: EB_CLASS_TOOL) is
		do
--			change_tool_in_menu (c_t, menus @ open_classes_menu)
			select_tool.change_tool_entry(c_t)
		end

	remove_class_entry (c_t: EB_CLASS_TOOL) is
		do
--			remove_tool_from_menu (c_t, menus @ open_classes_menu)
			select_tool.remove_tool_entry(c_t)
		end

	add_object_entry (o_t: EB_OBJECT_TOOL) is
		do
--			add_tool_to_menu (o_t, menus @ open_objects_menu)
			select_tool.add_tool_entry(o_t)
		end

	change_object_entry (o_t: EB_OBJECT_TOOL) is
		do
--			change_tool_in_menu (o_t, menus @ open_objects_menu)
			select_tool.change_tool_entry(o_t)
		end

	remove_object_entry (o_t: EB_OBJECT_TOOL) is
		do
--			remove_tool_from_menu (o_t, menus @ open_objects_menu)
			select_tool.remove_tool_entry(o_t)
		end

	add_cluster_entry (cl_t: EB_CLUSTER_TOOL) is
		do
--			add_tool_to_menu (cl_t, menus @ open_cluster_menu)
		end

	change_cluster_entry (cl_t: EB_CLUSTER_TOOL) is
		do
--			change_tool_in_menu (cl_t, menus @ open_cluster_menu)
		end

	remove_cluster_entry (cl_t: EB_CLUSTER_TOOL) is
		do
--			remove_tool_from_menu (cl_t, menus @ open_cluster_menu)
		end

feature -- Graphical Interface

	build_top (a_toolbar: EV_BOX) is
			-- Build top bar
		local
--			tool_action: TOOLS_MANAGEMENT
			cluster_cmd: EB_CREATE_CLUSTER_CMD
			system_cmd: EB_SHOW_SYSTEM_TOOL
			class_cmd: EB_CREATE_CLASS_CMD
			feature_cmd: EB_CREATE_FEATURE_CMD
			dynamic_lib_cmd: EB_SHOW_DYNAMIC_LIB_TOOL
			shell_cmd: EB_OPEN_SHELL_CMD
			object_cmd: EB_CREATE_OBJECT_CMD
			clear_bp_cmd: EB_CLEAR_STOP_POINTS_CMD
			stop_points_cmd: EB_DEBUG_STOPIN_HOLE_CMD

--			display_feature_cmd: DISPLAY_ROUTINE_PORTION
--			display_object_cmd: DISPLAY_OBJECT_PORTION
			melt_cmd: EB_MELT_PROJECT_CMD
			quick_melt_cmd: EB_QUICK_MELT_PROJECT_CMD

--			do_nothing_cmd: DO_NOTHING_CMD

			tb: EV_TOOL_BAR
			b: EV_TOOL_BAR_BUTTON
			sep: EV_TOOL_BAR_SEPARATOR
		do
--			build_file_menu

			-- Help Menu
--			create version_button.make (Version_number, help_menu)

--			create about_tool.make ("About_Dialog", screen)
--			create about_cmd.make (about_tool)
--			create about_menu_entry.make_default (about_cmd, help_menu)

				-- Close all command

				-- Regular menu entries.
			create tb.make (a_toolbar)

			create cluster_cmd.make (Current)
			create b.make (tb)
			b.set_pixmap (Pixmaps.bm_Explain)
--			b.add_click_command (explain_cmd, Void)

			create system_cmd.make (parent_window)
			create b.make (tb)
			b.set_pixmap (Pixmaps.bm_System)
			b.add_click_command (system_cmd, Void)
			
			create class_cmd.make (Current)
			create b.make (tb)
			b.set_pixmap (Pixmaps.bm_Class)
			b.add_click_command (class_cmd, Void)

			create feature_cmd.make (Current)
			create b.make (tb)
			b.set_pixmap (Pixmaps.bm_Routine)
			b.add_click_command (feature_cmd, Void)

			create dynamic_lib_cmd.make (parent_window)
			create b.make (tb)
			b.set_pixmap (Pixmaps.bm_Dynamic_lib)
			b.add_click_command (dynamic_lib_cmd, Void)

			create shell_cmd.make (Current)
			create b.make (tb)
			b.set_pixmap (Pixmaps.bm_Shell)
			b.add_click_command (shell_cmd, Void)
--			shell_button.add_third_button_action

			create object_cmd.make (Current)
			create b.make (tb)
			b.set_pixmap (Pixmaps.bm_Object)
			b.add_click_command (object_cmd, Void)

			create clear_bp_cmd.make (debug_tool)
			create b.make (tb)
			b.set_pixmap (Pixmaps.bm_Clear_breakpoints)
--			clear_bp_button.set_action ("c<Btn1Down>", 
--						clear_bp_cmd, clear_bp_cmd.clear_it_action)
			b.add_click_command (clear_bp_cmd, Void)

			create stop_points_cmd
			create b.make (tb)
			b.set_pixmap (Pixmaps.bm_Setstop)
			b.add_click_command (stop_points_cmd, Void)

--			create display_feature_cmd.make (Current)
--			create display_feature_button.make (display_feature_cmd, project_toolbar)
--			create display_feature_cmd_holder.make (display_feature_cmd, display_feature_button, display_feature_menu_entry)
--			display_feature_cmd.set_holder (display_feature_cmd_holder)
--
--			create display_object_cmd.make (Current)
--			create display_object_button.make (display_object_cmd, project_toolbar)
--			create display_object_cmd_holder.make (display_object_cmd, display_object_button, display_object_menu_entry)
--			display_object_cmd.set_holder (display_object_cmd_holder)

			create sep.make (tb)

			create tb.make_with_size (a_toolbar, 58, 22)
			a_toolbar.set_child_expandable (tb, False)

			create melt_cmd.make (Current)
			create b.make (tb)
			b.set_pixmap (Pixmaps.bm_Update)
--			update_button.set_action ("c<Btn1Down>", melt_cmd, update_cmd.generate_code_only)
			b.add_click_command (melt_cmd, Void)

			create quick_melt_cmd.make (Current)
			create b.make (tb)
			b.set_pixmap (Pixmaps.bm_Quick_update)
--			quick_update_button.set_action ("c<Btn1Down>", quick_update_cmd, quick_update_cmd.generate_code_only)
			b.add_click_command (quick_melt_cmd, Void)

--			create do_nothing_cmd
--			project_toolbar.set_action ("c<Btn1Down>", do_nothing_cmd, Void)
		end


	save_environment is
			-- Save the current environment
			--| ie, save windows positions, save breakpoints
		require
--			recent_project_list_exists: recent_project_list /= Void
--			recent_project_list_compare_objects: recent_project_list.object_comparison
		local
			environment_variable: EXECUTION_ENVIRONMENT
			last_opened_projects: STRING
			project_file_name: STRING
			i: INTEGER
		do
				-- We save the environment variable only once and when the system
				-- has been compiled, otherwise we do not change anything.
			if
				not saving_done
				and then Eiffel_project.system /= Void
				and then Eiffel_project.system.name /= Void
			then
--				saving_done := True
--				create last_opened_projects.make (512)
--				project_file_name := clone (project_directory_name)
--				if project_file_name.item (project_file_name.count) /= Directory_separator then
--					project_file_name.append_character (Directory_separator)
--				end
--				project_file_name.append (clone (eiffel_project.system.name))
--				project_file_name.append (clone (project_extension))
--	
--				if not recent_project_list.has (project_file_name) then
--					last_opened_projects.append (project_file_name)
--					last_opened_projects.append (";")
--				else
--					recent_project_list.prune (project_file_name)
--					recent_project_list.put_front (project_file_name)
--				end
	
--				from
--					recent_project_list.start
--				until
--					recent_project_list.after or else i >= 10
--				loop
--					last_opened_projects.append (recent_project_list.item)
--					last_opened_projects.append (";")
--					recent_project_list.forth
--					i := i + 1
--				end
--				create environment_variable
--				environment_variable.put (last_opened_projects, Bench_Recent_Files)
			end
		end

	saving_done: BOOLEAN
			-- Has the environment variable "BENCH_RECENT_FILES" been updated?

	recent_project_list: LINKED_LIST [STRING]
			-- Save the list of recent opened projects during the execution
			-- Purpose: make it easier to save the data at the end.

feature -- Commands

	build_special_menu (a_menu: EV_MENU_ITEM_HOLDER) is
		require
			a_menu_exits: a_menu /= Void
		local
			cmd: EV_ROUTINE_COMMAND
		do
			create project_toolbar_menu_item.make_with_text (a_menu, Interface_names.n_Command_bar_name)
			create cmd.make (~edit_bar_menu_update)
			project_toolbar_menu_item.add_select_command (cmd, Void)
			project_toolbar_menu_item.add_unselect_command (cmd, Void)
		end

feature -- Hole access

	stone_type: INTEGER is
			-- A Project tool does not have a corresponding stone.
		do
		end
 
	compatible (dropped_stone: STONE): BOOLEAN is
			-- Is current hole compatible with `dropped_stone'?
--		local
--			t: INTEGER
		do
--			t := dropped_stone.stone_type
--			Result := t = Class_type or else
--				t = feature_type or else
--				t = cluster_type or else
--				t = Object_type or else
--				t = Breakable_type or else
--				t = Call_stack_type or else
--				t = System_type
		end
 
feature -- Update
 
	process_class_syntax (a_stone: CL_SYNTAX_STONE) is
			-- Process class syntax stone.
		local
			new_tool: EB_CLASS_TOOL
		do
			new_tool := tool_supervisor.new_class_tool
			new_tool.raise
			new_tool.process_class_syntax (a_stone)
		end

	process_ace_syntax (a_stone: ACE_SYNTAX_STONE) is
			-- Process ace syntax stone.
		do
--			System_tool.display
--			System_tool.process_ace_syntax (a_stone)
		end

	process_class (a_stone: CLASS_STONE) is
			-- Process dropped stone `a_stone'.
		local
			new_tool: EB_CLASS_TOOL
		do
			new_tool := tool_supervisor.new_class_tool
			new_tool.raise
			new_tool.process_class (a_stone)
		end
 
	process_feature (a_stone: FEATURE_STONE) is
			-- Process dropped stone `a_stone'.
		local
			new_tool: EB_FEATURE_TOOL
		do
			new_tool := tool_supervisor.new_feature_tool
			new_tool.raise
			new_tool.process_feature (a_stone)
		end
 
	process_breakable (a_stone: BREAKABLE_STONE) is
			-- Process dropped stone `a_stone'.
		local
--			stop_points_button: EB_BUTTON_HOLE		
		do
--			stop_points_button := stop_points_hole_holder.associated_button
--			stop_points_button.associated_command.process_breakable (a_stone)
		end
 
	process_object (a_stone: OBJECT_STONE) is
			-- Process dropped stone `a_stone'.
		local
--			new_tool: EB_OBJECT_TOOL
		do
--			new_tool := tool_supervisor.new_object_tool
--			new_tool.display
--			new_tool.process_object (a_stone)
		end
 
	process_error (a_stone: ERROR_STONE) is
			-- Process dropped stone `a_stone'.
		local
--			new_tool: EB_EXPLAIN_TOOL
		do
--			new_tool := tool_supervisor.new_explain_tool
--			new_tool.raise
--			new_tool.process_any (a_stone)
		end
 
	process_system (a_stone: SYSTEM_STONE) is
			-- Process dropped stone `a_stone'.
		do
--			System_tool.process_system (a_stone)
--			System_tool.raise
		end

	process_call_stack (dropped: CALL_STACK_STONE) is
			-- Accept all stone types
		do
			check
				is_running: Application.is_running and then
					Application.is_stopped
			end
--			save_current_cursor_position
			if Application.current_execution_stack_number /= 
				dropped.level_number 		
			then
				Application.set_current_execution_stack (dropped.level_number)
--				show_current_stoppoint
--				show_current_object
--				display_exception_stack
			end
		end

	saved_cursor: CURSOR
			-- Saved cursor position for displaying the stack

feature {DISPLAY_ROUTINE_PORTION} -- Implementation

--	hide_feature_portion is
--			-- Hide the feature potion and hide the menu entries
--			-- regarding the feature tool.
--		do
--			shown_portions := shown_portions - 1
--
--			feature_form.unmanage
--			feature_part.close_windows
--
--			menus.item (edit_feature_menu).button.set_insensitive
--			menus.item (special_feature_menu).button.set_insensitive
--			menus.item (format_feature_menu).button.set_insensitive
--		end

--	show_feature_portion is
--			-- Show the feature portion and the menu entries
--			-- regarding the feature tool.
--		local
--			mp: MOUSE_PTR
--		do
--			create mp.set_watch_cursor
--			shown_portions := shown_portions + 1
--			feature_form.manage
--
--			if shown_portions > 2 then
--					-- We need to manage again the object form, mostly when the feature form can
--					-- hide the object form after its re-appearance on the screen.
--					-- This problems occurs only with horizontal splitter in the case of Motif 1.2.
--				object_form.manage
--			end
--
--			menus.item (edit_feature_menu).button.set_sensitive
--			menus.item (special_feature_menu).button.set_sensitive
--			menus.item (format_feature_menu).button.set_sensitive
--
--			show_current_stoppoint
--			mp.restore
--		end


feature {NONE} -- Implementation

	container: EV_VERTICAL_BOX

	project_toolbar: EV_HORIZONTAL_BOX

	hide_class_portion is
			-- Hide the class portion and hide the menu entries
			-- regarding the feature tool.
		do
		end

	show_class_portion is
			-- Show the class portion and the menu entries
			-- regarding the feature tool.
		local
		do
		end

feature {DISPLAY_OBJECT_PORTION} -- Implementation

--	hide_object_portion is
--			-- Hide the object portion and the menu entries
--			-- regarding the feature tool.
--		do
--			shown_portions := shown_portions - 1
--
--			object_form.unmanage
--			object_part.close_windows
--
--			menus.item (edit_object_menu).button.set_insensitive
--			menus.item (special_object_menu).button.set_insensitive
--			menus.item (format_object_menu).button.set_insensitive
--		end

--	show_object_portion is
--			-- Show the object portion and the menu entries
--			-- regarding the feature tool.
--		local
--			mp: MOUSE_PTR
--		do
--			create mp.set_watch_cursor
--			shown_portions := shown_portions + 1
--
--			menus.item (edit_object_menu).button.set_sensitive
--			menus.item (special_object_menu).button.set_sensitive
--			menus.item (format_object_menu).button.set_sensitive
--
--			object_form.manage
--
--			show_current_object
--			mp.restore
--		end

feature -- to be placed where it belongs

	edit_bar_menu_update (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
		require
			menu_item_exists: project_toolbar_menu_item /= Void
		do
			if project_toolbar_menu_item.is_selected then
				project_toolbar.show
			else
				project_toolbar.hide
			end
		end

	project_toolbar_menu_item: EV_CHECK_MENU_ITEM

	update_compile_access (b: BOOLEAN) is
			-- update compile menu (if it exists)
		local
			m: EB_PROJECT_WINDOW
		do
			m ?= manager
			m.update_compile_menu (b)
		end

feature -- Tool management features

	associated_window: EV_WINDOW is
		do
			Result := parent_window
		end

	init_debug_tool is
		local
			dt: EB_DEBUG_TOOL
		do
			create dt.make (Current)
			set_debug_tool (dt)
		end

	init_select_tool is
		local
			dt: EB_SELECT_TOOL
		do
			create dt.make (Current)
			set_select_tool (dt)
		end

end -- class EB_PROJECT_TOOL

