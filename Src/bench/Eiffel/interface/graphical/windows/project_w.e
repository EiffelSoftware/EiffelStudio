indexing
	description: "The project window."
	date: "$Date$"
	revision: "$Revision$"

class PROJECT_W

inherit
	TOOL_W
		rename
			edit_bar as project_toolbar,
			Project_resources as resources,
			progress_dialog as shared_progress_dialog
		redefine
			tool_name, process_system, process_error,
			process_object, process_breakable, process_class,
			process_classi, compatible, process_feature,
			process_class_syntax, process_ace_syntax, display,
			process_call_stack, force_raise,
			update_graphical_resources, help_index, icon_id
		select
			resources
		end

	TOOLTIP_INITIALIZER

	COMMAND

	BASE
		rename
			make as base_make
		export {GENERATE_ALL_REVERSE, GENERATE_SELEC_REVERSE}
			implementation
		end

	WINDOW_ATTRIBUTES

	SYSTEM_CONSTANTS

	SHARED_APPLICATION_EXECUTION

	SHARED_EIFFEL_PROJECT

	PROJECT_CONTEXT

	RESOURCE_USER
		redefine
			update_integer_resource, update_boolean_resource,
			update_string_resource
		end

	WIDGET_ROUTINES

creation
	make

feature -- Initialization

	make (a_screen: SCREEN) is
			-- Create a project application.
		local
			app_stopped_cmd: APPLICATION_STOPPED_CMD
			titre: STRING
		do
			General_resources.add_user (Current)
			Project_resources.add_user (Current)
			!! menus.make (1,16)
			base_make (Icon_id.out, a_screen)
			!! history.make
			register
			titre := Interface_names.t_Project
			set_title (Interface_names.t_Project)
			set_icon_name (tool_name)
			if Pixmaps.bm_Project_icon.is_valid then
				set_icon_pixmap (Pixmaps.bm_Project_icon)
			end
			set_action ("<Unmap>,<Prop>", Current, popdown)
			set_action ("<Configure>", Current, remapped)
			set_action ("<Visible>", Current, remapped)
			!! app_stopped_cmd
			Application.set_before_stopped_command (app_stopped_cmd)
			Application.set_after_stopped_command (app_stopped_cmd)
			tooltip_initialize (Current)

			build_widgets
			set_delete_command (quit_cmd_holder.associated_command)
			set_font_to_default
			set_default_position

			realize
			tooltip_realize
			init_text_window
			set_composite_attributes (Current)
			feature_part.init_text_window
			object_part.init_text_window

			global_verti_split_window.update_split
			hori_split_window.update_split
			top_verti_split_window.update_split

			display_welcome_info
		end

feature -- Resource Update

	update_boolean_resource (old_res, new_res: BOOLEAN_RESOURCE) is
		local
			rout_cli_cmd: SHOW_ROUTCLIENTS
			display_routine_cmd: DISPLAY_ROUTINE_PORTION
			display_object_cmd: DISPLAY_OBJECT_PORTION
			stop_cmd: SHOW_BREAKPOINTS
			pr: like Project_resources
			progress_output: DEGREE_OUTPUT
		do
			pr := resources
			if old_res = pr.command_bar then
				if new_res.actual_value then
					project_toolbar.add
				else
					project_toolbar.remove
				end
			elseif old_res = pr.graphical_output_disabled then
				if new_res.actual_value then	
					!! progress_output
				else
					!GRAPHICAL_DEGREE_OUTPUT! progress_output
				end
				set_progress_dialog (progress_output)
			elseif old_res = pr.format_bar then
				if new_res.actual_value then
					format_bar.add
				else
					format_bar.remove
				end
			elseif old_res = pr.selector_window then
				if new_res.actual_value then
					selector_part.show_selector
				else
					selector_part.hide_selector
				end
			elseif old_res = pr.feature_window then
				display_routine_cmd ?= display_feature_cmd_holder.associated_command
				if new_res.actual_value then
					display_routine_cmd.show
				else
					display_routine_cmd.hide
				end
			elseif old_res = pr.object_window then
				display_object_cmd ?= display_object_cmd_holder.associated_command
				if new_res.actual_value then
					display_object_cmd.show
				else
					display_object_cmd.hide
				end
			elseif old_res = pr.debugger_show_all_callers then
				if feature_part /= Void then
					rout_cli_cmd ?= feature_part.showroutclients_frmt_holder.associated_command
					rout_cli_cmd.set_show_all_callers (new_res.actual_value)
				end
			elseif old_res = pr.debugger_do_flat_in_breakpoints then
				if feature_part /= Void then
					stop_cmd ?= feature_part.showstop_frmt_holder.associated_command
					stop_cmd.set_format_mode (new_res.actual_value)
				end
			end
			old_res.update_with (new_res)
		end

	update_string_resource (old_res, new_res: STRING_RESOURCE) is
		local
			gr: like General_resources
		do
			gr := General_resources
			if old_res = gr.filter_path then
				Eiffel_project.set_filter_path (new_res.value)
			elseif old_res = gr.profile_path then
				Eiffel_project.set_profile_path (new_res.value)
			elseif old_res = gr.tmp_path then
				Eiffel_project.set_tmp_directory (new_res.value)
			end
			old_res.update_with (new_res)
		end

	update_integer_resource (old_res, new: INTEGER_RESOURCE) is
		local
			pr: like resources
		do
			pr := resources
			if new.actual_value >= 0 then
				if old_res = pr.tool_x then
					set_x (new.actual_value)
				elseif old_res = pr.tool_y then
					set_y (new.actual_value)
				elseif old_res = pr.tool_width then
					if new.actual_value /= 0 then
						set_width (new.actual_value)
					else
						set_width (1)
					end
				elseif old_res = pr.tool_height then
					if new.actual_value /= 0 then
						if shown_portions = 1 then
							set_height (new.actual_value)
							if not toolkit_is_motif then
								hori_split_window.set_height (new.actual_value)
							end
						end
					else
							if shown_portions = 1 then
							set_height (1)
							if not toolkit_is_motif then
								hori_split_window.set_height (1)
							end
						end
					end
				elseif old_res = pr.interrupt_every_n_instructions then
					Application.set_interrupt_number (new.actual_value)
				elseif old_res = General_resources.tab_step then
					set_tab_length (new.actual_value)
					Window_manager.routine_win_mgr.set_tab_length (tab_length)
					Window_manager.class_win_mgr.set_tab_length (tab_length)
					Window_manager.object_win_mgr.set_tab_length (tab_length)
					Window_manager.explain_win_mgr.set_tab_length (tab_length)
					if is_system_tool_created and then System_tool.realized then
						System_tool.set_tab_length (tab_length)
						System_tool.update_save_symbol
						if System_tool.text_window.is_graphical then	
							System_tool.synchronize
						end
					end
					if feature_part /= Void and then feature_form.managed then
						feature_part.set_tab_length (tab_length) 
						if  feature_part.text_window.is_graphical then
							feature_part.synchronize
						end
					end
					if object_part /= Void and then object_form.managed then 
						object_part.set_tab_length (tab_length) 
						if object_part.text_window.is_graphical then
							object_part.synchronize
						end
					end
					if text_window.is_graphical then	
						synchronize
					end
				end
				old_res.update_with (new)
			end
		end

	update_graphical_resources is
			-- Synchronize clickable elements with text, if possible
			-- and update the graphical values in text window.
		do
			initialize_text_window_resources
			synchronize
			if feature_part /= Void then
				feature_part.update_graphical_resources
			end
			if object_part /= Void then
				object_part.update_graphical_resources
			end
		end
	
feature -- Access

	popdown: ANY is
		once
			!! Result
		end

	remapped: ANY is
		once
			!! Result
		end

	eb_shell: EB_SHELL is
		do
			Result := Void
		end

	help_index: INTEGER is 2

	icon_id: INTEGER is
			-- Icon id of Current window (for windows)
		do
			Result := Interface_names.i_Project_id
		end

feature -- Access

	kept_objects: LINKED_SET [STRING] is
			-- Hector addresses of displayed clickable objects
		do
			Result := text_window.kept_objects
		end

feature -- Window Settings

	force_raise is
			-- Raise the project tool.
		do
			raise
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

	display is
			-- Display Current on the screen
		do
		end

feature -- Window Properties

	initialized: BOOLEAN
			-- Is the workbench created?

	is_system_tool_hidden: BOOLEAN
			-- Is the system tool hidden?

	is_name_chooser_hidden: BOOLEAN
			-- Is the name chooser hidden?

	is_warner_hidden: BOOLEAN
			-- Is the warner window hidden?

	is_confirmer_hidden: BOOLEAN
			-- Is the confirmer window hidden?

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

	menus: ARRAY [MENU_PULL]
			-- Record all the menus of the Project tool

	special_menu: INTEGER is 1
			-- ID Menu for commands.
			-- Only used during debugging

	format_menu: INTEGER is 2
			-- ID Menu for formats.
			-- Only used during debugging

	compile_menu: INTEGER is 3
			-- Compile ID menu.

	debug_menu: INTEGER is 4
			-- Debug ID menu.

	window_menu: INTEGER is 5
			-- Window ID menu.

	open_classes_menu: INTEGER is 6
			-- ID Menu for open class tools

	open_routines_menu: INTEGER is 7
			-- ID Menu for open feature tools

	open_objects_menu: INTEGER is 8
			-- ID Menu for open object tools

	open_explain_menu: INTEGER is 9
			-- ID Menu for open explain tools

	edit_feature_menu: INTEGER is 10
			-- ID Edit menu specific for the feature part

	special_feature_menu: INTEGER is 11
			-- ID Special menu specific for the feature part

	format_feature_menu: INTEGER is 12
			-- ID Format menu specific for the feature part

	edit_object_menu: INTEGER is 13
			-- ID Edit menu specific for the object part

	special_object_menu: INTEGER is 14
			-- ID Special menu specific for the object part

	format_object_menu: INTEGER is 15
			-- ID Format menu specific for the object part

	recent_project_menu: INTEGER is 16
			-- ID Recent project menu for the file menu

	active_menus (erase: BOOLEAN) is
			-- Enable all the menus and if `erase' clean
			-- the content of the Project tool.
		do
			menus.item (compile_menu).set_sensitive
			menus.item (debug_menu).set_sensitive
			menus.item (format_menu).set_sensitive
			menus.item (special_menu).set_sensitive
			menus.item (window_menu).set_sensitive
			if erase then
				text_window.clear_window
			end
		end

	disable_menus is
			-- Disable all the menus.
		do
			menus.item (compile_menu).set_insensitive
			menus.item (debug_menu).set_insensitive
			menus.item (format_menu).set_insensitive
			menus.item (special_menu).set_insensitive
			menus.item (window_menu).set_insensitive
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

	global_form: FORM
			-- Form which contains split windows and toolbars

	global_verti_split_window: SPLIT_WINDOW
			-- Global Vertical Split window

	hori_split_window: SPLIT_WINDOW
			-- Horizontal Split window

	top_verti_split_window: SPLIT_WINDOW
			-- Top vertical Split window

	bottom_verti_split_window: SPLIT_WINDOW
			-- Bottom vertical split window

	top_form, bottom_form: SPLIT_WINDOW_CHILD
			-- Form on which the project tool is displayed

	common_form: SPLIT_WINDOW_CHILD
			-- Common Form for the project, object, and feature tool

	selector_form: SPLIT_WINDOW_CHILD
			-- Form on which the selector tool is displayed

	project_form: SPLIT_WINDOW_CHILD
			-- Form on which the project tool is displayed

	feature_form: SPLIT_WINDOW_CHILD
			-- Form on which the feature tool will be shown

	object_form: SPLIT_WINDOW_CHILD
			-- Form on which the object tool will be shown
	
	class_form: SPLIT_WINDOW_CHILD
			-- Form on which the class tool will be shown

feature -- Progress Dialog

	progress_dialog: DEGREE_OUTPUT
			-- Progress dialog associated with the project.
			-- It can be a graphical one or a text mode one.

	set_progress_dialog (new_progress_dialog: DEGREE_OUTPUT) is
			-- Set `progress_dialog' to `new_progress_dialog'.
			-- Set also `Eiffel_project' progress_dialog which needs to know
			-- that we changed the kind of `progress_dialog'.
		local
			graphical_version: GRAPHICAL_DEGREE_OUTPUT
		do
			progress_dialog := new_progress_dialog
			Eiffel_project.set_degree_output (progress_dialog)

				-- If `process_dialog' is a graphical dialog then
				-- We need to give him its parent.
			graphical_version ?= progress_dialog
			if graphical_version /= Void then
				graphical_version.set_parent_window (implementation)
			end
		end

feature -- Execution Implementation

	execute (arg: ANY) is
			-- Resize xterm window when drawing area is resized
		do
			if arg = remapped then
				if is_project_tool_hidden then
						-- The project tool is being deiconified.
					is_project_tool_hidden := False
					window_manager.show_all_editors
					if is_profile_tool_hidden then
						is_profile_tool_hidden := False
						Profile_tool.show
					end
					if is_preference_tool_hidden then
						is_preference_tool_hidden := False
						Preference_tool.show
					end
					if is_system_tool_created then
						if is_system_tool_hidden then
							system_tool.show
							is_system_tool_hidden := False
						elseif system_tool.in_use then
							system_tool.show
						end
					end
					raise
					if is_warner_hidden then
						is_warner_hidden := false
						last_warner.popup
					end
					if is_confirmer_hidden then
						is_confirmer_hidden := false
						last_confirmer.popup
					end
					if is_name_chooser_hidden then
						is_name_chooser_hidden := false
						last_name_chooser.popup
					end
				else
						-- The project tool is being raised, moved or resized.
						-- Raise popups with an exclusive grab.
					raise_grabbed_popup
				end
			elseif arg = popdown then
				is_project_tool_hidden := True
				window_manager.hide_all_editors
				if
					is_system_tool_created and then
					system_tool.realized and then
					system_tool.shown
				then
					system_tool.hide
					system_tool.close_windows
					is_system_tool_hidden := True
				end
				if Preference_tool /= Void and then Preference_tool.shown then
					Preference_tool.hide
					is_preference_tool_hidden := True
				end
				if Profile_tool /= Void and then Profile_tool.shown then
					Profile_tool.hide
					is_profile_tool_hidden := True
				end
				if last_name_chooser /= Void and then last_name_chooser.is_popped_up then
					is_name_chooser_hidden := true
					last_name_chooser.popdown
				end	
				if last_warner /= Void and then last_warner.is_popped_up then
					is_warner_hidden := true
					last_warner.popdown
				end
				if last_confirmer /= Void and then last_confirmer.is_popped_up then
					is_confirmer_hidden := true
					last_confirmer.popdown
				end
			end
		end

feature -- Update

	synchronize_routine_tool_to_default is
			-- Synchronize the routine tool to the debug format.
		do
			if feature_part /= Void and then feature_form.managed then	
				feature_part.set_debug_format
			end
		end

	close_windows is
			-- Close associated windows.
		do
		end

	clear_object_tool is
			-- Clear the contents of the object tool if shown.
		do
			if object_part /= Void and then object_form.managed then	
				object_part.reset
			end
		end

	resynchronize_debugger is
		do
			if feature_part /= Void and then feature_form.managed then
				feature_part.resynchronize_debugger (Void)
			end
		end

	show_stoppoint (e_feature: E_FEATURE index: INTEGER) is
			-- If stone feature is equal to feature `f' and if in debug
			-- mode then redisplay the sign of the `index'-th breakable point.
		require
			valid_feature: e_feature /= Void and then e_feature.body_id /= Void
		local
			new_stone: FEATURE_STONE
			display_cmd: DISPLAY_ROUTINE_PORTION
		do
			display_cmd ?= display_feature_cmd_holder.associated_command
			if display_cmd.is_shown and then index > 0 then
				feature_part.show_stoppoint (e_feature, index)
			end
		end

	show_current_stoppoint is
			-- Show breakable mark in the feature part if
			-- the part is displayed
		local
			status: APPLICATION_STATUS
			display_cmd: DISPLAY_ROUTINE_PORTION
			new_stone: FEATURE_STONE
			call_stack: CALL_STACK_ELEMENT
			e_feature: E_FEATURE
			index: INTEGER
		do
			if Application.is_running and then Application.is_stopped then
				display_cmd ?= display_feature_cmd_holder.associated_command
				if display_cmd.is_shown then
					status := Application.status
					if status.e_feature /= Void then
						call_stack := status.current_stack_element
						if Application.current_execution_stack_number = 1 then
							e_feature := status.e_feature
							index := status.break_index
						else
							e_feature := call_stack.routine
						end
						if feature_part.last_format /= feature_part.showstop_frmt_holder then
							feature_part.set_debug_format
						end
						!! new_stone.make (e_feature)
						feature_part.process_feature (new_stone)
						if index > 0 then
							feature_part.show_stoppoint (e_feature, index)
						end
					end
				end
			end
		end

	show_current_object is
			-- Show the current object in exception 
			-- stack in object tool portion.
		local
			display_cmd: DISPLAY_OBJECT_PORTION
			new_stone: OBJECT_STONE
			call_stack: CALL_STACK_ELEMENT
			object_address: STRING
			dynamic_class: CLASS_C
			status: APPLICATION_STATUS
		do
			if Application.is_running and then 
				Application.is_stopped 
			then
				display_cmd ?= display_object_cmd_holder.associated_command
				if display_cmd.is_shown then
					status := Application.status
					if status.e_feature /= Void then
						call_stack := status.current_stack_element
						if Application.current_execution_stack_number = 1 then
							dynamic_class := status.dynamic_class
							object_address := status.object_address
						else
							dynamic_class := call_stack.dynamic_class
							object_address := call_stack.object_address
						end
						!! new_stone.make (object_address, call_stack.routine_name, dynamic_class)
						if new_stone.same_as (object_part.stone) then
							object_part.synchronize
						else
							object_part.process_object (new_stone)
						end
					end
				end
			end
		end

	display_exception_stack is
			-- Display the exception stack in the text window.
		local
			st: STRUCTURED_TEXT
		do
			!! st.make
			Application.status.display_status (st)
			text_window.clear_window
			text_window.process_text (st)
			text_window.display
			if saved_cursor /= Void then
				text_window.go_to (saved_cursor)
			end
		end

	save_current_cursor_position is
			-- Save the current cursor position.
		do
			saved_cursor := text_window.cursor
		end

	clear_cursor_position is
			-- Clear the saved cursor position.
		do
			saved_cursor := Void
		end

	add_routine_entry (r_w: ROUTINE_W) is
		do
			add_tool_to_menu (r_w, menus @ open_routines_menu)
			selector_part.add_tool_entry(r_w)
		end

	change_routine_entry (r_w: ROUTINE_W) is
		do
			change_tool_in_menu (r_w, menus @ open_routines_menu)
			selector_part.change_tool_entry(r_w)
		end

	remove_routine_entry (r_w: ROUTINE_W) is
		do
			remove_tool_from_menu (r_w, menus @ open_routines_menu)
			selector_part.remove_tool_entry(r_w)
		end

	add_class_entry (c_w: CLASS_W) is
		do
			add_tool_to_menu (c_w, menus @ open_classes_menu)
			selector_part.add_tool_entry(c_w)
		end

	change_class_entry (c_w: CLASS_W) is
		do
			change_tool_in_menu (c_w, menus @ open_classes_menu)
			selector_part.change_tool_entry(c_w)
		end

	remove_class_entry (c_w: CLASS_W) is
		do
			remove_tool_from_menu (c_w, menus @ open_classes_menu)
			selector_part.remove_tool_entry(c_w)
		end

	add_object_entry (o_w: OBJECT_W) is
		do
			add_tool_to_menu (o_w, menus @ open_objects_menu)
			selector_part.add_tool_entry(o_w)
		end

	change_object_entry (o_w: OBJECT_W) is
		do
			change_tool_in_menu (o_w, menus @ open_objects_menu)
			selector_part.change_tool_entry(o_w)
		end

	remove_object_entry (o_w: OBJECT_W) is
		do
			remove_tool_from_menu (o_w, menus @ open_objects_menu)
			selector_part.remove_tool_entry(o_w)
		end

	add_explain_entry (e_w: EXPLAIN_W) is
		do
			add_tool_to_menu (e_w, menus @ open_explain_menu)
		end

	change_explain_entry (e_w: EXPLAIN_W) is
		do
			change_tool_in_menu (e_w, menus @ open_explain_menu)
		end

	remove_explain_entry (e_w: EXPLAIN_W) is
		do
			remove_tool_from_menu (e_w, menus @ open_explain_menu)
		end

feature -- Graphical Interface

	build_widgets is
			-- Build widget.
		local
			default_width, default_height: INTEGER
			hide_split_windows: BOOLEAN
			display_routine_cmd: DISPLAY_ROUTINE_PORTION
			display_object_cmd: DISPLAY_OBJECT_PORTION
		do
			shown_portions := 1

			if screen.width < 800 then
				default_width := 400
				default_height := 350
				hide_split_windows := True
			elseif screen.width = 800 then
				default_width := screen.visible_width
				default_height := screen.visible_height
				set_maximized_state
			else
				default_width := Project_resources.tool_width.actual_value
				default_height := Project_resources.tool_height.actual_value
			end
			set_size (default_width, default_height)

			!! global_form.make (new_name, Current)

  			!! global_verti_split_window.make_vertical_with_proportion (new_name, global_form, 15)

 			!! selector_form.make (new_name, global_verti_split_window)
			!! selector_part.make ("Selector",selector_form) 

			!! common_form.make (new_name, global_verti_split_window)

  			!! hori_split_window.make_horizontal_with_proportion (new_name, common_form,50)

			!! top_form.make (new_name, hori_split_window)
			top_form.set_size(hori_split_window.width,hori_split_window.height)

			!! top_verti_split_window.make_vertical_with_proportion (new_name, top_form, 50)

			!! project_form.make (new_name, top_verti_split_window)
			!! object_form.make (new_name, top_verti_split_window)
			!! feature_form.make (new_name, hori_split_window)

			create_toolbar (global_form)
			build_menu
			build_text_windows (project_form)
			build_top
			build_compile_menu
			build_format_bar
			build_toolbar_menu

 			!! feature_part.form_create (feature_form, 
 					menus @ special_feature_menu, 
 					menus @ edit_feature_menu, 
 					menus @ format_feature_menu,
 					menus @ special_feature_menu)


			!! object_part.form_create ( object_form, 
					menus @ special_object_menu, 
					menus @ edit_object_menu, 
					menus @ format_object_menu,
					menus @ special_object_menu)

			if Project_resources.command_bar.actual_value = False then
				project_toolbar.remove
			end
			if Project_resources.format_bar.actual_value = False then
				format_bar.remove
			end

			attach_all

			display_routine_cmd ?= display_feature_cmd_holder.associated_command
			display_object_cmd ?= display_object_cmd_holder.associated_command

			if hide_split_windows or else not Project_resources.feature_window.actual_value then
				display_routine_cmd.hide
			else
				display_routine_cmd.show
			end

			if hide_split_windows or else not Project_resources.object_window.actual_value then
				display_object_cmd.hide
			else
				display_object_cmd.show
			end

				-- Make all the entry disabled.
			disable_menus
		end

	build_menu is
			-- Build the menu bar
		local
			sep: SEPARATOR
			case_storage_cmd: CASE_STORAGE
			case_storage_menu_entry: EB_MENU_ENTRY
			document_submenu: MENU_PULL
			generate_doc_cmd: DOCUMENT_GENERATION
			generate_menu_entry: EB_MENU_ENTRY
			generate_submenu: MENU_PULL
			local_menu: MENU_PULL
		do
			!! menu_bar.make (new_name, global_form)
			!! file_menu.make (Interface_names.m_File, menu_bar)
			!! edit_menu.make (Interface_names.m_Edit, menu_bar)
			!! local_menu.make (Interface_names.m_Compile, menu_bar)
			menus.put (local_menu, compile_menu)

			!! local_menu.make (Interface_names.m_Debug, menu_bar)
			menus.put (local_menu, debug_menu)

			!! local_menu.make (Interface_names.m_Formats, menu_bar)
			menus.put (local_menu, format_menu)

			!! local_menu.make (Interface_names.m_Special, menu_bar)
			menus.put (local_menu, special_menu)

			!! local_menu.make (Interface_names.m_Windows, menu_bar)
			menus.put (local_menu, window_menu)

			build_help_menu

				--| Creation of empty menus that are disabled goes here,
				--| for we want to create the object and / or feature portion
				--| on demand and not on purpose.
			!! local_menu.make (Interface_names.m_Feature, edit_menu)
			local_menu.button.set_insensitive
			menus.put (local_menu, edit_feature_menu)

			!! local_menu.make (Interface_names.m_Object, edit_menu)
			local_menu.button.set_insensitive
			menus.put (local_menu, edit_object_menu)

			!! sep.make (Interface_names.t_Empty, edit_menu)

			!! local_menu.make (Interface_names.m_Feature, menus @ format_menu)
			local_menu.button.set_insensitive
			menus.put (local_menu, format_feature_menu)

			!! local_menu.make (Interface_names.m_Object, menus @ format_menu)
			local_menu.button.set_insensitive
			menus.put (local_menu, format_object_menu)

			!! sep.make (Interface_names.t_Empty, menus @ format_menu)

			!! local_menu.make (Interface_names.m_Feature, menus @ special_menu)
			local_menu.button.set_insensitive
			menus.put (local_menu, special_feature_menu)

			!! local_menu.make (Interface_names.m_Object, menus @ special_menu)
			local_menu.button.set_insensitive
			menus.put (local_menu, special_object_menu)

			!! sep.make (Interface_names.t_Empty, menus @ special_menu)
			!! case_storage_cmd
			!! case_storage_menu_entry.make_default (case_storage_cmd, menus @ special_menu)
			!! generate_submenu.make (Interface_names.m_Document, menus @ special_menu)
			!! generate_doc_cmd.make_flat
			!! generate_menu_entry.make (generate_doc_cmd, generate_submenu)
			!! generate_doc_cmd.make_flat_short
			!! generate_menu_entry.make (generate_doc_cmd, generate_submenu)
			!! generate_doc_cmd.make_short
			!! generate_menu_entry.make (generate_doc_cmd, generate_submenu)
			!! generate_doc_cmd.make_text
			!! generate_menu_entry.make (generate_doc_cmd, generate_submenu)
		end

	build_file_menu is
			-- Build the file menu.
		local
			new_cmd: NEW_PROJECT
			new_button: EB_BUTTON
			new_menu_entry: EB_MENU_ENTRY
			open_cmd: OPEN_PROJECT
			open_button: EB_BUTTON
			open_menu_entry: EB_MENU_ENTRY
			quit_cmd: QUIT_PROJECT
			quit_button: EB_BUTTON
			quit_menu_entry: EB_MENU_ENTRY
		do
			!! new_cmd.make (Current)
			!! new_menu_entry.make (new_cmd, file_menu)
			!! new_cmd_holder.make_plain (new_cmd)
			new_cmd_holder.set_menu_entry (new_menu_entry)

			!! open_cmd.make (Current)
			!! open_menu_entry.make (open_cmd, file_menu)
			!! open_cmd_holder.make_plain (open_cmd)
			open_cmd_holder.set_menu_entry (open_menu_entry)

			build_print_menu_entry

			build_recent_project_menu_entries

			!! quit_cmd.make (Current)
			!! quit_menu_entry.make (quit_cmd, file_menu)
			!! quit_cmd_holder.make_plain (quit_cmd)
			quit_cmd_holder.set_menu_entry (quit_menu_entry)
		end
		
	build_toolbar_menu is
			-- Build the toolbar menu under the special sub menu.
		local
			sep: SEPARATOR
			toolbar_t: TOGGLE_B
		do
			!! sep.make (Interface_names.t_Empty, menus @ special_menu)
			!! toolbar_t.make (project_toolbar.identifier, menus @ special_menu)
			project_toolbar.init_toggle (toolbar_t)
			!! toolbar_t.make (format_bar.identifier, menus @ special_menu)
			format_bar.init_toggle (toolbar_t)
			!! toolbar_t.make (selector_part.identifier, menus @ special_menu)
			selector_part.init_toggle (toolbar_t)
		end

	build_top is
			-- Build top bar
		local
			tool_action: TOOLS_MANAGEMENT
			tool_action_menu_entry: EB_MENU_ENTRY
			explain_cmd: EXPLAIN_HOLE
			explain_button: EB_BUTTON_HOLE
			explain_menu_entry: EB_MENU_ENTRY
			system_cmd: SYSTEM_HOLE
			system_button: EB_BUTTON_HOLE
			system_menu_entry: EB_MENU_ENTRY
			class_cmd: CLASS_HOLE
			class_button: EB_BUTTON_HOLE
			class_menu_entry: EB_MENU_ENTRY
			routine_cmd: ROUTINE_HOLE
			routine_button: EB_BUTTON_HOLE
			routine_menu_entry: EB_MENU_ENTRY
			shell_cmd: SHELL_COMMAND
			shell_button: EB_BUTTON_HOLE
			object_cmd: OBJECT_HOLE
			object_button: EB_BUTTON_HOLE
			object_menu_entry: EB_MENU_ENTRY
			clear_bp_cmd: DEBUG_CLEAR_STOP_POINTS_HOLE
			clear_bp_button: EB_BUTTON_HOLE
			clear_bp_menu_entry: EB_MENU_ENTRY
			stop_points_cmd: DEBUG_STOPIN_HOLE
			stop_points_button: EB_BUTTON_HOLE
			stop_points_menu_entry: EB_MENU_ENTRY
			stop_points_status_cmd: STOPPOINTS_STATUS
			stop_points_status_menu_entry: EB_MENU_ENTRY

			dynamic_lib_cmd: DYNAMIC_LIB_HOLE
			dynamic_lib_button: EB_BUTTON_HOLE
			dynamic_lib_menu_entry: EB_MENU_ENTRY

			show_pref_cmd: SHOW_PREFERENCE_TOOL
			show_pref_menu_entry: EB_MENU_ENTRY

			show_prof_cmd: SHOW_PROFILE_TOOL
			show_prof_menu_entry: EB_MENU_ENTRY

			sep: SEPARATOR
			sep1, sep2: THREE_D_SEPARATOR
			display_feature_cmd: DISPLAY_ROUTINE_PORTION
			display_feature_button: EB_BUTTON
			display_feature_menu_entry: EB_MENU_ENTRY
			display_object_cmd: DISPLAY_OBJECT_PORTION
			display_object_button: EB_BUTTON
			display_object_menu_entry: EB_MENU_ENTRY
			update_cmd: UPDATE_PROJECT
			update_button: EB_BUTTON
			quick_update_cmd: UPDATE_PROJECT
			quick_update_button: EB_BUTTON
--  			version_button: PUSH_B

			about_menu_entry: EB_MENU_ENTRY
			about_cmd: ABOUT_COMMAND
			about_tool:ABOUT_W
			local_menu: MENU_PULL
			do_nothing_cmd: DO_NOTHING_CMD
		do
			build_file_menu

			-- Help Menu
--			!! version_button.make (Version_number, help_menu)

			!! about_tool.make ("About_Dialog", screen)
			!! about_cmd.make (about_tool)
			!! about_menu_entry.make_default (about_cmd, help_menu)

				-- Edit Menu
			build_edit_menu (project_toolbar)

				-- Close all command
			!! tool_action.make_close_all
			!! tool_action_menu_entry.make_default (tool_action, menus @ window_menu)

			!! tool_action.make_raise_all
			!! tool_action_menu_entry.make_default (tool_action, menus @ window_menu)

			!! sep.make (Interface_names.t_Empty, menus @ window_menu)

				-- Sub menus for open tools.
			!! local_menu.make (Interface_names.m_Explain_tools, menus @ window_menu)
			menus.put (local_menu, open_explain_menu)

			!! local_menu.make (Interface_names.m_Class_tools, menus @ window_menu)
			menus.put (local_menu, open_classes_menu)

			!! local_menu.make (Interface_names.m_Feature_tools, menus @ window_menu)
			menus.put (local_menu, open_routines_menu)

			!! local_menu.make (Interface_names.m_Object_tools, menus @ window_menu)
			menus.put (local_menu, open_objects_menu)

			!! sep.make (Interface_names.t_Empty, menus @ window_menu)

				-- Regular menu entries.
			!! explain_cmd.make (Current)
			!! explain_button.make (explain_cmd, project_toolbar)
			!! explain_menu_entry.make (explain_cmd, menus @ open_explain_menu)
			!! explain_hole_holder.make (explain_cmd, explain_button, explain_menu_entry)

			!! system_cmd.make (Current)
			!! system_button.make (system_cmd, project_toolbar)
			!! system_menu_entry.make (system_cmd, menus @ window_menu)
			!! system_hole_holder.make (system_cmd, system_button, system_menu_entry)
			
			!! class_cmd.make (Current)
			!! class_button.make (class_cmd, project_toolbar)
			!! class_menu_entry.make (class_cmd, menus @ open_classes_menu)
			!! class_hole_holder.make (class_cmd, class_button, class_menu_entry)

			!! dynamic_lib_cmd.make (Current)
			!! dynamic_lib_button.make (dynamic_lib_cmd, project_toolbar)
			!! dynamic_lib_menu_entry.make (dynamic_lib_cmd, menus @ window_menu)
			!! dynamic_lib_hole_holder.make (dynamic_lib_cmd, dynamic_lib_button, dynamic_lib_menu_entry)

			!! routine_cmd.make (Current)
			!! routine_button.make (routine_cmd, project_toolbar)
			!! routine_menu_entry.make (routine_cmd, menus @ open_routines_menu)
			!! routine_hole_holder.make (routine_cmd, routine_button, routine_menu_entry)

			!! shell_cmd.make (Current)
			!! shell_button.make (shell_cmd, project_toolbar)
			shell_button.add_third_button_action

			!! object_cmd.make (Current)
			!! object_button.make (object_cmd, project_toolbar)
			!! object_menu_entry.make (object_cmd, menus @ open_objects_menu)
			!! object_hole_holder.make (object_cmd, object_button, object_menu_entry)

			!! stop_points_cmd.make (Current)
			!! stop_points_button.make (stop_points_cmd, project_toolbar)
			!! stop_points_menu_entry.make (stop_points_cmd, menus @ debug_menu)
			!! stop_points_hole_holder.make (stop_points_cmd, stop_points_button, stop_points_menu_entry)

			!! clear_bp_cmd.make (Current)
			!! clear_bp_button.make (clear_bp_cmd, project_toolbar)
			clear_bp_button.set_action ("c<Btn1Down>", 
						clear_bp_cmd, clear_bp_cmd.clear_it_action)
			!! clear_bp_menu_entry.make (clear_bp_cmd, menus @ debug_menu)
			!! clear_bp_cmd_holder.make (clear_bp_cmd, clear_bp_button, clear_bp_menu_entry)

			!! stop_points_status_cmd.make_enabled
			!! stop_points_status_menu_entry.make_default (stop_points_status_cmd, menus @ debug_menu)
			!! stop_points_status_cmd.make_disabled
			!! stop_points_status_menu_entry.make_default (stop_points_status_cmd, menus @ debug_menu)
			!! sep.make (Interface_names.t_Empty, menus @ debug_menu)

			!! show_prof_cmd
			!! show_prof_menu_entry.make_default (show_prof_cmd, menus @ window_menu)

			!! sep.make (Interface_names.t_Empty, menus @ window_menu)
			!! show_pref_cmd.make (Project_resources)
			!! show_pref_menu_entry.make_default (show_pref_cmd, menus @ window_menu)

			!! display_feature_cmd.make (Current)
			!! display_feature_button.make (display_feature_cmd, project_toolbar)
			!! display_feature_menu_entry.make (display_feature_cmd, menus @ format_menu)
			!! display_feature_cmd_holder.make (display_feature_cmd, display_feature_button, display_feature_menu_entry)
			display_feature_cmd.set_holder (display_feature_cmd_holder)

			!! display_object_cmd.make (Current)
			!! display_object_button.make (display_object_cmd, project_toolbar)
			!! display_object_menu_entry.make (display_object_cmd, menus @ format_menu)
			!! display_object_cmd_holder.make (display_object_cmd, display_object_button, display_object_menu_entry)
			display_object_cmd.set_holder (display_object_cmd_holder)

			!! update_cmd.make (Current)
			!! update_button.make (update_cmd, project_toolbar)
			update_button.set_action ("c<Btn1Down>", update_cmd, update_cmd.generate_code_only)
			!! melt_menu_entry.make (update_cmd, menus @ compile_menu)
			!! update_cmd_holder.make (update_cmd, update_button, melt_menu_entry)

			!! quick_update_cmd.make (Current)
			quick_update_cmd.set_quick_melt
			!! quick_update_button.make (quick_update_cmd, project_toolbar)
			quick_update_button.set_action ("c<Btn1Down>", quick_update_cmd, quick_update_cmd.generate_code_only)
			!! quick_melt_menu_entry.make (quick_update_cmd, menus @ compile_menu)
			!! quick_update_cmd_holder.make (quick_update_cmd, quick_update_button, quick_melt_menu_entry)

			!! sep1.make (interface_names.t_empty, project_toolbar)
			sep1.set_horizontal (False)

			!! sep2.make (interface_names.t_empty, project_toolbar)
			sep2.set_horizontal (False)

			project_toolbar.attach_left (explain_button, 5)
			project_toolbar.attach_top (explain_button, 0)
			project_toolbar.attach_left_widget (explain_button, system_button,0)
			project_toolbar.attach_top (system_button, 0)
			project_toolbar.attach_left_widget (system_button, class_button,0)
			project_toolbar.attach_top (class_button, 0)
			project_toolbar.attach_left_widget (class_button, routine_button, 0)
			project_toolbar.attach_left_widget (routine_button, shell_button, 0)
			project_toolbar.attach_top (routine_button, 0)
			project_toolbar.attach_left_widget (routine_button, dynamic_lib_button, 0)
			project_toolbar.attach_top (dynamic_lib_button, 0)

			project_toolbar.attach_left_widget (dynamic_lib_button, shell_button, 0)

			project_toolbar.attach_top (shell_button, 0)
			project_toolbar.attach_left_widget (shell_button, object_button, 0)
			project_toolbar.attach_top (object_button, 0)
			project_toolbar.attach_left_widget (object_button, clear_bp_button, 0)
			project_toolbar.attach_top (clear_bp_button, 0)
			project_toolbar.attach_left_widget (clear_bp_button, stop_points_button, 0)
			project_toolbar.attach_top (stop_points_button, 0)

			project_toolbar.attach_top (sep1, 0)
			project_toolbar.attach_bottom (sep1, 0)
			project_toolbar.attach_left_widget (stop_points_button, sep1, 5)

			project_toolbar.attach_top (display_object_button, 0)
			project_toolbar.attach_left_widget (sep1, display_object_button, 5)
			project_toolbar.attach_top (display_feature_button, 0)
			project_toolbar.attach_left_widget (display_object_button, display_feature_button, 0)

			project_toolbar.attach_right (quick_update_button, 0)
			project_toolbar.attach_top (quick_update_button, 0)
			project_toolbar.attach_top (update_button, 0)
			project_toolbar.attach_right_widget (quick_update_button, update_button, 0)
			
			project_toolbar.attach_top (sep2, 0)
			project_toolbar.attach_bottom (sep2, 0)
			project_toolbar.attach_right_widget (update_button, sep2, 5)

			project_toolbar.attach_top (search_cmd_holder.associated_button, 0)
			project_toolbar.attach_right_widget (sep2, search_cmd_holder.associated_button, 5)
			!! do_nothing_cmd
			project_toolbar.set_action ("c<Btn1Down>", do_nothing_cmd, Void)
		end

	build_format_bar is
			-- Build formatting buttons in `format_bar'.
		local
			step_out_cmd: EXEC_LAST
			step_out_button: EB_BUTTON
			step_out_menu_entry: EB_MENU_ENTRY
			stop_menu_entry: EB_MENU_ENTRY
			step_cmd: EXEC_STEP
			step_button: EB_BUTTON
			step_menu_entry: EB_MENU_ENTRY
			nostop_cmd: EXEC_NOSTOP
			nostop_button: EB_BUTTON
			nostop_menu_entry: EB_MENU_ENTRY
			sep: SEPARATOR
			sep1, sep2, sep3: THREE_D_SEPARATOR
			run_final_cmd: EXEC_FINALIZED
			run_final_menu_entry: EB_MENU_ENTRY
			debug_quit_cmd: DEBUG_QUIT
			debug_quit_button: EB_BUTTON
			debug_quit_menu_entry: EB_MENU_ENTRY
			debug_run_cmd: DEBUG_RUN
			debug_run_button: EB_BUTTON
			debug_run_menu_entry: EB_MENU_ENTRY
			debug_status_cmd: DEBUG_STATUS
			debug_status_button: EB_BUTTON
			debug_status_menu_entry: EB_MENU_ENTRY
			display_exception_cmd: DISPLAY_CURRENT_STACK
			up_exception_stack_button: EB_BUTTON
			down_exception_stack_button: EB_BUTTON
			display_exception_menu_entry: EB_MENU_ENTRY
			do_nothing_cmd: DO_NOTHING_CMD
		do
			!! debug_run_cmd.make (Current)
			!! debug_run_button.make (debug_run_cmd, format_bar)
			!! debug_run_menu_entry.make (debug_run_cmd, menus @ debug_menu)
			!! debug_run_cmd_holder.make (debug_run_cmd, debug_run_button, debug_run_menu_entry)
			debug_run_button.add_third_button_action
			debug_run_button.set_action ("Ctrl<Btn1Down>", debug_run_cmd, debug_run_cmd.melt_and_run)


			!! debug_status_cmd.make (Current)
			!! debug_status_button.make (debug_status_cmd, format_bar)
			!! debug_status_menu_entry.make (debug_status_cmd, menus @ debug_menu)
			!! debug_status_cmd_holder.make (debug_status_cmd, debug_status_button, debug_status_menu_entry)

			!! display_exception_cmd.make (True, Current)
			!! up_exception_stack_button.make (display_exception_cmd, format_bar)
			!! display_exception_menu_entry.make (display_exception_cmd, menus @ debug_menu)
			!! up_exception_stack_holder.make (display_exception_cmd,
						up_exception_stack_button, display_exception_menu_entry)

			!! display_exception_cmd.make (False, Current)
			!! down_exception_stack_button.make (display_exception_cmd, format_bar)
			!! display_exception_menu_entry.make (display_exception_cmd, menus @ debug_menu)
			!! down_exception_stack_holder.make (display_exception_cmd,
						down_exception_stack_button, display_exception_menu_entry)

			!! debug_quit_cmd.make (Current)
			!! debug_quit_button.make (debug_quit_cmd, format_bar)
			!! debug_quit_menu_entry.make_button_only (debug_quit_cmd, menus @ debug_menu)
			!! debug_quit_cmd_holder.make (debug_quit_cmd, debug_quit_button, debug_quit_menu_entry)
			debug_quit_menu_entry.add_activate_action (debug_quit_cmd, debug_quit_cmd.kill_it)
			debug_quit_button.set_action ("c<Btn1Down>", debug_quit_cmd, debug_quit_cmd.kill_it)

			!! sep.make (new_name, menus @ debug_menu)

			!! step_cmd.make (Current)
			!! step_button.make (step_cmd, format_bar)
			!! step_menu_entry.make (step_cmd, menus @ debug_menu)
			!! exec_step_frmt_holder.make (step_cmd, step_button, step_menu_entry)

			!! step_out_cmd.make (Current)
			!! step_out_button.make (step_out_cmd, format_bar)
			!! step_out_menu_entry.make (step_out_cmd, menus @ debug_menu)
			!! exec_last_frmt_holder.make (step_out_cmd, step_out_button, step_out_menu_entry)

			!! nostop_cmd. make (Current)
			!! nostop_button.make (nostop_cmd, format_bar)
			!! nostop_menu_entry.make (nostop_cmd, menus @ debug_menu)
			!! exec_nostop_frmt_holder.make (nostop_cmd, nostop_button, nostop_menu_entry)

			!! run_final_cmd.make (Current)
			!! run_final_menu_entry.make (run_final_cmd, menus @ debug_menu)

			!! sep1.make (Interface_names.t_empty, format_bar)
			sep1.set_horizontal (False)

			!! sep2.make (Interface_names.t_empty, format_bar)
			sep2.set_horizontal (False)

			!! sep3.make (Interface_names.t_empty, format_bar)
			sep3.set_horizontal (False)

				--| Attachements for the debugging tools will be made from right to left
			format_bar.attach_right (debug_run_button, 0)
			format_bar.attach_top (debug_run_button, 0)

			format_bar.attach_top (sep1, 0)
			format_bar.attach_bottom (sep1, 0)
			format_bar.attach_right_widget (debug_run_button, sep1, 5)

			format_bar.attach_top (nostop_button, 0)
			format_bar.attach_right_widget (sep1, nostop_button, 5)
			format_bar.attach_top (step_out_button, 0)
			format_bar.attach_right_widget (nostop_button, step_out_button, 0)
			format_bar.attach_top (step_button, 0)
			format_bar.attach_right_widget (step_out_button, step_button, 0)

			format_bar.attach_top (sep2, 0)
			format_bar.attach_bottom (sep2, 0)
			format_bar.attach_right_widget (step_button, sep2, 5)

			format_bar.attach_top (debug_quit_button, 0)
			format_bar.attach_right_widget (sep2, debug_quit_button, 5)

			format_bar.attach_top (sep3, 0)
			format_bar.attach_bottom (sep3, 0)
			format_bar.attach_right_widget (debug_quit_button, sep3, 5)

			format_bar.attach_top (debug_status_button, 0)
			format_bar.attach_right_widget (sep3, debug_status_button, 5)
			format_bar.attach_top (down_exception_stack_button, 0)
			format_bar.attach_right_widget (debug_status_button, down_exception_stack_button, 0)
			format_bar.attach_top (up_exception_stack_button, 0)
			format_bar.attach_right_widget (down_exception_stack_button, up_exception_stack_button, 0)
			!! do_nothing_cmd
			format_bar.set_action ("c<Btn1Down>", do_nothing_cmd, Void)
		end

	build_compile_menu is
			-- Build the compile menu.
		local
			freeze_cmd: FREEZE_PROJECT
			finalize_cmd: FINALIZE_PROJECT
			precompile_cmd: PRECOMPILE_PROJECT
			c_compile_menu: MENU_PULL
			c_compilation: C_COMPILATION
			c_compilation_menu_entry: EB_MENU_ENTRY
			sep: SEPARATOR
		do
--			!! special_cmd.make (Current)
--			!! special_cmd_holder.make_plain (special_cmd)
-- This becomes a general purpose about box.

			!! freeze_cmd.make (Current)
			!! freeze_menu_entry.make (freeze_cmd, menus @ compile_menu)
			!! freeze_cmd_holder.make_plain (freeze_cmd)
			freeze_cmd_holder.set_menu_entry (freeze_menu_entry)

			!! finalize_cmd.make (Current)
			!! finalize_menu_entry.make (finalize_cmd, menus @ compile_menu)
			!! finalize_cmd_holder.make_plain (finalize_cmd)
			finalize_cmd_holder.set_menu_entry (finalize_menu_entry)

			!! precompile_cmd.make (Current)
			!! precompile_menu_entry.make (precompile_cmd, menus @ compile_menu)
			!! precompile_cmd_holder.make_plain (precompile_cmd)
			precompile_cmd_holder.set_menu_entry (precompile_menu_entry)

			!! sep.make (Interface_names.t_Empty, menus @ compile_menu)

			!! c_compile_menu.make (Interface_names.m_C_compilation, menus @ compile_menu)
			!! c_compilation.make_workbench
			!! c_compilation_menu_entry.make_default (c_compilation, c_compile_menu)
			!! c_compilation.make_final
			!! c_compilation_menu_entry.make_default (c_compilation, c_compile_menu)
		end

	attach_all is
			-- Adjust and attach main widgets together.
		local
			sep: THREE_D_SEPARATOR
		do
			global_form.attach_left (menu_bar, 0)
			global_form.attach_right (menu_bar, 0)
			global_form.attach_top (menu_bar, 0)

			global_form.attach_left (toolbar_parent, 0)
			global_form.attach_top_widget (menu_bar, toolbar_parent, 0)
			global_form.attach_right (toolbar_parent, 0)

			if Platform_constants.is_windows then
				!! sep.make (Interface_names.t_Empty, global_form)
				global_form.attach_top_widget (toolbar_parent, sep, 0)
				global_form.attach_left (sep, 0)
				global_form.attach_right (sep, 0)
				
				global_form.attach_top_widget (sep, global_verti_split_window, 0)
			else
				global_form.attach_top_widget (toolbar_parent, global_verti_split_window, 0)
			end

			global_form.attach_left (global_verti_split_window, 0)
			global_form.attach_right (global_verti_split_window, 0)
			global_form.attach_bottom (global_verti_split_window, 0)

			common_form.attach_left (hori_split_window, 0)
			common_form.attach_top (hori_split_window, 0)
			common_form.attach_right (hori_split_window, 0)
			common_form.attach_bottom (hori_split_window, 0)

			top_form.attach_left (top_verti_split_window, 0)
			top_form.attach_top (top_verti_split_window, 0)
			top_form.attach_right (top_verti_split_window, 0)
			top_form.attach_bottom (top_verti_split_window, 0)

			project_form.attach_left (text_window.widget, 0)
			project_form.attach_top (text_window.widget, 0)
			project_form.attach_right (text_window.widget, 0)
			project_form.attach_bottom (text_window.widget, 0)

			selector_form.attach_left(selector_part,0)
			selector_form.attach_top (selector_part, 0)
			selector_form.attach_right (selector_part, 0)
			selector_form.attach_bottom (selector_part, 0)

		end

	build_recent_project_menu_entries is
			-- Add the last open projects entries
		local
			environment_variable: EXECUTION_ENVIRONMENT
			last_opened_projects, project_file_name: STRING
			i, nb, pos, old_pos: INTEGER
			local_menu: MENU_PULL
			sep: SEPARATOR
			open_cmd: OPEN_PROJECT
			open_menu_entry: EB_MENU_ENTRY
		do
			!! environment_variable

				--| Need to put the string in SYSTEM_CONSTANTS
			last_opened_projects := environment_variable.get (Bench_Recent_Files)
			!! recent_project_list.make	
			recent_project_list.compare_objects

			if last_opened_projects /= Void then
				from
					!! local_menu.make (Interface_names.m_Recent_project, file_menu)
					menus.put (local_menu, recent_project_menu)
					nb := last_opened_projects.occurrences (';')
					old_pos := 1
					i := 0
				until
					i >= nb
				loop
					pos := last_opened_projects.index_of (';', old_pos + 1)
					project_file_name := last_opened_projects.substring (old_pos, pos - 1)
					old_pos := pos + 1
					i := i + 1
					!! open_cmd.make_from_project_file (Current, project_file_name)
					!! open_menu_entry.make (open_cmd, menus @ recent_project_menu)
					recent_project_list.extend (project_file_name)
				end
				if nb > 0 then
					!! sep.make (Interface_names.t_Empty, file_menu)
				end
			end
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
				saving_done := True
				!! last_opened_projects.make (512)
				project_file_name := clone (project_directory_name)
				if project_file_name.item (project_file_name.count) /= Directory_separator then
					project_file_name.append_character (Directory_separator)
				end
				project_file_name.append (clone (eiffel_project.system.name))
				project_file_name.append (clone (project_extension))
	
				if not recent_project_list.has (project_file_name) then
					last_opened_projects.append (project_file_name)
					last_opened_projects.append (";")
				else
					recent_project_list.prune (project_file_name)
					recent_project_list.put_front (project_file_name)
				end
	
				from
					recent_project_list.start
				until
					recent_project_list.after or else i >= 10
				loop
					last_opened_projects.append (recent_project_list.item)
					last_opened_projects.append (";")
					recent_project_list.forth
					i := i + 1
				end
				!! environment_variable
				environment_variable.put (last_opened_projects, Bench_Recent_Files)
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

	feature_part: ROUTINE_W
			-- Feature part of Current for debugging

	object_part: OBJECT_W
			-- Object part of Current for debugging

	selector_part: SELECTOR_W
			-- Selector part

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
		local
			t: INTEGER
		do
			t := dropped_stone.stone_type
			Result := t = Class_type or else
				t = Routine_type or else
				t = Explain_type or else
				t = Object_type or else
				t = Breakable_type or else
				t = Call_stack_type or else
				t = System_type
		end
 
feature -- Update
 
	process_class_syntax (a_stone: CL_SYNTAX_STONE) is
			-- Process class syntax stone.
		local
			new_tool: CLASS_W
		do
			new_tool := window_manager.class_window
			new_tool.display
			new_tool.process_class_syntax (a_stone)
		end

	process_ace_syntax (a_stone: ACE_SYNTAX_STONE) is
			-- Process ace syntax stone.
		do
			System_tool.display
			System_tool.process_ace_syntax (a_stone)
		end

	process_classi (a_stone: CLASSI_STONE) is
			-- Process dropped stone `a_stone'.
		local
			new_tool: CLASS_W
		do
			new_tool := window_manager.class_window
			new_tool.display
			new_tool.process_classi (a_stone)
		end
 
	process_class (a_stone: CLASSC_STONE) is
			-- Process dropped stone `a_stone'.
		local
			new_tool: CLASS_W
		do
			new_tool := window_manager.class_window
			new_tool.display
			new_tool.process_class (a_stone)
		end
 
	process_feature (a_stone: FEATURE_STONE) is
			-- Process dropped stone `a_stone'.
		local
			new_tool: ROUTINE_W
		do
			new_tool := window_manager.routine_window
			new_tool.display
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
			new_tool: OBJECT_W
		do
			new_tool := window_manager.object_window
			new_tool.display
			new_tool.process_object (a_stone)
		end
 
	process_error (a_stone: ERROR_STONE) is
			-- Process dropped stone `a_stone'.
		local
			new_tool: EXPLAIN_W
		do
			new_tool := window_manager.explain_window
			new_tool.display
			new_tool.process_any (a_stone)
		end
 
	process_system (a_stone: SYSTEM_STONE) is
			-- Process dropped stone `a_stone'.
		do
			System_tool.process_system (a_stone)
			System_tool.display
		end

	process_call_stack (dropped: CALL_STACK_STONE) is
			-- Accept all stone types
		do
			check
				is_running: Application.is_running and then
					Application.is_stopped
			end
			save_current_cursor_position
			if Application.current_execution_stack_number /= 
				dropped.level_number 		
			then
				Application.set_current_execution_stack (dropped.level_number)
				show_current_stoppoint
				show_current_object
				display_exception_stack
			end
		end
 
feature {NONE} -- Implementation

	add_tool_to_menu (a_tool: BAR_AND_TEXT a_menu: MENU_PULL) is
			-- Add a menu entry reflecting `a_tool' to `a_menu'.
		local
			sep: SEPARATOR
			entry: TOOL_MENU_ENTRY
			cmd: RAISE_TOOL_CMD
			a_font: FONT
			a_color: COLOR
		do
			if a_menu.children_count = 1 then
				!! sep.make (Interface_names.t_Empty, a_menu)
			end
			!! cmd.make (a_tool)
			!! entry.make (cmd, a_menu, a_tool)
			a_font := Graphical_resources.font.actual_value
			if a_font /= Void then
				entry.set_font (a_font)
			end
			a_color := Graphical_resources.background_color.actual_value
			if a_color /= Void then
				entry.set_background_color (a_color)
			end
			a_color := Graphical_resources.foreground_color.actual_value
			if a_color /= Void then
				entry.set_foreground_color (a_color)
			end
		end

	change_tool_in_menu (a_tool: BAR_AND_TEXT a_menu: MENU_PULL) is
			-- Change the entry in `a_menu' reflecting `a_tool'
			-- so that the entry has `a_tool.title' as text.
		local
			done: BOOLEAN
			list: ARRAYED_LIST [WIDGET]
			menu_entry: TOOL_MENU_ENTRY
			raise_cmd: RAISE_TOOL_CMD
		do
			from
				list := a_menu.children
				list.start
			until
				list.after or done
			loop
					-- Get rid of the separators.
				menu_entry ?= list.item
				if menu_entry /= Void and then menu_entry.tool = a_tool then
					menu_entry.set_text (a_tool.title)
					done := True
				else
					list.forth
				end
			end
		end

	remove_tool_from_menu (a_tool: BAR_AND_TEXT a_menu: MENU_PULL) is
			-- Remove menu entry reflecting `a_tool' from
			-- `a_menu'.
		local
			done: BOOLEAN
			list: ARRAYED_LIST [WIDGET]
			menu_entry: TOOL_MENU_ENTRY
			raise_cmd: RAISE_TOOL_CMD
		do
			from
				list := a_menu.children
				list.start
			until
				list.after or done
			loop
					-- Get rid of the separators.
				menu_entry ?= list.item
				if menu_entry /= Void and then menu_entry.tool = a_tool then
					menu_entry.destroy
					done := True
				else
					list.forth
				end
			end
			if list.count = 3 then
				remove_separator (list)
			end
		end

	remove_separator (list: ARRAYED_LIST [WIDGET]) is
			-- Remove the separator item from `list'
		require
			list_count_is_three: list.count = 3
		local
			done: BOOLEAN
			sep: SEPARATOR
		do
			from
				list.start
			until
				list.after or done
			loop
				sep ?= list.item
				if sep /= Void then
					sep.destroy
					done := True
				else
					list.forth
				end
			end
		end

	saved_cursor: CURSOR
			-- Saved cursor position for displaying the stack

feature -- Compile menu update

	update_compile_menu (is_precompiling: BOOLEAN) is
			-- When `is_precompiling' is True, we need to disable all the others entry.
			-- When `is_precompiling' is False, we need to disable the precompile entry.
		do
			if is_precompiling then
				melt_menu_entry.set_insensitive
				quick_melt_menu_entry.set_insensitive
				freeze_menu_entry.set_insensitive
				finalize_menu_entry.set_insensitive
			else
				precompile_menu_entry.set_insensitive
			end
		end

feature {DISPLAY_ROUTINE_PORTION} -- Implementation

	hide_feature_portion is
			-- Hide the feature potion and hide the menu entries
			-- regarding the feature tool.
		do
			shown_portions := shown_portions - 1

			feature_form.unmanage
			feature_part.close_windows

			menus.item (edit_feature_menu).button.set_insensitive
			menus.item (special_feature_menu).button.set_insensitive
			menus.item (format_feature_menu).button.set_insensitive
		end

	show_feature_portion is
			-- Show the feature portion and the menu entries
			-- regarding the feature tool.
		local
			mp: MOUSE_PTR
		do
			!! mp.set_watch_cursor
			shown_portions := shown_portions + 1
			feature_form.manage

			menus.item (edit_feature_menu).button.set_sensitive
			menus.item (special_feature_menu).button.set_sensitive
			menus.item (format_feature_menu).button.set_sensitive

			show_current_stoppoint
			mp.restore
		end

feature {NONE} -- Implementation

	hide_class_portion is
			-- Hide the feature potion and hide the menu entries
			-- regarding the feature tool.
		do
		end

	show_class_portion is
			-- Show the feature portion and the menu entries
			-- regarding the feature tool.
		local
		do
		end

feature {DISPLAY_OBJECT_PORTION} -- Implementation

	hide_object_portion is
			-- Hide the object portion and the menu entries
			-- regarding the feature tool.
		do
			shown_portions := shown_portions - 1

			object_form.unmanage
			object_part.close_windows

			menus.item (edit_object_menu).button.set_insensitive
			menus.item (special_object_menu).button.set_insensitive
			menus.item (format_object_menu).button.set_insensitive

		end

	show_object_portion is
			-- Show the object portion and the menu entries
			-- regarding the feature tool.
		local
			mp: MOUSE_PTR
		do
			!! mp.set_watch_cursor
			shown_portions := shown_portions + 1

			menus.item (edit_object_menu).button.set_sensitive
			menus.item (special_object_menu).button.set_sensitive
			menus.item (format_object_menu).button.set_sensitive

			object_form.manage

			show_current_object
			mp.restore
		end

	toolkit_is_motif: BOOLEAN is
			-- Is the toolkit motif?
		once
			Result := toolkit.name.is_equal ("MOTIF")
		end

feature -- Information

	display_system_info is
		local
			st: STRUCTURED_TEXT
		do
			st := structured_system_info
			if st /= Void then
				debug_window.clear_window
				debug_window.process_text (st)
				debug_window.set_top_character_position (0)
				debug_window.display
			end
		end

	display_welcome_info is
		do
			debug_window.clear_window
			debug_window.process_text (welcome_info)
			debug_window.set_top_character_position (0)
			debug_window.display
		end

	welcome_info: STRUCTURED_TEXT is
			-- Display information on how to launch EiffelBench.
		local
		do
			!! Result.make
			Result.add_new_line
			Result.add_comment_text ("To create or open a project using")
			Result.add_new_line
			Result.add_comment_text ("EiffelBench: On the File menu,")
			Result.add_new_line
			Result.add_comment_text ("click %"New...%" or %"Open...%".")
			Result.add_new_line
		ensure
			Result_not_void: Result /= Void
		end

	structured_system_info: STRUCTURED_TEXT is
		local
			root_class_name: STRING
			root_class_c: CLASS_C
			creation_name: STRING
			st: STRUCTURED_TEXT
		do
			if eiffel_project.system /= Void then	
				root_class_name:= clone(eiffel_system.root_class_name)

				!! st.make
				st.add_comment_text ("SYSTEM        : ")
				st.add_string (eiffel_system.name)

				if root_class_name /= Void then
					st.add_new_line
					st.add_comment_text("ROOT CLASS    : ")
					root_class_c := Eiffel_universe.compiled_classes_with_name (root_class_name).i_th(0).compiled_class
					root_class_name.to_upper
					st.add_classi(root_class_c.lace_class, root_class_name)

					creation_name := eiffel_ace.ast.root.creation_procedure_name
					if creation_name /= Void then
							-- We do have a creation routine in the Ace file
							--| This is not a precompilation or a fake compilation (root class = NONE)
						st.add_new_line
						st.add_comment_text ("CREATION      : ")
						st.add_feature_name (eiffel_ace.ast.root.creation_procedure_name, root_class_c)
					end

					st.add_new_line
					st.add_new_line
					st.add_comment_text ("ROOT CLUSTER  : ")
					st.add_string (eiffel_system.root_cluster.cluster_name)
					st.add_new_line
					st.add_comment_text ("ACE FILE      : ")
					st.add_string (eiffel_ace.file_name)
					st.add_new_line
					st.add_comment_text ("PROJECT PATH  : ")
					st.add_string (eiffel_project.name)
--					st.add_new_line
--					st.add_new_line
-- 					st.add_comment_text ("$EIFFEL4      = ")
-- 					st.add_string (execution_environment.get ("EIFFEL4"))
-- 					st.add_new_line
-- 					st.add_comment_text ("$PLATFORM     = ")
-- 					st.add_string (execution_environment.get ("PLATFORM"))
-- 					st.add_new_line
-- 					st.add_comment_text ("$COMPILER     = ")
-- 					st.add_string (execution_environment.get ("COMPILER"))
-- 					st.add_new_line
				end
				Result := st
			end
		end

end

