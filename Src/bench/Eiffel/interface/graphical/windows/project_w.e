indexing

	description:	
		"The project window.";
	date: "$Date$";
	revision: "$Revision$"

class PROJECT_W

inherit

	TOOL_W
		redefine
			text_window, tool_name, process_system, process_error,
			process_object, process_breakable, process_class,
			process_classi, compatible, process_feature,
			process_class_syntax, process_ace_syntax
		end;
	COMMAND;
	BASE
		rename
			make as base_make
		end;
	EXCEPTIONS
		rename
			raise as raise_exception
		end;
	SET_WINDOW_ATTRIBUTES;
	SHARED_APPLICATION_EXECUTION;
	EXECUTION_ENVIRONMENT;
	INTERFACE_W

creation

	make

feature -- Initialization

	make is
			-- Create a project application.
		local
			a_screen: SCREEN;
			app_stopped_cmd: APPLICATION_STOPPED_CMD
		do
			a_screen := ebench_display;
			base_make (tool_name, a_screen);
			!! history.make;
			register;
			forbid_resize;
			build_widgets;
			set_title (l_project);
			set_icon_name (tool_name);
			set_default_position;
			realize;
			if bm_Project_icon.is_valid then
				set_icon_pixmap (bm_Project_icon);
			end;
			set_action ("<Unmap>,<Prop>", Current, popdown);
			set_action ("<Configure>", Current, remapped);
			set_action ("<Visible>", Current, remapped);
			set_delete_command (quit_cmd_holder.associated_command);
			set_composite_attributes (Current);
			text_window.set_font_to_default;
			!! app_stopped_cmd;
			Application.set_before_stopped_command (app_stopped_cmd);
			Application.set_after_stopped_command (app_stopped_cmd);
		end;

feature -- Properties

	popdown: ANY is
		once
			!! Result
		end;

	remapped: ANY is
		once
			!! Result
		end;

	ebench_display: SCREEN is
		local
			display_name: STRING;
		do
			!! Result.make ("");
			if not Result.is_valid then
				io.error.putstring ("Cannot open display %"");
				display_name := get ("DISPLAY");
				if display_name /= Void then
					io.error.putstring (display_name);
				end;
				io.error.putstring ("%"%N%
					%Check that $DISPLAY is properly set and that you are%N%
					%authorized to connect to the corresponding server%N");
				raise_exception ("Invalid display");
			end;
		end;

feature -- Access

	kept_objects: LINKED_SET [STRING] is
			-- Hector addresses of displayed clickable objects
		do
			Result := text_window.kept_objects;
		end

feature -- Window Settings

	set_default_size is
		do
		end;

	set_default_position is
			-- Display the project tool at the 
			-- upper left corner of the screen.
		do
			set_x_y (0, 0)
		end;
 
	set_initialized is
			-- Set `initialized' to true.
		do
			initialized := true
		ensure
			initialized = true
		end;

	set_changed (f: BOOLEAN) is
			-- Assign `f' to `changed'.
		do
			changed := f
		end

feature -- Window Implementation

	close_windows is 
		local
			cf: CHANGE_FONT
		do 
			cf ?= change_font_cmd_holder.associated_command;
			cf.close
		end;

	popup_file_selection is
		do
			open_command.execute (text_window);
		end;

feature -- Window Properties

	changed: BOOLEAN;
			-- Is or has the window changed?

	initialized: BOOLEAN;
			-- Is the workbench created?

	is_system_window_hidden: BOOLEAN;
			-- Is the system window hidden?

	is_name_chooser_hidden: BOOLEAN;
			-- Is the name chooser hidden?

	is_warner_hidden: BOOLEAN;
			-- Is the warner window hidden?

	is_confirmer_hidden: BOOLEAN;
			-- Is the confirmer window hidden?

	is_project_tool_hidden: BOOLEAN;
			-- Is the project tool hidden?

	eiffel_symbol: PIXMAP is
		do
			Result := bm_Project
		end;

	tool_name: STRING is
		do
			Result := l_Project
		end;

	text_window: PROJECT_TEXT;
			-- Text window associated with Current.

feature -- Window Holes

	stop_points_hole_holder: HOLE_HOLDER;

	system_hole_holder: HOLE_HOLDER;

	class_hole_holder: HOLE_HOLDER;

	routine_hole_holder: HOLE_HOLDER;

	object_hole_holder: HOLE_HOLDER;

	explain_hole_holder: HOLE_HOLDER;

feature -- Pulldown Menus

	menu_bar: BAR;
			-- Menu bar in the top section of the window.

	file_menu: MENU_PULL;
			-- File menu.

	compile_menu: MENU_PULL;
			-- Compile menu.

	debug_menu: MENU_PULL;
			-- Debug menu.

	preference_menu: MENU_PULL;
			-- Preference menu.

	window_menu: MENU_PULL;
			-- Window_menu.

	help_menu: MENU_PULL;
			-- Help menu.

feature -- Window Forms

	icing: FORM;
			-- Icing form with global command buttons

	form_manager: FORM;
			-- Manager of constraints on sub widgets.

	classic_bar: FORM;
			-- Main menu bar

	format_bar: FORM;
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
					if is_system_window_hidden then
						system_tool.show
						is_system_window_hidden := False;
					elseif system_tool.text_window.in_use then
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
						name_chooser.popup
					end
				else
						-- The project tool is being raised, moved or resized.
						-- Raise popups with an exclusive grab.
					raise_grabbed_popup
				end
			elseif arg = popdown then
				is_project_tool_hidden := True;
				close_windows;
				window_manager.hide_all_editors;
				if 	system_tool.realized and then system_tool.shown then
					system_tool.hide;
					system_tool.close_windows;
					is_system_window_hidden := True;
				end;
				if name_chooser.is_popped_up then
					is_name_chooser_hidden := true;
					name_chooser.popdown
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

feature -- Graphical Interface

	build_widgets is
			-- Build widget.
		do
			set_size (478, 340);
			!! form_manager.make (new_name, Current);
			build_menu;
			build_text;
			build_top;
			build_icing;
			build_format_bar;
			exec_stop_frmt_holder.execute (Void);
			attach_all
		end;

	build_menu is
			-- Build the menu bar
		do
			!! menu_bar.make (new_name, form_manager);
			!! file_menu.make ("File", menu_bar);
			!! compile_menu.make ("Compile", menu_bar);
			!! debug_menu.make ("Debug", menu_bar);
			!! preference_menu.make ("Preference", menu_bar);
			!! window_menu.make ("Windows", menu_bar);
			!! help_menu.make ("Help", menu_bar);
			menu_bar.set_help_button (help_menu.menu_button);
		end;

	build_top is
			-- Build top bar
		local
			quit_cmd: QUIT_PROJECT;
			quit_button: EB_BUTTON;
			quit_menu_entry: EB_MENU_ENTRY;
			change_font_cmd: CHANGE_FONT;
			change_font_button: EB_BUTTON;
			change_font_menu_entry: EB_MENU_ENTRY;
			explain_cmd: EXPLAIN_CMD;
			explain_button: EXPLAIN_HOLE;
			explain_menu_entry: EB_MENU_ENTRY;
			system_cmd: SYSTEM_CMD;
			system_button: SYSTEM_HOLE;
			system_menu_entry: EB_MENU_ENTRY;
			class_cmd: CLASS_CMD;
			class_button: CLASS_HOLE;
			class_menu_entry: EB_MENU_ENTRY;
			routine_cmd: ROUTINE_CMD;
			routine_button: ROUTINE_HOLE;
			routine_menu_entry: EB_MENU_ENTRY;
			object_cmd: OBJECT_CMD;
			object_button: OBJECT_HOLE;
			object_menu_entry: EB_MENU_ENTRY;
			stop_points_cmd: DEBUG_STOPIN_CMD;
			stop_points_button: DEBUG_STOPIN;
			stop_points_menu_entry: EB_MENU_ENTRY;
		do
			!! open_command.make (text_window);
			!! classic_bar.make (new_name, form_manager);

			!! quit_cmd.make (text_window);
			!! quit_button.make (quit_cmd, classic_bar);
			!! quit_menu_entry.make (quit_cmd, file_menu);
			!! quit_cmd_holder.make (quit_cmd, quit_button, quit_menu_entry);
			!! explain_cmd.make (text_window);
			!! explain_button.make (explain_cmd, classic_bar);
			!! explain_menu_entry.make (explain_cmd, help_menu);
			!! explain_hole_holder.make (explain_cmd, explain_button, explain_menu_entry);
			!! system_cmd.make (text_window);
			!! system_button.make (system_cmd, classic_bar);
			!! system_menu_entry.make (system_cmd, window_menu);
			!! system_hole_holder.make (system_cmd, system_button, system_menu_entry);
			!! class_cmd.make (text_window);
			!! class_button.make (class_cmd, classic_bar);
			!! class_menu_entry.make (class_cmd, window_menu);
			!! class_hole_holder.make (class_cmd, class_button, class_menu_entry);
			!! routine_cmd.make (text_window);
			!! routine_button.make (routine_cmd, classic_bar);
			!! routine_menu_entry.make (routine_cmd, window_menu);
			!! routine_hole_holder.make (routine_cmd, routine_button, routine_menu_entry);
			!! object_cmd.make (text_window);
			!! object_button.make (object_cmd, classic_bar);
			!! object_menu_entry.make (object_cmd, window_menu);
			!! object_hole_holder.make (object_cmd, object_button, object_menu_entry);
			!! stop_points_cmd.make (text_window);
			!! stop_points_button.make (stop_points_cmd, classic_bar);
			!! stop_points_menu_entry.make (stop_points_cmd, window_menu);
			!! stop_points_hole_holder.make (stop_points_cmd, stop_points_button, stop_points_menu_entry);
			!! change_font_cmd.make (text_window);
			!! change_font_button.make (change_font_cmd, classic_bar);
			!! change_font_menu_entry.make (change_font_cmd, preference_menu);
			if not change_font_cmd.tabs_disabled then
				change_font_button.add_button_click_action (3, change_font_cmd, change_font_cmd.tab_setting)
			end;
			!! change_font_cmd_holder.make (change_font_cmd, change_font_button, change_font_menu_entry);

			classic_bar.attach_left (explain_button, 0);
			classic_bar.attach_top (explain_button, 0);
			classic_bar.attach_bottom (explain_button, 0);
			classic_bar.attach_left_widget (explain_button, system_button,0);
			classic_bar.attach_top (system_button, 0);
			classic_bar.attach_bottom (system_button, 0);
			classic_bar.attach_left_widget (system_button, class_button,0);
			classic_bar.attach_top (class_button, 0);
			classic_bar.attach_bottom (class_button, 0);
			classic_bar.attach_left_widget (class_button, routine_button, 0);
			classic_bar.attach_top (routine_button, 0);
			classic_bar.attach_bottom (routine_button, 0);
			classic_bar.attach_left_widget (routine_button, object_button, 0);
			classic_bar.attach_top (object_button, 0);
			classic_bar.attach_bottom (object_button, 0);
			classic_bar.attach_left_widget (object_button, stop_points_button, 0);
			classic_bar.attach_top (stop_points_button, 0);
			classic_bar.attach_bottom (stop_points_button, 0);
			classic_bar.attach_top (change_font_button, 0);
			classic_bar.attach_bottom (change_font_button, 0);
			classic_bar.attach_right_widget (quit_button, change_font_button, 0);
			classic_bar.attach_top (quit_button, 0);
			classic_bar.attach_bottom (quit_button, 0);
			classic_bar.attach_right (quit_button, 23);

		end;

	build_text is
			-- Build console text window.
		do
			if tabs_disabled then
				!! text_window.make (new_name, form_manager, Current);
			else
				!PROJECT_TAB_TEXT! text_window.make (new_name, form_manager, Current)
			end;
			text_window.set_size (200, 100);
		end;

	build_format_bar is
			-- Build formatting buttons in `format_bar'.
		local
			last_cmd: EXEC_LAST;
			last_button: EB_BUTTON;
			last_menu_entry: EB_TICKABLE_MENU_ENTRY;
			stop_cmd: EXEC_STOP;
			stop_button: EB_BUTTON;
			stop_menu_entry: EB_TICKABLE_MENU_ENTRY;
			step_cmd: EXEC_STEP;
			step_button: EB_BUTTON;
			step_menu_entry: EB_TICKABLE_MENU_ENTRY;
			nostop_cmd: EXEC_NOSTOP;
			nostop_button: EB_BUTTON;
			nostop_menu_entry: EB_TICKABLE_MENU_ENTRY
		do
			!! format_bar.make (new_name, form_manager);

			!! stop_cmd.make (text_window);
			!! stop_button.make (stop_cmd, format_bar)
			stop_button.set_action ("!c<Btn1Down>", stop_cmd, stop_cmd.Format_and_run);
			!! stop_menu_entry.make (stop_cmd, debug_menu);
			!! exec_stop_frmt_holder.make (stop_cmd, stop_button, stop_menu_entry);
			!! step_cmd.make (text_window);
			!! step_button.make (step_cmd, format_bar);
			step_button.set_action ("!c<Btn1Down>", step_cmd, step_cmd.Format_and_run);
			!! step_menu_entry.make (step_cmd, debug_menu);
			!! exec_step_frmt_holder.make (step_cmd, step_button, step_menu_entry);
			!! last_cmd.make (text_window);
			!! last_button.make (last_cmd, format_bar);
			last_button.set_action ("!c<Btn1Down>", last_cmd, last_cmd.Format_and_run);
			!! last_menu_entry.make (last_cmd, debug_menu);
			!! exec_last_frmt_holder.make (last_cmd, last_button, last_menu_entry);
			!! nostop_cmd. make (text_window);
			!! nostop_button.make (nostop_cmd, format_bar);
			nostop_button.set_action ("!c<Btn1Down>", nostop_cmd, nostop_cmd.Format_and_run);
			!! nostop_menu_entry.make (nostop_cmd, debug_menu);
			!! exec_nostop_frmt_holder.make (nostop_cmd, nostop_button, nostop_menu_entry);

			format_bar.attach_left (stop_button, 0);
			format_bar.attach_top (stop_button, 0);
			format_bar.attach_bottom (stop_button, 0);
			format_bar.attach_top (step_button, 0);
			format_bar.attach_bottom (step_button, 0);
			format_bar.attach_left_widget (stop_button, step_button, 0);
			format_bar.attach_top (last_button, 0);
			format_bar.attach_bottom (last_button, 0);
			format_bar.attach_left_widget (step_button, last_button, 0);
			format_bar.attach_top (nostop_button, 0);
			format_bar.attach_bottom (nostop_button, 0);
			format_bar.attach_left_widget (last_button, nostop_button, 0);
		end;

	build_icing is
			-- Build icing area
		local
			update_cmd: UPDATE_PROJECT;
			update_button: EB_BUTTON;
			update_menu_entry: EB_MENU_ENTRY;
			freeze_cmd: FREEZE_PROJECT;
			freeze_button: EB_BUTTON;
			freeze_menu_entry: EB_MENU_ENTRY;
			finalize_cmd: FINALIZE_PROJECT;
			finalize_button: EB_BUTTON;
			finalize_menu_entry: EB_MENU_ENTRY;
			special_cmd: SPECIAL_COMMAND;
			special_button: EB_BUTTON;
			debug_quit_cmd: DEBUG_QUIT;
			debug_quit_button: EB_BUTTON;
			debug_quit_menu_entry: EB_MENU_ENTRY;
			debug_run_cmd: DEBUG_RUN;
			debug_run_button: EB_BUTTON;
			debug_run_menu_entry: EB_MENU_ENTRY;
			debug_status_cmd: DEBUG_STATUS;
			debug_status_button: EB_BUTTON;
			debug_status_menu_entry: EB_MENU_ENTRY;
			separator: SEPARATOR
		do
			!! icing.make (new_name, form_manager);
			!! update_cmd.make (text_window);
			!! update_button.make (update_cmd, icing);
			update_button.set_action ("!c<Btn1Down>", update_cmd, update_cmd.generate_code_only);
			!! update_menu_entry.make (update_cmd, compile_menu);
			!! update_cmd_holder.make (update_cmd, update_button, update_menu_entry);
			!! debug_run_cmd.make (icing, text_window);
			!! debug_run_button.make (debug_run_cmd, icing);
			debug_run_button.add_button_click_action (3, debug_run_cmd, debug_run_cmd.specify_args);
			debug_run_button.set_action ("!c<Btn1Down>", debug_run_cmd, debug_run_cmd.melt_and_run);
			!! debug_run_menu_entry.make (debug_run_cmd, debug_menu);
			!! debug_run_cmd_holder.make (debug_run_cmd, debug_run_button, debug_run_menu_entry);
			!! debug_status_cmd.make (text_window);
			!! debug_status_button.make (debug_status_cmd, icing);
			!! debug_status_menu_entry.make (debug_status_cmd, debug_menu);
			!! debug_status_cmd_holder.make (debug_status_cmd, debug_status_button, debug_status_menu_entry);
			!! debug_quit_cmd.make (text_window);
			!! debug_quit_button.make (debug_quit_cmd, icing);
			debug_quit_button.set_action ("!c<Btn1Down>", debug_quit_cmd, debug_quit_cmd.kill_it);
			!! debug_quit_menu_entry.make (debug_quit_cmd, debug_menu);
			!! debug_quit_cmd_holder.make (debug_quit_cmd, debug_quit_button, debug_quit_menu_entry);
			!! special_cmd.make (text_window);
			!! special_button.make (special_cmd, icing);
			!! special_cmd_holder.make_plain (special_cmd);
			special_cmd_holder.set_button (special_button);
			!! freeze_cmd.make (text_window);
			!! freeze_button.make (freeze_cmd, icing);
			freeze_button.set_action ("!c<Btn1Down>", freeze_cmd, freeze_cmd.generate_code_only);
			!! freeze_menu_entry.make (freeze_cmd, compile_menu);
			!! freeze_cmd_holder.make (freeze_cmd, freeze_button, freeze_menu_entry);
			!! finalize_cmd.make (text_window);
			!! finalize_button.make (finalize_cmd, icing);
			finalize_button.set_action ("!c<Btn1Down>", finalize_cmd, finalize_cmd.generate_code_only);
			!! finalize_menu_entry.make (finalize_cmd, compile_menu);
			!! finalize_cmd_holder.make (finalize_cmd, finalize_button, finalize_menu_entry);

			!! separator.make (new_name, debug_menu);

			icing.attach_top (update_button, 0);
			icing.attach_left (update_button, 0);
			icing.attach_right (update_button, 0);
			icing.attach_top_widget (update_button, debug_run_button, 0);
			icing.attach_left (debug_run_button, 0);
			icing.attach_right (debug_run_button, 0);
			icing.attach_top_widget (debug_run_button, debug_status_button, 0);
			icing.attach_left (debug_status_button, 0);
			icing.attach_right (debug_status_button, 0);
			icing.attach_top_widget (debug_status_button, debug_quit_button, 0);
			icing.attach_left (debug_quit_button, 0);
			icing.attach_right (debug_quit_button, 0);
			icing.attach_top_widget (debug_quit_button, special_button, 0);
			icing.attach_left (special_button, 0);
			icing.attach_right (special_button, 0);
			icing.attach_bottom_widget (freeze_button, special_button, 0);
			icing.attach_left (freeze_button, 0);
			icing.attach_right (freeze_button, 0);
			icing.attach_bottom_widget (finalize_button, freeze_button, 0);
			icing.attach_bottom (finalize_button, 0);
			icing.attach_left (finalize_button, 0);
			icing.attach_right (finalize_button, 0);
		end;

	attach_all is
			-- Adjust and attach main widgets together.
		do
			form_manager.attach_left (menu_bar, 0);
			form_manager.attach_right (menu_bar, 0);
			form_manager.attach_top (menu_bar, 0);

			form_manager.attach_left (classic_bar, 0);
			form_manager.attach_top_widget (menu_bar, classic_bar, 2);
			form_manager.attach_right_widget (icing, classic_bar, 0);

			form_manager.attach_left (text_window, 0);
			form_manager.attach_top_widget (classic_bar, text_window, 0);
			form_manager.attach_right_widget (icing, text_window, 0);
			-- (text_window will resize when window grows)

			-- form_manager.attach_left (xterminal, 5);
			-- form_manager.attach_top_widget (text_window, xterminal, 5);
			-- form_manager.attach_right_widget (icing, xterminal, 5);
			-- (xterminal will resize when window grows)
			-- form_manager.attach_bottom (xterminal, 5);

			form_manager.attach_bottom_widget (format_bar, text_window, 0);

			form_manager.attach_top_widget (menu_bar, icing, 2);
			form_manager.attach_right (icing, 0);
			form_manager.attach_bottom (icing, 0)

			form_manager.attach_left (format_bar, 0);
			form_manager.attach_right_widget (icing, format_bar, 0);
			form_manager.attach_bottom (format_bar, 0)
		end;

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

	debug_run_cmd_holder: COMMAND_HOLDER;

	debug_status_cmd_holder: COMMAND_HOLDER;

	debug_quit_cmd_holder: COMMAND_HOLDER;

	special_cmd_holder: COMMAND_HOLDER;

	freeze_cmd_holder: COMMAND_HOLDER;

	finalize_cmd_holder: COMMAND_HOLDER;

	change_font_cmd_holder: COMMAND_HOLDER;

 
feature -- Hole access
 
	compatible (dropped_stone: STONE): BOOLEAN is
			-- Is current hole compatible with `dropped_stone'?
		local
			t: INTEGER
		do
			t := dropped_stone.stone_type;
			Result :=  t = Class_type or else
				t = Routine_type or else
				t = Explain_type or else
				t = Object_type or else
				t = Breakable_type or else
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
			new_tool.process_classi (a_stone);
			new_tool.display
		end;
 
	process_class (a_stone: CLASSC_STONE) is
			-- Process dropped stone `a_stone'.
		local
			new_tool: CLASS_W
		do
			new_tool := window_manager.class_window;
			new_tool.process_class (a_stone);
			new_tool.display
		end;
 
	process_feature (a_stone: FEATURE_STONE) is
			-- Process dropped stone `a_stone'.
		local
			new_tool: ROUTINE_W
		do
			new_tool := window_manager.routine_window;
			new_tool.process_feature (a_stone);
			new_tool.display
		end;
 
	process_breakable (a_stone: BREAKABLE_STONE) is
			-- Process dropped stone `a_stone'.
		do
			stop_points_hole_holder.associated_command.receive (a_stone)
		end;
 
	process_object (a_stone: OBJECT_STONE) is
			-- Process dropped stone `a_stone'.
		local
			new_tool: OBJECT_W
		do
			new_tool := window_manager.object_window;
			new_tool.process_object (a_stone);
			new_tool.display
		end;
 
	process_error (a_stone: ERROR_STONE) is
			-- Process dropped stone `a_stone'.
		local
			new_tool: EXPLAIN_W
		do
			new_tool := window_manager.explain_window
			new_tool.process_any (a_stone)
			new_tool.display
		end;
 
	process_system (a_stone: SYSTEM_STONE) is
			-- Process dropped stone `a_stone'.
		do
			System_tool.process_system (a_stone)
			System_tool.display
		end;
 
end -- class PROJECT_W
