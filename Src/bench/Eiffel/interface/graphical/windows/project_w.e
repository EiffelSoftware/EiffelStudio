indexing

	description:	
		"The project window.";
	date: "$Date$";
	revision: "$Revision$"

class PROJECT_W

inherit

	TOOLTIP_INITIALIZER;
	TOOL_W
		redefine
			tool_name, process_system, process_error,
			process_object, process_breakable, process_class,
			process_classi, compatible, process_feature,
			process_class_syntax, process_ace_syntax, display,
			process_call_stack, force_raise, resources,
			update_graphical_resources
		end;
	COMMAND;
	BASE
		rename
			make as base_make
		export
			{GRAPHICAL_DEGREE_OUTPUT} implementation
		end;
	WINDOW_ATTRIBUTES;
	SYSTEM_CONSTANTS;
	EB_CONSTANTS;
	SHARED_APPLICATION_EXECUTION;
	SHARED_EIFFEL_PROJECT;
	RESOURCE_USER
		redefine
			update_integer_resource, update_boolean_resource,
			update_string_resource
		end;
	WIDGET_ROUTINES

feature -- Initialization

	make (a_screen: SCREEN) is
			-- Create a project application.
		local
			app_stopped_cmd: APPLICATION_STOPPED_CMD
		do
			General_resources.add_user (Current);
			Project_resources.add_user (Current);
			base_make (tool_name, a_screen);
			!! history.make;
			register;
			forbid_resize;
			build_widgets;
			set_title (Interface_names.t_Project);
			set_icon_name (tool_name);
			if Pixmaps.bm_Project_icon.is_valid then
				set_icon_pixmap (Pixmaps.bm_Project_icon)
			end;
			set_action ("<Unmap>,<Prop>", Current, popdown);
			set_action ("<Configure>", Current, remapped);
			set_action ("<Visible>", Current, remapped);
			set_delete_command (quit_cmd_holder.associated_command);
			set_font_to_default;
			!! app_stopped_cmd;
			Application.set_before_stopped_command (app_stopped_cmd);
			Application.set_after_stopped_command (app_stopped_cmd);
			set_default_position;
			set_composite_attributes (Current);
			realize;
			focus_label.initialize_focusables (Current);
			init_text_window;
		end;

feature -- Resource Update

	update_boolean_resource (old_res, new_res: BOOLEAN_RESOURCE) is
		local
			rout_cli_cmd: SHOW_ROUTCLIENTS;
			stop_cmd: SHOW_BREAKPOINTS;
			pr: like Project_resources;
			d_output: DEGREE_OUTPUT
		do
			pr := Project_resources
			if old_res = pr.command_bar then
				if new_res.actual_value then
					classic_bar.add
				else
					classic_bar.remove
				end
			elseif old_res = pr.graphical_output_disabled then
				if new_res.actual_value then	
					!! d_output;
				else
					!GRAPHICAL_DEGREE_OUTPUT! d_output;
				end;
				Eiffel_project.set_degree_output (d_output)
			elseif old_res = pr.format_bar then
				if new_res.actual_value then
					format_bar.add
				else
					format_bar.remove
				end
			elseif old_res = pr.debugger_show_all_callers then
				rout_cli_cmd ?=
					feature_part.showroutclients_frmt_holder.associated_command;
				rout_cli_cmd.set_show_all_callers (new_res.actual_value)
			elseif old_res = pr.debugger_do_flat_in_breakpoints then
				stop_cmd ?=
					feature_part.showstop_frmt_holder.associated_command;
				stop_cmd.set_format_mode (new_res.actual_value)
			end;
			old_res.update_with (new_res)
		end;

	update_string_resource (old_res, new_res: STRING_RESOURCE) is
		local
			gr: like General_resources
		do
			gr := General_resources
			if old_res = gr.filter_path then
				Eiffel_project.set_filter_path (new_res.value);
			elseif old_res = gr.profile_path then
				Eiffel_project.set_profile_path (new_res.value);
			elseif old_res = gr.tmp_path then
				Eiffel_project.set_tmp_directory (new_res.value);
			end;
			old_res.update_with (new_res)
		end;

	update_integer_resource (old_res, new: INTEGER_RESOURCE) is
		local
			pr: like Project_resources
		do
			pr := Project_resources
			if new.actual_value >= 0 then
				if old_res = pr.tool_x then
					set_x (new.actual_value)
				elseif old_res = pr.tool_y then
					set_y (new.actual_value)
				elseif old_res = pr.tool_width then
					set_width (new.actual_value)
				elseif old_res = pr.tool_height then
					if shown_portions = 1 then
						set_height (new.actual_value)
						if not toolkit_is_motif then
							split_window.set_height (real_project_height (implementation));
						end
					end
				elseif old_res = pr.interrupt_every_n_instructions then
					Application.set_interrupt_number (new.actual_value)
				elseif old_res = General_resources.tab_step then
					set_default_tab_length (new.actual_value);
					Window_manager.routine_win_mgr.set_tab_length_to_default;
					Window_manager.class_win_mgr.set_tab_length_to_default;
					Window_manager.object_win_mgr.set_tab_length_to_default;
					Window_manager.explain_win_mgr.set_tab_length_to_default;
					if System_tool.realized then
						System_tool.set_tab_length_to_default;
						System_tool.update_save_symbol
						if System_tool.text_window.is_graphical then	
							System_tool.synchronize
						end;
					end;
					if feature_part /= Void and then feature_form.managed then
						feature_part.set_tab_length_to_default 
						if  feature_part.text_window.is_graphical then
							feature_part.synchronize
						end
					end;
					if object_part /= Void and then object_form.managed then 
						object_part.set_tab_length_to_default 
						if object_part.text_window.is_graphical then
							object_part.synchronize
						end
					end;
					Project_tool.set_tab_length_to_default;
					if Project_tool.text_window.is_graphical then	
						Project_tool.synchronize
					end;
				end;
				old_res.update_with (new)
			end
		end;

	update_graphical_resources is
			-- Synchronize clickable elements with text, if possible
			-- and update the graphical values in text window.
		do
			initialize_text_window_resources;
			synchronize;
			if feature_part /= Void then
				feature_part.update_graphical_resources
			end;
			if object_part /= Void then
				object_part.update_graphical_resources
			end;
		end
	
feature -- Access

	resources: like Project_resources is
		do
			Result := Project_resources
		end;

	tooltip_parent: COMPOSITE is
			-- Tooltip parent is the project tool
		do
			Result := Current
		end;

	split_window: SPLIT_WINDOW;

	popdown: ANY is
		once
			!! Result
		end;

	remapped: ANY is
		once
			!! Result
		end;

	eb_shell: EB_SHELL is
		do
			Result := Void
		end;

	global_form: FORM is
		do
			Result := std_form
		end

feature -- Access

	kept_objects: LINKED_SET [STRING] is
			-- Hector addresses of displayed clickable objects
		do
			Result := text_window.kept_objects;
		end

feature -- Window Settings

	force_raise is
			-- Raise the project tool.
		do
			raise
		end;

	set_default_size is
		do
		end;

	set_default_position is
			-- Display the project tool at the 
			-- upper left corner of the screen.
		local
			default_x, default_y: INTEGER
		do
			default_x := Project_resources.tool_x.actual_value;
			default_y := Project_resources.tool_y.actual_value;
			set_x_y (default_x, default_y)
		end;
 
	set_initialized is
			-- Set `initialized' to true.
		do
			initialized := true
		ensure
			initialized = true
		end;

	display is
			-- Display Current on the screen
		do
		end;

feature -- Window Implementation

	popup_file_selection is
		do
			open_command.execute (Current);
		end;

feature -- Window Properties

	initialized: BOOLEAN;
			-- Is the workbench created?

	is_system_tool_hidden: BOOLEAN;
			-- Is the system tool hidden?

	is_name_chooser_hidden: BOOLEAN;
			-- Is the name chooser hidden?

	is_warner_hidden: BOOLEAN;
			-- Is the warner window hidden?

	is_confirmer_hidden: BOOLEAN;
			-- Is the confirmer window hidden?

	is_project_tool_hidden: BOOLEAN;
			-- Is the project tool hidden?

	is_preference_tool_hidden: BOOLEAN;
			-- Is the preference tool hidden?

	is_profile_tool_hidden: BOOLEAN;
			-- Is the profile tool hidden?

	eiffel_symbol: PIXMAP is
		do
			Result := Pixmaps.bm_Project
		end;

	tool_name: STRING is
		do
			Result := Interface_names.t_Project
		end;

feature -- Window Holders

	stop_points_hole_holder: HOLE_HOLDER;

	system_hole_holder: HOLE_HOLDER;

	class_hole_holder: HOLE_HOLDER;

	routine_hole_holder: HOLE_HOLDER;

	object_hole_holder: HOLE_HOLDER;

	explain_hole_holder: HOLE_HOLDER;

feature -- Pulldown Menus

	special_menu: MENU_PULL;
			-- Menu for commands.
			-- Only used during debugging

	format_menu: MENU_PULL;
			-- Menu for formats.
			-- Only used during debugging

	compile_menu: MENU_PULL;
			-- Compile menu.

	debug_menu: MENU_PULL;
			-- Debug menu.

	window_menu: MENU_PULL;
			-- Window menu.

	open_classes_menu: MENU_PULL;
			-- Menu for open class tools

	open_routines_menu: MENU_PULL;
			-- Menu for open feature tools

	open_objects_menu: MENU_PULL;
			-- Menu for open object tools

	open_explain_menu: MENU_PULL;
			-- Menu for open explain tools

	edit_feature_menu: MENU_PULL;
			-- Edit menu specific for the feature part

	special_feature_menu: MENU_PULL;
			-- Special menu specific for the feature part

	format_feature_menu: MENU_PULL;
			-- Format menu specific for the feature part

	edit_object_menu: MENU_PULL;
			-- Edit menu specific for the object part

	special_object_menu: MENU_PULL;
			-- Special menu specific for the object part

	format_object_menu: MENU_PULL;
			-- Format menu specific for the object part

feature -- Window Forms

	std_form: SPLIT_WINDOW_CHILD;
			-- Form on which the std protject tool is displayed

	feature_form: SPLIT_WINDOW_CHILD;
			-- Form on which the feature tool during debug will be shown

	object_form: SPLIT_WINDOW_CHILD;
			-- Form on which the object tool during debug will be shown

	classic_bar: TOOLBAR;
			-- Main menu bar

	format_bar: TOOLBAR;
			-- Format menu bar

feature -- Execution Implementation

	execute (arg: ANY) is
			-- Resize xterm window when drawing area is resized
		do
			if arg = remapped then
				if is_project_tool_hidden then
						-- The project tool is being deiconified.
					is_project_tool_hidden := False;
					window_manager.show_all_editors
					if is_profile_tool_hidden then
						is_profile_tool_hidden := False;
						Profile_tool.show
					end;
					if is_preference_tool_hidden then
						is_preference_tool_hidden := False;
						Preference_tool.show
					end;
					if is_system_tool_hidden then
						system_tool.show
						is_system_tool_hidden := False;
					elseif system_tool.in_use then
						system_tool.show
					end;
					raise
					if is_warner_hidden then
						is_warner_hidden := false;
						last_warner.popup
					end
					if is_confirmer_hidden then
						is_confirmer_hidden := false;
						last_confirmer.popup
					end
					if is_name_chooser_hidden then
						is_name_chooser_hidden := false;
						last_name_chooser.popup
					end
				else
						-- The project tool is being raised, moved or resized.
						-- Raise popups with an exclusive grab.
					raise_grabbed_popup
				end
			elseif arg = popdown then
				is_project_tool_hidden := True;
				window_manager.hide_all_editors;
				if 	system_tool.realized and then system_tool.shown then
					system_tool.hide;
					system_tool.close_windows;
					is_system_tool_hidden := True;
				end;
				if 	Preference_tool /= Void and then Preference_tool.shown then
					Preference_tool.hide;
					is_preference_tool_hidden := True;
				end;
				if 	Profile_tool /= Void and then Profile_tool.shown then
					Profile_tool.hide;
					is_profile_tool_hidden := True;
				end;
				if last_name_chooser /= Void and then last_name_chooser.is_popped_up then
					is_name_chooser_hidden := true;
					last_name_chooser.popdown
				end;	
				if last_warner /= Void and then last_warner.is_popped_up then
					is_warner_hidden := true;
					last_warner.popdown
				end;
				if 
					last_confirmer /= Void and then 
					last_confirmer.is_popped_up
				then
					is_confirmer_hidden := true;
					last_confirmer.popdown
				end
			end
		end;

feature -- Update

	synchronize_routine_tool_to_default is
			-- Synchronize the routine tool to the default format.
		do
			if feature_part /= Void and then feature_form.managed then	
				feature_part.set_default_format;
				feature_part.synchronize
			end;
		end

	close_windows is
			-- Close associated windows.
		do
		end;

	clear_object_tool is
			-- Clear the contents of the object tool if shown.
		do
			if object_part /= Void and then object_form.managed then	
				object_part.reset
			end
		end;

	resynchronize_debugger is
		do
			if feature_part /= Void and then feature_form.managed then
				feature_part.resynchronize_debugger (Void)
			end
		end;

	show_stoppoint (e_feature: E_FEATURE; index: INTEGER) is
			-- If stone feature is equal to feature `f' and if in debug
			-- mode then redisplay the sign of the `index'-th breakable point.
		require
			valid_feature: e_feature /= Void and then e_feature.body_id /= Void;
		local
			new_stone: FEATURE_STONE;
			display_cmd: DISPLAY_ROUTINE_PORTION;
		do
			display_cmd ?= display_feature_cmd_holder.associated_command;
			if display_cmd.is_shown and then
				index > 0
			then
				feature_part.show_stoppoint (e_feature, index)
			end
		end;

	show_current_stoppoint is
			-- Show breakable mark in the feature part if
			-- the part is displayed
		local
			status: APPLICATION_STATUS;
			display_cmd: DISPLAY_ROUTINE_PORTION;
			new_stone: FEATURE_STONE;
			call_stack: CALL_STACK_ELEMENT;
			e_feature: E_FEATURE;
			index: INTEGER
		do
			if Application.is_running and then 
				Application.is_stopped 
			then
				display_cmd ?= display_feature_cmd_holder.associated_command
				if display_cmd.is_shown then
					status := Application.status;
					if status.e_feature /= Void then
						call_stack := status.current_stack_element;
						if Application.current_execution_stack_number = 1 then
							e_feature := status.e_feature;
							index := status.break_index;
						else
							e_feature := call_stack.routine;
						end;
						feature_part.set_debug_format;
						!! new_stone.make (e_feature);
						feature_part.process_feature (new_stone);
						if index > 0 then
							feature_part.show_stoppoint (e_feature, index)
						end;
					end
				end
			end
		end;

	show_current_object is
			-- Show the current object in exception 
			-- stack in object tool portion.
		local
			display_cmd: DISPLAY_OBJECT_PORTION;
			new_stone: OBJECT_STONE;
			call_stack: CALL_STACK_ELEMENT;
			object_address: STRING;
			dynamic_class: E_CLASS;
			status: APPLICATION_STATUS
		do
			if Application.is_running and then 
				Application.is_stopped 
			then
				display_cmd ?= display_object_cmd_holder.associated_command
				if display_cmd.is_shown then
					status := Application.status;
					if status.e_feature /= Void then
						call_stack := status.current_stack_element;
						if Application.current_execution_stack_number = 1 then
							dynamic_class := status.dynamic_class;
							object_address := status.object_address;
						else
							dynamic_class := call_stack.dynamic_class;
							object_address := call_stack.object_address;
						end;
						!! new_stone.make (object_address, call_stack.routine_name, dynamic_class);
						if new_stone.same_as (object_part.stone) then
							object_part.synchronize
						else
							object_part.process_object (new_stone)
						end
					end
				end
			end
		end;

	display_exception_stack is
			-- Display the exception stack in the text window.
		local
			st: STRUCTURED_TEXT
		do
			!! st.make;
			Application.status.display_status (st);
			text_window.clear_window;
			text_window.process_text (st);
			text_window.display;
			if saved_cursor /= Void then
				text_window.go_to (saved_cursor);
			end;
		end;

	save_current_cursor_position is
			-- Save the current cursor position.
		do
			saved_cursor := text_window.cursor
		end;

	clear_cursor_position is
			-- Clear the saved cursor position.
		do
			saved_cursor := Void
		end;

	add_routine_entry (r_w: ROUTINE_W) is
		do
			add_tool_to_menu (r_w, open_routines_menu)
		end;

	change_routine_entry (r_w: ROUTINE_W) is
		do
			change_tool_in_menu (r_w, open_routines_menu)
		end;

	remove_routine_entry (r_w: ROUTINE_W) is
		do
			remove_tool_from_menu (r_w, open_routines_menu)
		end;

	add_class_entry (c_w: CLASS_W) is
		do
			add_tool_to_menu (c_w, open_classes_menu)
		end;

	change_class_entry (c_w: CLASS_W) is
		do
			change_tool_in_menu (c_w, open_classes_menu)
		end;

	remove_class_entry (c_w: CLASS_W) is
		do
			remove_tool_from_menu (c_w, open_classes_menu)
		end;

	add_object_entry (o_w: OBJECT_W) is
		do
			add_tool_to_menu (o_w, open_objects_menu)
		end;

	change_object_entry (o_w: OBJECT_W) is
		do
			change_tool_in_menu (o_w, open_objects_menu)
		end;

	remove_object_entry (o_w: OBJECT_W) is
		do
			remove_tool_from_menu (o_w, open_objects_menu)
		end;

	add_explain_entry (e_w: EXPLAIN_W) is
		do
			add_tool_to_menu (e_w, open_explain_menu)
		end;

	change_explain_entry (e_w: EXPLAIN_W) is
		do
			change_tool_in_menu (e_w, open_explain_menu)
		end;

	remove_explain_entry (e_w: EXPLAIN_W) is
		do
			remove_tool_from_menu (e_w, open_explain_menu)
		end

feature -- Graphical Interface

	build_widgets is
			-- Build widget.
		local
			default_width, default_height: INTEGER;
			sep: SEPARATOR
		do
			shown_portions := 1;

			default_width := Project_resources.tool_width.actual_value;
			default_height := Project_resources.tool_height.actual_value;
			set_size (default_width, default_height);

			!! split_window.make (new_name, Current);
			!! std_form.make (new_name, split_window);
			!! feature_form.make_unmanaged (new_name, split_window);
			!! object_form.make_unmanaged (new_name, split_window);

			create_toolbar_parent (std_form);

			build_menu;
			build_text_windows;
			build_top;
			build_compile_menu;
			!! sep.make (Interface_names.t_Empty, toolbar_parent);
			build_format_bar;
			build_toolbar_menu;
			exec_stop_frmt_holder.execute (Void);

			if Project_resources.command_bar.actual_value = False then
				classic_bar.remove
			end;
			if Project_resources.format_bar.actual_value = False then
				format_bar.remove
			end;

			attach_all
		end;

	build_menu is
			-- Build the menu bar
		local
			sep: SEPARATOR;
			case_storage_cmd: CASE_STORAGE;
			case_storage_menu_entry: EB_MENU_ENTRY;
			document_submenu: MENU_PULL;
			generate_doc_cmd: DOCUMENT_GENERATION;
			generate_menu_entry: EB_MENU_ENTRY;
			generate_submenu: MENU_PULL
		do
			!! menu_bar.make (new_name, std_form);
			!! file_menu.make (Interface_names.m_File, menu_bar);
			!! edit_menu.make (Interface_names.m_Edit, menu_bar);
			!! compile_menu.make (Interface_names.m_Compile, menu_bar);
			!! debug_menu.make (Interface_names.m_Debug, menu_bar);
			!! format_menu.make (Interface_names.m_Formats, menu_bar);
			!! special_menu.make (Interface_names.m_Special, menu_bar);
			!! window_menu.make (Interface_names.m_Windows, menu_bar);
			build_help_menu;
				--| Creation of empty menus that are disabled goes here,
				--| for we want to create the object and / or feature portion
				--| on demand and not on purpose.
			!! edit_feature_menu.make (Interface_names.m_Feature, edit_menu);
			edit_feature_menu.button.set_insensitive;
			!! edit_object_menu.make (Interface_names.m_Object, edit_menu);
			edit_object_menu.button.set_insensitive;

			!! sep.make (Interface_names.t_Empty, edit_menu);

			!! format_feature_menu.make (Interface_names.m_Feature, format_menu);
			format_feature_menu.button.set_insensitive;
			!! format_object_menu.make (Interface_names.m_Object, format_menu);
			format_object_menu.button.set_insensitive;

			!! sep.make (Interface_names.t_Empty, format_menu);

			!! special_feature_menu.make (Interface_names.m_Feature, special_menu);
			special_feature_menu.button.set_insensitive;
			!! special_object_menu.make (Interface_names.m_Object, special_menu);
			special_object_menu.button.set_insensitive;

			!! sep.make (Interface_names.t_Empty, special_menu);
			!! case_storage_cmd;
			!! case_storage_menu_entry.make_default (case_storage_cmd, special_menu);
			!! generate_submenu.make (Interface_names.m_Document, special_menu);
			!! generate_doc_cmd.make_flat;
			!! generate_menu_entry.make (generate_doc_cmd, generate_submenu);
			!! generate_doc_cmd.make_flat_short;
			!! generate_menu_entry.make (generate_doc_cmd, generate_submenu);
			!! generate_doc_cmd.make_short;
			!! generate_menu_entry.make (generate_doc_cmd, generate_submenu);
			!! generate_doc_cmd.make_text;
			!! generate_menu_entry.make (generate_doc_cmd, generate_submenu)
		end;

	build_toolbar_menu is
			-- Build the toolbar menu under the special sub menu.
		local
			sep: SEPARATOR;
			toolbar_t: TOGGLE_B
		do
			!! sep.make (Interface_names.t_Empty, special_menu);
			!! toolbar_t.make (classic_bar.identifier, special_menu);
			classic_bar.init_toggle (toolbar_t);
			!! toolbar_t.make (format_bar.identifier, special_menu);
			format_bar.init_toggle (toolbar_t)
		end;

	build_top is
			-- Build top bar
		local
			tool_action: TOOLS_MANAGEMENT;
			tool_action_menu_entry: EB_MENU_ENTRY;
			quit_cmd: QUIT_PROJECT;
			quit_button: EB_BUTTON;
			quit_menu_entry: EB_MENU_ENTRY;
			explain_cmd: EXPLAIN_HOLE;
			explain_button: EB_BUTTON_HOLE;
			explain_menu_entry: EB_MENU_ENTRY;
			system_cmd: SYSTEM_HOLE;
			system_button: EB_BUTTON_HOLE;
			system_menu_entry: EB_MENU_ENTRY;
			class_cmd: CLASS_HOLE;
			class_button: EB_BUTTON_HOLE;
			class_menu_entry: EB_MENU_ENTRY;
			routine_cmd: ROUTINE_HOLE;
			routine_button: EB_BUTTON_HOLE;
			routine_menu_entry: EB_MENU_ENTRY;
			shell_cmd: SHELL_COMMAND;
			shell_button: EB_BUTTON_HOLE;
			object_cmd: OBJECT_HOLE;
			object_button: EB_BUTTON_HOLE;
			object_menu_entry: EB_MENU_ENTRY;
			clear_bp_cmd: DEBUG_CLEAR_STOP_POINTS_HOLE;
			clear_bp_button: EB_BUTTON_HOLE;
			clear_bp_menu_entry: EB_MENU_ENTRY;
			stop_points_cmd: DEBUG_STOPIN_HOLE;
			stop_points_button: EB_BUTTON_HOLE;
			stop_points_menu_entry: EB_MENU_ENTRY;
			show_pref_cmd: SHOW_PREFERENCE_TOOL;
			show_pref_menu_entry: EB_MENU_ENTRY;
			show_prof_cmd: SHOW_PROFILE_TOOL;
			show_prof_menu_entry: EB_MENU_ENTRY;
			sep: SEPARATOR
			display_feature_cmd: DISPLAY_ROUTINE_PORTION;
			display_feature_button: EB_BUTTON;
			display_feature_menu_entry: EB_MENU_ENTRY;
			display_object_cmd: DISPLAY_OBJECT_PORTION;
			display_object_button: EB_BUTTON;
			display_object_menu_entry: EB_MENU_ENTRY
			update_cmd: UPDATE_PROJECT;
			update_button: EB_BUTTON;
			update_menu_entry: EB_MENU_ENTRY;
			quick_update_cmd: UPDATE_PROJECT;
			quick_update_button: EB_BUTTON;
			quick_update_menu_entry: EB_MENU_ENTRY;
			version_button: PUSH_B;
		do
			!! open_command;
			!! classic_bar.make (Interface_names.n_Command_bar_name, toolbar_parent);
			build_print_menu_entry;
			!! quit_cmd.make (Current);
			!! quit_menu_entry.make (quit_cmd, file_menu);
			!! quit_cmd_holder.make_plain (quit_cmd);
			quit_cmd_holder.set_menu_entry (quit_menu_entry);
			!! version_button.make (Version_number, help_menu);
			build_edit_menu (classic_bar);

				-- Close all command
			!! tool_action.make_close_all;
			!! tool_action_menu_entry.make_default (tool_action, window_menu);
			!! tool_action.make_raise_all;
			!! tool_action_menu_entry.make_default (tool_action, window_menu);
			!! sep.make (Interface_names.t_Empty, window_menu);

				-- Sub menus for open tools.
			!! open_explain_menu.make (Interface_names.m_Explain_tools, window_menu);
			!! open_classes_menu.make (Interface_names.m_Class_tools, window_menu);
			!! open_routines_menu.make (Interface_names.m_Feature_tools, window_menu);
			!! open_objects_menu.make (Interface_names.m_Object_tools, window_menu);
			!! sep.make (Interface_names.t_Empty, window_menu);

				-- Regular menu entries.
			!! explain_cmd.make (Current);
			!! explain_button.make (explain_cmd, classic_bar);
			!! explain_menu_entry.make (explain_cmd, open_explain_menu);
			!! explain_hole_holder.make (explain_cmd, explain_button, explain_menu_entry);
			!! system_cmd.make (Current);
			!! system_button.make (system_cmd, classic_bar);
			!! system_menu_entry.make (system_cmd, window_menu);
			!! system_hole_holder.make (system_cmd, system_button, system_menu_entry);
			!! class_cmd.make (Current);
			!! class_button.make (class_cmd, classic_bar);
			!! class_menu_entry.make (class_cmd, open_classes_menu);
			!! class_hole_holder.make (class_cmd, class_button, class_menu_entry);
			!! routine_cmd.make (Current);
			!! routine_button.make (routine_cmd, classic_bar);
			!! routine_menu_entry.make (routine_cmd, open_routines_menu);
			!! routine_hole_holder.make (routine_cmd, routine_button, routine_menu_entry);
			!! shell_cmd.make (Current);
			!! shell_button.make (shell_cmd, classic_bar);
			shell_button.add_third_button_action;
			!! object_cmd.make (Current);
			!! object_button.make (object_cmd, classic_bar);
			!! object_menu_entry.make (object_cmd, open_objects_menu);
			!! object_hole_holder.make (object_cmd, object_button, object_menu_entry);
			!! stop_points_cmd.make (Current);
			!! stop_points_button.make (stop_points_cmd, classic_bar);
			!! stop_points_menu_entry.make (stop_points_cmd, debug_menu);
			!! stop_points_hole_holder.make (stop_points_cmd, stop_points_button, stop_points_menu_entry);
			!! clear_bp_cmd.make (Current);
			!! clear_bp_button.make (clear_bp_cmd, classic_bar);
			clear_bp_button.set_action ("!c<Btn1Down>", 
						clear_bp_cmd, clear_bp_cmd.clear_it_action);
			!! clear_bp_menu_entry.make (clear_bp_cmd, debug_menu);
			!! clear_bp_cmd_holder.make (clear_bp_cmd, clear_bp_button, clear_bp_menu_entry);

			!! show_prof_cmd;
			!! show_prof_menu_entry.make_default (show_prof_cmd, window_menu);

			!! sep.make (Interface_names.t_Empty, window_menu);
			!! show_pref_cmd.make (Project_resources);
			!! show_pref_menu_entry.make_default (show_pref_cmd, window_menu);

			!! display_feature_cmd.make (Current);
			!! display_feature_button.make (display_feature_cmd, classic_bar);
			!! display_feature_menu_entry.make (display_feature_cmd, format_menu);
			!! display_feature_cmd_holder.make (display_feature_cmd, display_feature_button, display_feature_menu_entry);
			display_feature_cmd.set_holder (display_feature_cmd_holder);

			!! display_object_cmd.make (Current);
			!! display_object_button.make (display_object_cmd, classic_bar);
			!! display_object_menu_entry.make (display_object_cmd, format_menu);
			!! display_object_cmd_holder.make (display_object_cmd, display_object_button, display_object_menu_entry);
			display_object_cmd.set_holder (display_object_cmd_holder);

			!! update_cmd.make (Current);
			!! update_button.make (update_cmd, classic_bar);
			update_button.set_action ("!c<Btn1Down>", update_cmd, update_cmd.generate_code_only);
			!! update_menu_entry.make (update_cmd, compile_menu);
			!! update_cmd_holder.make (update_cmd, update_button, update_menu_entry);

			!! quick_update_cmd.make (Current);
			quick_update_cmd.set_quick_melt;
			!! quick_update_button.make (quick_update_cmd, classic_bar);
			quick_update_button.set_action ("!c<Btn1Down>", quick_update_cmd, quick_update_cmd.generate_code_only);
			!! quick_update_menu_entry.make (quick_update_cmd, compile_menu);
			!! quick_update_cmd_holder.make (quick_update_cmd, quick_update_button, quick_update_menu_entry);

			classic_bar.attach_left (explain_button, 0);
			classic_bar.attach_top (explain_button, 0);
			classic_bar.attach_left_widget (explain_button, system_button,0);
			classic_bar.attach_top (system_button, 0);
			classic_bar.attach_left_widget (system_button, class_button,0);
			classic_bar.attach_top (class_button, 0);
			classic_bar.attach_left_widget (class_button, routine_button, 0);
			classic_bar.attach_left_widget (routine_button, shell_button, 0);
			classic_bar.attach_top (routine_button, 0);
			classic_bar.attach_top (shell_button, 0);
			classic_bar.attach_left_widget (shell_button, object_button, 0);
			classic_bar.attach_top (object_button, 0);
			classic_bar.attach_left_widget (object_button, clear_bp_button, 0);
			classic_bar.attach_left_widget (clear_bp_button, stop_points_button, 0);
			classic_bar.attach_top (stop_points_button, 0);
			classic_bar.attach_top (clear_bp_button, 0);

			classic_bar.attach_right (quick_update_button, 0);
			classic_bar.attach_top (quick_update_button, 0);
			classic_bar.attach_top (update_button, 0);
			classic_bar.attach_top (search_cmd_holder.associated_button, 0);
			classic_bar.attach_right_widget (quick_update_button, update_button, 0);
			classic_bar.attach_right_widget (update_button, search_cmd_holder.associated_button, 3);

			classic_bar.attach_left_widget (stop_points_button, display_feature_button, 60);
			classic_bar.attach_top (display_feature_button, 0);
			classic_bar.attach_right_widget (display_feature_button, display_object_button, 0);
			classic_bar.attach_top (display_object_button, 0);
		end;

	build_format_bar is
			-- Build formatting buttons in `format_bar'.
		local
			last_cmd: EXEC_LAST;
			last_button: FORMAT_BUTTON;
			last_menu_entry: EB_TICKABLE_MENU_ENTRY;
			stop_cmd: EXEC_STOP;
			stop_button: FORMAT_BUTTON;
			stop_menu_entry: EB_TICKABLE_MENU_ENTRY;
			step_cmd: EXEC_STEP;
			step_button: FORMAT_BUTTON;
			step_menu_entry: EB_TICKABLE_MENU_ENTRY;
			nostop_cmd: EXEC_NOSTOP;
			nostop_button: FORMAT_BUTTON;
			nostop_menu_entry: EB_TICKABLE_MENU_ENTRY;
			sep: SEPARATOR;
			run_final_cmd: EXEC_FINALIZED;
			run_final_menu_entry: EB_MENU_ENTRY;
			debug_quit_cmd: DEBUG_QUIT;
			debug_quit_button: EB_BUTTON;
			debug_quit_menu_entry: EB_MENU_ENTRY;
			debug_run_cmd: DEBUG_RUN;
			debug_run_button: EB_BUTTON;
			debug_run_menu_entry: EB_MENU_ENTRY;
			debug_status_cmd: DEBUG_STATUS;
			debug_status_button: EB_BUTTON;
			debug_status_menu_entry: EB_MENU_ENTRY;
			display_exception_cmd: DISPLAY_CURRENT_STACK;
			up_exception_stack_button: EB_BUTTON;
			down_exception_stack_button: EB_BUTTON;
			display_exception_menu_entry: EB_MENU_ENTRY;
		do
			!! format_bar.make (Interface_names.n_Format_bar_name, toolbar_parent);

			!! debug_run_cmd.make (Current);
			!! debug_run_button.make (debug_run_cmd, format_bar);
			debug_run_button.add_third_button_action;
			debug_run_button.set_action ("!c<Btn1Down>", debug_run_cmd, debug_run_cmd.melt_and_run);
			!! debug_run_menu_entry.make (debug_run_cmd, debug_menu);
			!! debug_run_cmd_holder.make (debug_run_cmd, debug_run_button, debug_run_menu_entry);
			!! debug_status_cmd.make (Current);
			!! debug_status_button.make (debug_status_cmd, format_bar);
			!! debug_status_menu_entry.make (debug_status_cmd, debug_menu);
			!! debug_status_cmd_holder.make (debug_status_cmd, debug_status_button, debug_status_menu_entry);

			!! display_exception_cmd.make (True, Current);
			!! up_exception_stack_button.make (display_exception_cmd, format_bar);
			!! display_exception_menu_entry.make (display_exception_cmd, debug_menu);
			!! up_exception_stack_holder.make (display_exception_cmd,
						up_exception_stack_button, display_exception_menu_entry);

			!! display_exception_cmd.make (False, Current);
			!! down_exception_stack_button.make (display_exception_cmd, format_bar);
			!! display_exception_menu_entry.make (display_exception_cmd, debug_menu);
			!! down_exception_stack_holder.make (display_exception_cmd,
						down_exception_stack_button, display_exception_menu_entry);

			!! debug_quit_cmd.make (Current);
			!! debug_quit_button.make (debug_quit_cmd, format_bar);
			debug_quit_button.set_action ("!c<Btn1Down>", debug_quit_cmd, debug_quit_cmd.kill_it);
			!! debug_quit_menu_entry.make_button_only (debug_quit_cmd, debug_menu);
			debug_quit_button.add_activate_action (debug_quit_cmd, debug_quit_cmd.kill_it);
			!! debug_quit_cmd_holder.make (debug_quit_cmd, debug_quit_button, debug_quit_menu_entry);

			!! sep.make (new_name, debug_menu)

			!! stop_cmd.make (Current);
			!! stop_button.make (stop_cmd, format_bar)
			stop_button.set_action ("!c<Btn1Down>", stop_cmd, stop_cmd.Format_and_run);
			!! stop_menu_entry.make (stop_cmd, debug_menu);
			!! exec_stop_frmt_holder.make (stop_cmd, stop_button, stop_menu_entry);
			!! step_cmd.make (Current);
			!! step_button.make (step_cmd, format_bar);
			step_button.set_action ("!c<Btn1Down>", step_cmd, step_cmd.Format_and_run);
			!! step_menu_entry.make (step_cmd, debug_menu);
			!! exec_step_frmt_holder.make (step_cmd, step_button, step_menu_entry);
			!! last_cmd.make (Current);
			!! last_button.make (last_cmd, format_bar);
			last_button.set_action ("!c<Btn1Down>", last_cmd, last_cmd.Format_and_run);
			!! last_menu_entry.make (last_cmd, debug_menu);
			!! exec_last_frmt_holder.make (last_cmd, last_button, last_menu_entry);
			!! nostop_cmd. make (Current);
			!! nostop_button.make (nostop_cmd, format_bar);
			nostop_button.set_action ("!c<Btn1Down>", nostop_cmd, nostop_cmd.Format_and_run);
			!! nostop_menu_entry.make (nostop_cmd, debug_menu);
			!! exec_nostop_frmt_holder.make (nostop_cmd, nostop_button, nostop_menu_entry);

			!! sep.make (new_name, debug_menu)

			!! run_final_cmd.make (Current);
			!! run_final_menu_entry.make (run_final_cmd, debug_menu);

			format_bar.attach_left (stop_button, 0);
			format_bar.attach_top (stop_button, 0);
			format_bar.attach_top (step_button, 0);
			format_bar.attach_left_widget (stop_button, step_button, 0);
			format_bar.attach_top (last_button, 0);
			format_bar.attach_left_widget (step_button, last_button, 0);
			format_bar.attach_top (nostop_button, 0);
			format_bar.attach_left_widget (last_button, nostop_button, 0);

			format_bar.attach_right (debug_run_button, 0);
			format_bar.attach_top (debug_run_button, 0);
			format_bar.attach_right_widget (debug_run_button, 
					debug_status_button, 0);
			format_bar.attach_top (debug_status_button, 0);
			format_bar.attach_top (down_exception_stack_button, 0);
			format_bar.attach_right_widget (debug_status_button, 
					down_exception_stack_button, 0);
			format_bar.attach_top (up_exception_stack_button, 0);
			format_bar.attach_right_widget (down_exception_stack_button, 
					up_exception_stack_button, 0);
			format_bar.attach_right_widget (up_exception_stack_button, 
					debug_quit_button, 0);
			format_bar.attach_top (debug_quit_button, 0);
		end;

	build_compile_menu is
			-- Build the compile menu.
		local
			freeze_cmd: FREEZE_PROJECT;
			freeze_menu_entry: EB_MENU_ENTRY;
			finalize_cmd: FINALIZE_PROJECT;
			finalize_menu_entry: EB_MENU_ENTRY;
			precompile_cmd: PRECOMPILE_PROJECT;
			precompile_menu_entry: EB_MENU_ENTRY;
			c_compile_menu: MENU_PULL;
			c_compilation: C_COMPILATION;
			c_compilation_menu_entry: EB_MENU_ENTRY;
			sep: SEPARATOR
		do
--			!! special_cmd.make (Current);
--			!! special_cmd_holder.make_plain (special_cmd);
-- This becomes a general purpose about box.

			!! freeze_cmd.make (Current);
			!! freeze_menu_entry.make (freeze_cmd, compile_menu);
			!! freeze_cmd_holder.make_plain (freeze_cmd);
			freeze_cmd_holder.set_menu_entry (freeze_menu_entry);

			!! finalize_cmd.make (Current);
			!! finalize_menu_entry.make (finalize_cmd, compile_menu);
			!! finalize_cmd_holder.make_plain (finalize_cmd);
			finalize_cmd_holder.set_menu_entry (finalize_menu_entry);

			!! precompile_cmd.make (Current);
			!! precompile_menu_entry.make (precompile_cmd, compile_menu);
			!! precompile_cmd_holder.make_plain (precompile_cmd);
			precompile_cmd_holder.set_menu_entry (precompile_menu_entry)

			!! sep.make (Interface_names.t_Empty, compile_menu);

			!! c_compile_menu.make (Interface_names.m_C_compilation, compile_menu);
			!! c_compilation.make_workbench;
			!! c_compilation_menu_entry.make_default (c_compilation, c_compile_menu);
			!! c_compilation.make_final;
			!! c_compilation_menu_entry.make_default (c_compilation, c_compile_menu);
		end;

	attach_all is
			-- Adjust and attach main widgets together.
		do
			std_form.attach_left (menu_bar, 0);
			std_form.attach_right (menu_bar, 0);
			std_form.attach_top (menu_bar, 0);

			std_form.attach_left (toolbar_parent, 0);
			std_form.attach_top_widget (menu_bar, toolbar_parent, 0);
			std_form.attach_right (toolbar_parent, 0);

			std_form.attach_left (text_window.widget, 0);
			std_form.attach_top_widget (toolbar_parent, text_window.widget, 0);
			std_form.attach_right (text_window.widget, 0);
			std_form.attach_bottom (text_window.widget, 0);

			-- (text_window will resize when window grows)

			-- std_form.attach_left (xterminal, 5);
			-- std_form.attach_top_widget (text_window, xterminal, 5);
			-- std_form.attach_right (xterminal, 5);
			-- (xterminal will resize when window grows)
			-- std_form.attach_bottom (xterminal, 5);
		end;

feature {NONE} -- Properties

	shown_portions: INTEGER
			-- Number of portions that are shown

	feature_part: ROUTINE_W
			-- Feature part of Current for debugging

	object_part: OBJECT_W
			-- Object part of Current for debugging

feature -- System Execution Modes

	exec_stop_frmt_holder: FORMAT_HOLDER;
			-- Set execution format so that user-defined stop
			-- points will be taken into account

	exec_nostop_frmt_holder: FORMAT_HOLDER;
			-- Set execution format so that no stop points will
			-- be taken into account

	exec_step_frmt_holder: FORMAT_HOLDER;
			-- Set execution format so that each breakable points
			-- of the current routine will be taken into account

	exec_last_frmt_holder: FORMAT_HOLDER;
			-- Set execution format so that only the last
			-- breakable point of the current routine will be
			-- taken into account

feature -- Commands

	open_command: OPEN_PROJECT;

	quit_cmd_holder: COMMAND_HOLDER;

	update_cmd_holder: COMMAND_HOLDER;

	quick_update_cmd_holder: COMMAND_HOLDER;

	debug_run_cmd_holder: COMMAND_HOLDER;

	debug_status_cmd_holder: COMMAND_HOLDER;

	debug_quit_cmd_holder: COMMAND_HOLDER;

	clear_bp_cmd_holder: COMMAND_HOLDER;

	special_cmd_holder: COMMAND_HOLDER;

	freeze_cmd_holder: COMMAND_HOLDER;

	finalize_cmd_holder: COMMAND_HOLDER;

	precompile_cmd_holder: COMMAND_HOLDER;

	display_feature_cmd_holder: COMMAND_HOLDER;

	display_object_cmd_holder: COMMAND_HOLDER;

	up_exception_stack_holder: COMMAND_HOLDER;

	down_exception_stack_holder: COMMAND_HOLDER;

feature -- Hole access
 
	compatible (dropped_stone: STONE): BOOLEAN is
			-- Is current hole compatible with `dropped_stone'?
		local
			t: INTEGER
		do
			t := dropped_stone.stone_type;
			Result := t = Class_type or else
				t = Routine_type or else
				t = Explain_type or else
				t = Object_type or else
				t = Breakable_type or else
				t = Call_stack_type or else
				t = System_type
		end;
 
feature -- Update
 
	process_class_syntax (a_stone: CL_SYNTAX_STONE) is
			-- Process class syntax stone.
		local
			new_tool: CLASS_W
		do
			new_tool := window_manager.class_window;
			new_tool.display
			new_tool.process_class_syntax (a_stone);
		end;

	process_ace_syntax (a_stone: ACE_SYNTAX_STONE) is
			-- Process ace syntax stone.
		do
			System_tool.display;
			System_tool.process_ace_syntax (a_stone)
		end;

	process_classi (a_stone: CLASSI_STONE) is
			-- Process dropped stone `a_stone'.
		local
			new_tool: CLASS_W
		do
			new_tool := window_manager.class_window;
			new_tool.display;
			new_tool.process_classi (a_stone)
		end;
 
	process_class (a_stone: CLASSC_STONE) is
			-- Process dropped stone `a_stone'.
		local
			new_tool: CLASS_W
		do
			new_tool := window_manager.class_window;
			new_tool.display;
			new_tool.process_class (a_stone);
		end;
 
	process_feature (a_stone: FEATURE_STONE) is
			-- Process dropped stone `a_stone'.
		local
			new_tool: ROUTINE_W
		do
			new_tool := window_manager.routine_window;
			new_tool.display;
			new_tool.process_feature (a_stone)
		end;
 
	process_breakable (a_stone: BREAKABLE_STONE) is
			-- Process dropped stone `a_stone'.
		local
			stop_points_button: EB_BUTTON_HOLE		
		do
			stop_points_button := stop_points_hole_holder.associated_button;
			stop_points_button.associated_command.process_breakable (a_stone)
		end;
 
	process_object (a_stone: OBJECT_STONE) is
			-- Process dropped stone `a_stone'.
		local
			new_tool: OBJECT_W
		do
			new_tool := window_manager.object_window;
			new_tool.display;
			new_tool.process_object (a_stone)
		end;
 
	process_error (a_stone: ERROR_STONE) is
			-- Process dropped stone `a_stone'.
		local
			new_tool: EXPLAIN_W
		do
			new_tool := window_manager.explain_window;
			new_tool.display;
			new_tool.process_any (a_stone)
		end;
 
	process_system (a_stone: SYSTEM_STONE) is
			-- Process dropped stone `a_stone'.
		do
			System_tool.process_system (a_stone)
			System_tool.display
		end;

	process_call_stack (dropped: CALL_STACK_STONE) is
			-- Accept all stone types
		do
			check
				is_running: Application.is_running and then
					Application.is_stopped
			end;
			save_current_cursor_position;
			if Application.current_execution_stack_number /= 
				dropped.level_number 		
			then
				Application.set_current_execution_stack (dropped.level_number);
				show_current_stoppoint;
				show_current_object;
				display_exception_stack
			end
		end;
 
feature {NONE} -- Implementation

	add_tool_to_menu (a_tool: BAR_AND_TEXT; a_menu: MENU_PULL) is
			-- Add a menu entry reflecting `a_tool' to `a_menu'.
		local
			sep: SEPARATOR;
			entry: TOOL_MENU_ENTRY;
			cmd: RAISE_TOOL_CMD;
			a_font: FONT;
			a_color: COLOR
		do
			if a_menu.children_count = 1 then
				!! sep.make (Interface_names.t_Empty, a_menu);
			end
			!! cmd.make (a_tool)
			!! entry.make (cmd, a_menu, a_tool)
			a_font := Graphical_resources.font.actual_value;
			if a_font /= Void then
				entry.set_font (a_font)
			end;
			a_color := Graphical_resources.background_color.actual_value;
			if a_color /= Void then
				entry.set_background_color (a_color)
			end;
			a_color := Graphical_resources.foreground_color.actual_value;
			if a_color /= Void then
				entry.set_foreground_color (a_color)
			end
		end;

	change_tool_in_menu (a_tool: BAR_AND_TEXT; a_menu: MENU_PULL) is
			-- Change the entry in `a_menu' reflecting `a_tool'
			-- so that the entry has `a_tool.title' as text.
		local
			done: BOOLEAN;
			list: ARRAYED_LIST [WIDGET];
			menu_entry: TOOL_MENU_ENTRY;
			raise_cmd: RAISE_TOOL_CMD
		do
			from
				list := a_menu.children
				list.start
			until
				list.after or done
			loop
					-- Get rid of the separators.
				menu_entry ?= list.item;
				if menu_entry /= Void and then menu_entry.tool = a_tool then
					menu_entry.set_text (a_tool.title);
					done := True
				else
					list.forth
				end
			end
		end;

	remove_tool_from_menu (a_tool: BAR_AND_TEXT; a_menu: MENU_PULL) is
			-- Remove menu entry reflecting `a_tool' from
			-- `a_menu'.
		local
			done: BOOLEAN;
			list: ARRAYED_LIST [WIDGET];
			menu_entry: TOOL_MENU_ENTRY;
			raise_cmd: RAISE_TOOL_CMD
		do
			from
				list := a_menu.children
				list.start
			until
				list.after or done
			loop
					-- Get rid of the separators.
				menu_entry ?= list.item;
				if menu_entry /= Void and then menu_entry.tool = a_tool then
					menu_entry.destroy;
					done := True
				else
					list.forth
				end
			end
			if list.count = 3 then
				remove_separator (list)
			end
		end;

	remove_separator (list: ARRAYED_LIST [WIDGET]) is
			-- Remove the separator item from `list'
		require
			list_count_is_three: list.count = 3
		local
			done: BOOLEAN;
			sep: SEPARATOR
		do
			from
				list.start
			until
				list.after or done
			loop
				sep ?= list.item;
				if sep /= Void then
					sep.destroy;
					done := True
				else
					list.forth
				end
			end
		end;

	saved_cursor: CURSOR;
			-- Saved cursor position for displaying the stack

feature {DISPLAY_ROUTINE_PORTION} -- Implementation

	feature_height: INTEGER; 
			-- Height with which the feature portion is shown.

	hide_feature_portion is
			-- Hide the feature potion and hide the menu entries
			-- regarding the feature tool.
		local
			h: INTEGER
		do
			shown_portions := shown_portions - 1;
			allow_resize;
			feature_height := feature_form.height;
			feature_form.unmanage;
			if not toolkit_is_motif then
				h := real_project_height (implementation);

				set_height (height - feature_height)
				split_window.set_height (h - feature_height)
			end;
			forbid_resize;
			feature_part.close_windows;

			if shown_portions /= 2 then
				edit_menu.button.set_insensitive;
			end;

			edit_feature_menu.button.set_insensitive;
			special_feature_menu.button.set_insensitive;
			format_feature_menu.button.set_insensitive;

		end;

	show_feature_portion is
			-- Show the feature portion and the menu entries
			-- regarding the feature tool.
		local
			new_height, real_height: INTEGER;
			mp: MOUSE_PTR;
			off: INTEGER
		do
			!! mp.set_watch_cursor;
			if feature_part = Void then
				feature_form.unmanage;
				!! feature_part.form_create (feature_form, edit_feature_menu, format_feature_menu,
						special_feature_menu);
				feature_height := 
					Project_resources.debugger_feature_height.actual_value;
			else
				feature_height := feature_form.height
			end;

			shown_portions := shown_portions + 1;

			edit_feature_menu.button.set_sensitive;
			special_feature_menu.button.set_sensitive;
			format_feature_menu.button.set_sensitive;
			if shown_portions = 2 then
				edit_menu.button.set_sensitive
			end;

			allow_resize;
			new_height := height + feature_height;
			real_height := real_project_height (implementation) + feature_height;
			feature_form.set_height (feature_height);
			feature_form.manage;
			off := Project_resources.bottom_offset.actual_value;
			if not toolkit_is_motif then
				if y + new_height > screen.height - off then
					new_height := screen.height - off - y;
					real_height := new_height
				end;
				set_height (new_height);
				split_window.set_height (real_height);
			end;
			forbid_resize;

			show_current_stoppoint;
			mp.restore
		end;

feature {DISPLAY_OBJECT_PORTION} -- Implementation

	object_height: INTEGER;
			-- Height with which the object portion is shown

	hide_object_portion is
			-- Hide the object portion and the menu entries
			-- regarding the feature tool.
		local
			h: INTEGER
		do
			shown_portions := shown_portions - 1;

			allow_resize;
			object_height := object_form.height;
			h := real_project_height (implementation);
			object_form.unmanage;
			if not toolkit_is_motif then
				h := real_project_height (implementation);
				set_height (height - object_height)
				split_window.set_height (h - object_height);
			end;
			forbid_resize;
			object_part.close_windows;

			if shown_portions /= 2 then
				edit_menu.button.set_insensitive;
			end;

			edit_object_menu.button.set_insensitive;
			special_object_menu.button.set_insensitive;
			format_object_menu.button.set_insensitive;

		end;

	show_object_portion is
			-- Show the object portion and the menu entries
			-- regarding the feature tool.
		local
			new_height: INTEGER;
			new_pos: INTEGER;
			mp: MOUSE_PTR;
			off: INTEGER;
			real_height: INTEGER
		do
			!! mp.set_watch_cursor;
			if object_part = Void then
				!! object_part.form_create (object_form, edit_object_menu, format_object_menu,
						special_object_menu);
				object_height := 
					Project_resources.debugger_object_height.actual_value;
			else
				object_height := object_form.height
			end;

			shown_portions := shown_portions + 1;
			new_pos := 6 // shown_portions;

			edit_object_menu.button.set_sensitive;
			special_object_menu.button.set_sensitive;
			format_object_menu.button.set_sensitive;
			if shown_portions = 2 then
				edit_menu.button.set_sensitive
			end;

			new_height := height + object_height;
			real_height := real_project_height (implementation) + object_height;
			off := Project_resources.bottom_offset.actual_value;
			allow_resize;
			object_form.set_height (object_height);
			object_form.manage;
			if not toolkit_is_motif then
				if y + new_height > screen.height - off then
					new_height := screen.height - off - y;
					real_height := new_height
				end;
				set_height (new_height);
				split_window.set_height (real_height);
			end;
			forbid_resize;
			show_current_object;
			mp.restore
		end;

	toolkit_is_motif: BOOLEAN is
			-- Is the toolkit motif?
		do
			Result := toolkit.name.is_equal ("MOTIF")
		end

end -- class PROJECT_W
