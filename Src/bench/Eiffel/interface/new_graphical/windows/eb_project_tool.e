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
--			Project_resources as resources,
--			progress_dialog as shared_progress_dialog

			empty_tool_name as tool_name
				-- Provisoire
		redefine
			make, tool_name, icon_id
--			tool_name, process_system, process_error,
--			process_object, process_breakable, process_class,
--			process_classi, compatible, process_feature,
--			process_class_syntax, process_ace_syntax, display,
--			process_call_stack,
--			update_graphical_resources, help_index, icon_id
		end

	EB_PROJECT_TOOL_DATA

	EV_COMMAND

	EB_TOOL_MANAGER

--	WINDOW_ATTRIBUTES

	EB_SHARED_INTERFACE_TOOLS
--		undefine
--			progress_dialog
--		end

	SHARED_APPLICATION_EXECUTION

	SHARED_EIFFEL_PROJECT

	PROJECT_CONTEXT

	EB_RESOURCE_USER
		redefine
			dispatch_modified_resource
		end

--	WIDGET_ROUTINES

creation
	make

feature -- Initialization

	make (man: EB_TOOL_MANAGER) is
			-- Create a project application.
		local
			app_stopped_cmd: APPLICATION_STOPPED_CMD
			t_s: EB_TOOL_SUPERVISOR
		do
			General_resources.add_user (Current)
			Project_resources.add_user (Current)
			create t_s.make (parent)
			set_tool_supervisor (t_s)
			create history.make
			precursor (man)
			set_title (Interface_names.t_Project)
			set_icon_name (tool_name)
--			if Pixmaps.bm_Project_icon.is_valid then
--				set_icon_pixmap (Pixmaps.bm_Project_icon)
--			end
--			set_action ("<Unmap>,<Prop>", Current, popdown)
--			set_action ("<Configure>", Current, remapped)
--			set_action ("<Visible>", Current, remapped)
			create app_stopped_cmd
			Application.set_before_stopped_command (app_stopped_cmd)
			Application.set_after_stopped_command (app_stopped_cmd)

--			add_close_command (quit_cmd_holder.associated_command)
--			set_font_to_default
--			set_default_position

--			set_composite_attributes (Current)
--			feature_part.init_text_window
--			object_part.init_text_window

--			global_verti_split_window.update_split
--			hori_split_window.update_split
--			top_verti_split_window.update_split

			debug_part.display_welcome_info
		end

feature -- Resource Update

	dispatch_modified_resource (mod_res: EB_MODIFIED_RESOURCE) is
		local
			old_b, new_b: EB_BOOLEAN_RESOURCE
			old_i, new_i: EB_INTEGER_RESOURCE
			old_s, new_s: EB_STRING_RESOURCE
		do
			old_b ?= mod_res.old_resource
			if old_b /= Void then
				new_b ?= mod_res.new_resource
				update_boolean_resource (old_b, new_b)
			else
				old_i ?= mod_res.old_resource
				if old_i /= Void then
					new_i ?= mod_res.new_resource
					update_integer_resource (old_i, new_i)
				else
					old_s ?= mod_res.old_resource
					if old_s /= Void then
						new_s ?= mod_res.new_resource
						update_string_resource (old_s, new_s)
					end
				end
			end
		end

	update_boolean_resource (old_res, new_res: EB_BOOLEAN_RESOURCE) is
		local
--			rout_cli_cmd: SHOW_ROUTCLIENTS
--			display_routine_cmd: DISPLAY_ROUTINE_PORTION
--			display_object_cmd: DISPLAY_OBJECT_PORTION
--			stop_cmd: SHOW_BREAKPOINTS
--			pr: like Project_resources
--			progress_output: DEGREE_OUTPUT
		do
--			pr := resources
--			if old_res = pr.command_bar then
--				if new_res.actual_value then
--					project_toolbar.show
--				else
--					project_toolbar.hide
--				end
--			elseif old_res = pr.format_bar then
--				if new_res.actual_value then
--					format_bar.show
--				else
--					format_bar.hide
--				end
--			elseif old_res = pr.selector_window then
--				if new_res.actual_value then
--					selector_part.show_selector
--				else
--					selector_part.hide_selector
--				end
--			elseif old_res = pr.feature_window then
--				display_routine_cmd ?= display_feature_cmd_holder.associated_command
--				if new_res.actual_value then
--					display_routine_cmd.show
--				else
--					display_routine_cmd.hide
--				end
--			elseif old_res = pr.object_window then
--				display_object_cmd ?= display_object_cmd_holder.associated_command
--				if new_res.actual_value then
--					display_object_cmd.show
--				else
--					display_object_cmd.hide
--				end
--			end
		end

	update_string_resource (old_res, new_res: EB_STRING_RESOURCE) is
		local
--			gr: like General_resources
		do
--			gr := General_resources
--			if old_res = gr.filter_path then
--				Eiffel_project.set_filter_path (new_res.value)
--			elseif old_res = gr.profile_path then
--				Eiffel_project.set_profile_path (new_res.value)
--			elseif old_res = gr.tmp_path then
--				Eiffel_project.set_tmp_directory (new_res.value)
--			end
		end

	update_integer_resource (old_res, new_res: EB_INTEGER_RESOURCE) is
		local
--			pr: like resources
		do
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
--					tool_supervisor.routine_win_mgr.set_tab_length (tab_length)
--					tool_supervisor.class_win_mgr.set_tab_length (tab_length)
--					tool_supervisor.object_win_mgr.set_tab_length (tab_length)
--					tool_supervisor.explain_win_mgr.set_tab_length (tab_length)
--					if system_tool /= void and then not system_tool.destroyed then
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
		end

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

	icon_id: INTEGER is
			-- Icon id of Current window (for windows)
		do
			Result := Interface_names.i_Project_id
		end

feature -- Window Settings

	set_default_size is
		do
		end

	set_initialized is
			-- Set `initialized' to true.
		do
			initialized := true
		ensure
			initialized = true
		end

	display is
			-- Display Current on the screen
		do
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

feature -- Modifiable menus

	melt_menu_entry: EB_MENU_ENTRY
			-- Melt menu entry

	quick_melt_menu_entry: EB_MENU_ENTRY
			-- Quick-Melt menu entry

	freeze_menu_entry: EB_MENU_ENTRY
			-- Freeze menu entry

	finalize_menu_entry: EB_MENU_ENTRY
			-- Finalize menu entry

	precompile_menu_entry: EB_MENU_ENTRY
			-- Precompile menu entry

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

feature -- Execution Implementation

	execute (arg: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
			-- Resize xterm window when drawing area is resized
		do
--			if arg = remapped then
--				if is_project_tool_hidden then
--						-- The project tool is being deiconified.
--					is_project_tool_hidden := False
--					tool_supervisor.show_all_editors
--					if is_profile_tool_hidden then
--						is_profile_tool_hidden := False
--						Profile_tool.show
--					end
--					if is_preference_tool_hidden then
--						is_preference_tool_hidden := False
--						Preference_tool.show
--					end
--					if is_system_tool_created then
--						if is_system_tool_hidden then
--							system_tool.show
--							is_system_tool_hidden := False
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
--				is_project_tool_hidden := True
--				tool_supervisor.hide_all_editors
--				if
--					system_tool /= Void and then
--					system_tool.destroyed and then
--					system_tool.shown
--				then
--					system_tool.hide
--					system_tool.close_windows
--					is_system_tool_hidden := True
--				end
--				if Preference_tool /= Void and then Preference_tool.shown then
--					Preference_tool.hide
--					is_preference_tool_hidden := True
--				end
--				if Profile_tool /= Void and then Profile_tool.shown then
--					Profile_tool.hide
--					is_profile_tool_hidden := True
--				end
--			end
		end

feature -- Update

--	synchronize_routine_tool_to_default is
--			-- Synchronize the routine tool to the debug format.
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
--			add_tool_to_menu (f_t, menus @ open_routines_menu)
			selector_part.add_tool_entry (f_t)
		end

	change_feature_entry (f_t: EB_FEATURE_TOOL) is
		do
--			change_tool_in_menu (f_t, menus @ open_routines_menu)
			selector_part.change_tool_entry (f_t)
		end

	remove_feature_entry (f_t: EB_FEATURE_TOOL) is
		do
--			remove_tool_from_menu (f_t, menus @ open_routines_menu)
			selector_part.remove_tool_entry (f_t)
		end

	add_class_entry (c_t: EB_CLASS_TOOL) is
		do
--			add_tool_to_menu (c_t, menus @ open_classes_menu)
			selector_part.add_tool_entry(c_t)
		end

	change_class_entry (c_t: EB_CLASS_TOOL) is
		do
--			change_tool_in_menu (c_t, menus @ open_classes_menu)
			selector_part.change_tool_entry(c_t)
		end

	remove_class_entry (c_t: EB_CLASS_TOOL) is
		do
--			remove_tool_from_menu (c_t, menus @ open_classes_menu)
			selector_part.remove_tool_entry(c_t)
		end

	add_object_entry (o_t: EB_OBJECT_TOOL) is
		do
--			add_tool_to_menu (o_t, menus @ open_objects_menu)
			selector_part.add_tool_entry(o_t)
		end

	change_object_entry (o_t: EB_OBJECT_TOOL) is
		do
--			change_tool_in_menu (o_t, menus @ open_objects_menu)
			selector_part.change_tool_entry(o_t)
		end

	remove_object_entry (o_t: EB_OBJECT_TOOL) is
		do
--			remove_tool_from_menu (o_t, menus @ open_objects_menu)
			selector_part.remove_tool_entry(o_t)
		end

	add_explain_entry (e_t: EB_EXPLAIN_TOOL) is
		do
--			add_tool_to_menu (e_t, menus @ open_explain_menu)
		end

	change_explain_entry (e_t: EB_EXPLAIN_TOOL) is
		do
--			change_tool_in_menu (e_t, menus @ open_explain_menu)
		end

	remove_explain_entry (e_t: EB_EXPLAIN_TOOL) is
		do
--			remove_tool_from_menu (e_t, menus @ open_explain_menu)
		end

feature -- Graphical Interface

	build_interface is
			-- Build widget.
		local
			default_width, default_height: INTEGER
			hide_split_windows: BOOLEAN
			display_routine_cmd: DISPLAY_ROUTINE_PORTION
			display_object_cmd: DISPLAY_OBJECT_PORTION

			v_split: EV_VERTICAL_SPLIT_AREA
		do
			shown_portions := 1

--			if screen.width < 800 then
--				default_width := 400
--				default_height := 350
--				hide_split_windows := True
--			elseif screen.width = 800 then
--				default_width := screen.visible_width
--				default_height := screen.visible_height
--				set_maximized_state
--			else
--				default_width := Project_resources.tool_width.actual_value
--				default_height := Project_resources.tool_height.actual_value
--			end
			set_size (default_width, default_height)

			create container.make (parent)

			create global_verti_split_window.make (container)

			tool_parent := global_verti_split_window
			create selector_part.make (Current)

  			create hori_split_window.make (global_verti_split_window)

			create top_verti_split_window.make (hori_split_window)

			tool_parent := hori_split_window
			create feature_part.make (Current)

			tool_parent := top_verti_split_window
			create debug_part.make (Current)
			set_debug_tool (debug_part)
			create object_part.make (Current)

--			create_toolbar (container)
--			build_menu
--			build_text_windows (project_form)
--			build_top
--			build_compile_menu
--			build_format_bar
--			build_toolbar_menu

-- 			create feature_part.form_create (feature_form, 
 --					menus @ special_feature_menu, 
 --					menus @ edit_feature_menu, 
 --					menus @ format_feature_menu,
 --					menus @ special_feature_menu)
--

--			create object_part.form_create ( object_form, 
--					menus @ special_object_menu, 
--					menus @ edit_object_menu, 
--					menus @ format_object_menu,
--					menus @ special_object_menu)
--
--			if Project_resources.command_bar.actual_value = False then
--				project_toolbar.remove
--			end
--			if Project_resources.format_bar.actual_value = False then
--				format_bar.remove
--			end

--			display_routine_cmd ?= display_feature_cmd_holder.associated_command
--			display_object_cmd ?= display_object_cmd_holder.associated_command
--
--			if hide_split_windows or else not Project_resources.feature_window.actual_value then
--				display_routine_cmd.hide
--			else
--				display_routine_cmd.show
--			end
--
--			if hide_split_windows or else not Project_resources.object_window.actual_value then
--				display_object_cmd.hide
--			else
--				display_object_cmd.show
--			end

				-- Make all the entry disabled.
			disable_menus
		end
		
	build_top is
			-- Build top bar
		local
--			tool_action: TOOLS_MANAGEMENT
--			explain_cmd: EXPLAIN_HOLE
--			explain_button: EB_BUTTON_HOLE
--			system_cmd: SYSTEM_HOLE
--			system_button: EB_BUTTON_HOLE
--			class_cmd: CLASS_HOLE
--			class_button: EB_BUTTON_HOLE
--			routine_cmd: ROUTINE_HOLE
--			routine_button: EB_BUTTON_HOLE
--			shell_cmd: SHELL_COMMAND
--			shell_button: EB_BUTTON_HOLE
--			object_cmd: OBJECT_HOLE
--			object_button: EB_BUTTON_HOLE
--			clear_bp_cmd: DEBUG_CLEAR_STOP_POINTS_HOLE
--			clear_bp_button: EB_BUTTON_HOLE
--			stop_points_cmd: DEBUG_STOPIN_HOLE
--			stop_points_button: EB_BUTTON_HOLE
--			stop_points_status_cmd: STOPPOINTS_STATUS

--			dynamic_lib_cmd: DYNAMIC_LIB_HOLE
--			dynamic_lib_button: EB_BUTTON_HOLE

--			sep: SEPARATOR
--			sep1, sep2: THREE_D_SEPARATOR
--			display_feature_cmd: DISPLAY_ROUTINE_PORTION
--			display_feature_button: EB_BUTTON
--			display_object_cmd: DISPLAY_OBJECT_PORTION
--			display_object_button: EB_BUTTON
--			update_cmd: UPDATE_PROJECT
--			update_button: EB_BUTTON
--			quick_update_cmd: UPDATE_PROJECT
--			quick_update_button: EB_BUTTON
--  			version_button: PUSH_B

--			do_nothing_cmd: DO_NOTHING_CMD
		do
--			build_file_menu

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

				-- Regular menu entries.
--			create explain_cmd.make (Current)
--			create explain_button.make (explain_cmd, project_toolbar)
--			create explain_hole_holder.make (explain_cmd, explain_button, explain_menu_entry)

--			create system_cmd.make (Current)
--			create system_button.make (system_cmd, project_toolbar)
--			create system_hole_holder.make (system_cmd, system_button, system_menu_entry)
			
--			create class_cmd.make (Current)
--			create class_button.make (class_cmd, project_toolbar)
--			create class_hole_holder.make (class_cmd, class_button, class_menu_entry)

--			create dynamic_lib_cmd.make (Current)
--			create dynamic_lib_button.make (dynamic_lib_cmd, project_toolbar)
--			create dynamic_lib_hole_holder.make (dynamic_lib_cmd, dynamic_lib_button, dynamic_lib_menu_entry)

--			create routine_cmd.make (Current)
--			create routine_button.make (routine_cmd, project_toolbar)
--			create routine_hole_holder.make (routine_cmd, routine_button, routine_menu_entry)

--			create shell_cmd.make (Current)
--			create shell_button.make (shell_cmd, project_toolbar)
--			shell_button.add_third_button_action

--			create object_cmd.make (Current)
--			create object_button.make (object_cmd, project_toolbar)
--			create object_hole_holder.make (object_cmd, object_button, object_menu_entry)

--			create stop_points_cmd.make (Current)
--			create stop_points_button.make (stop_points_cmd, project_toolbar)
--			create stop_points_hole_holder.make (stop_points_cmd, stop_points_button, stop_points_menu_entry)

--			create clear_bp_cmd.make (Current)
--			create clear_bp_button.make (clear_bp_cmd, project_toolbar)
--			clear_bp_button.set_action ("c<Btn1Down>", 
--						clear_bp_cmd, clear_bp_cmd.clear_it_action)
--			create clear_bp_cmd_holder.make (clear_bp_cmd, clear_bp_button, clear_bp_menu_entry)

--			create stop_points_status_cmd.make_enabled
--			create stop_points_status_cmd.make_disabled

--			create display_feature_cmd.make (Current)
--			create display_feature_button.make (display_feature_cmd, project_toolbar)
--			create display_feature_cmd_holder.make (display_feature_cmd, display_feature_button, display_feature_menu_entry)
--			display_feature_cmd.set_holder (display_feature_cmd_holder)
--
--			create display_object_cmd.make (Current)
--			create display_object_button.make (display_object_cmd, project_toolbar)
--			create display_object_cmd_holder.make (display_object_cmd, display_object_button, display_object_menu_entry)
--			display_object_cmd.set_holder (display_object_cmd_holder)
--
--			create update_cmd.make (Current)
--			create update_button.make (update_cmd, project_toolbar)
--			update_button.set_action ("c<Btn1Down>", update_cmd, update_cmd.generate_code_only)
--			create update_cmd_holder.make (update_cmd, update_button, melt_menu_entry)
--
--			create quick_update_cmd.make (Current)
--			quick_update_cmd.set_quick_melt
--			create quick_update_button.make (quick_update_cmd, project_toolbar)
--			quick_update_button.set_action ("c<Btn1Down>", quick_update_cmd, quick_update_cmd.generate_code_only)
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


	save_environment is
			-- Save the current environment
			--| ie, save windows positions, save breakpoints
		require
			recent_project_list_exists: recent_project_list /= Void
			recent_project_list_compare_objects: recent_project_list.object_comparison
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

feature {NONE} -- Properties

	shown_portions: INTEGER
			-- Number of portions that are shown

	feature_part: EB_FEATURE_TOOL
			-- Feature part of Current for debugging

	object_part: EB_OBJECT_TOOL
			-- Object part of Current for debugging

	selector_part: EB_SELECT_TOOL
			-- Selector part

	debug_part: EB_DEBUG_TOOL
			-- Debugger part

feature -- System Execution Modes

	exec_stop_frmt_holder: COMMAND_HOLDER
			-- Set execution format so that user-defined stop
			-- points will be taken into account

	exec_nostop_frmt_holder: COMMAND_HOLDER
			-- Set execution format so that no stop points will
			-- be taken into account

	exec_step_frmt_holder: COMMAND_HOLDER
			-- Set execution format so that each breakable points
			-- of the current routine will be taken into account

	exec_last_frmt_holder: COMMAND_HOLDER
			-- Set execution format so that only the last
			-- breakable point of the current routine will be
			-- taken into account

feature -- Commands

	new_cmd_holder: COMMAND_HOLDER
			-- To create a new project

	open_cmd_holder: COMMAND_HOLDER
			-- To open an existing project

	quit_cmd_holder: COMMAND_HOLDER
			-- To quit the current project

	update_cmd_holder: COMMAND_HOLDER

	quick_update_cmd_holder: COMMAND_HOLDER

	debug_run_cmd_holder: COMMAND_HOLDER

	debug_status_cmd_holder: COMMAND_HOLDER

	debug_quit_cmd_holder: COMMAND_HOLDER

	clear_bp_cmd_holder: COMMAND_HOLDER

	special_cmd_holder: COMMAND_HOLDER

	freeze_cmd_holder: COMMAND_HOLDER

	finalize_cmd_holder: COMMAND_HOLDER

	precompile_cmd_holder: COMMAND_HOLDER

	display_feature_cmd_holder: COMMAND_HOLDER

	display_object_cmd_holder: COMMAND_HOLDER

	up_exception_stack_holder: COMMAND_HOLDER

	down_exception_stack_holder: COMMAND_HOLDER

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
--				t = Routine_type or else
--				t = Explain_type or else
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

	process_classi (a_stone: CLASSI_STONE) is
			-- Process dropped stone `a_stone'.
		local
			new_tool: EB_CLASS_TOOL
		do
			new_tool := tool_supervisor.new_class_tool
			new_tool.raise
			new_tool.process_classi (a_stone)
		end
 
	process_class (a_stone: CLASSC_STONE) is
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
			stop_points_button: EB_BUTTON_HOLE		
		do
			stop_points_button := stop_points_hole_holder.associated_button
			stop_points_button.associated_command.process_breakable (a_stone)
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

	hide_class_portion is
			-- Hide the class potion and hide the menu entries
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

	update_compile_access (b: BOOLEAN) is
		local
			m: EB_PROJECT_WINDOW
		do
			m ?= manager
			m.update_compile_menu (b)
		end

feature -- Tool management features

	tool_parent: EV_CONTAINER
			-- not very good, but it works.

	associated_window: EV_WINDOW is
		do
			Result := parent_window
		end

	show_tool (t: EB_TOOL) is
			-- shows the tool.
		do
			t.show_imp
		end

	raise_tool (t: EB_TOOL) is
			-- destroys the tool.
		do
		end

	hide_tool (t: EB_TOOL) is
			-- destroys the tool.
		do
			t.hide_imp
		end

	destroy_tool (t: EB_TOOL) is
			-- destroys the tool.
		do
			t.destroy_imp
		end

--	set_size (min_x, min_y: INTEGER) is
--		do
--		end

--	set_width (new_width: INTEGER) is
--		do
--		end

--	set_height (new_height: INTEGER) is
--		do
--		end

	tool_title : STRING is
		do
		end

	tool_icon_name : STRING is
		do
		end

	set_tool_title (t: EB_TOOL; s: STRING) is
		do
		end

	set_tool_icon_name (t: EB_TOOL; s: STRING) is
		do
		end

end -- class EB_PROJECT_TOOL

