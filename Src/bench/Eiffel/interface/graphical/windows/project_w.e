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
			process_classi, compatible, process_feature
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

	stop_points_hole: DEBUG_STOPIN;

	system_hole: SYSTEM_HOLE;

	class_hole: CLASS_HOLE;

	routine_hole: ROUTINE_HOLE;

	object_hole: OBJECT_HOLE;

	explain_hole: EXPLAIN_HOLE;

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
			set_size (478, 306);
			!! form_manager.make (new_name, Current);
			build_text;
			build_top;
			build_icing;
			build_format_bar;
			exec_stop.execute (Void);
			attach_all
		end;

	build_top is
			-- Build top bar
		local
			quit_cmd: QUIT_PROJECT;
			quit_button: EB_BUTTON
			change_font_cmd: CHANGE_FONT;
			change_font_button: EB_BUTTON
		do
			!! open_command.make (text_window);
			!! classic_bar.make (new_name, form_manager);

			!! quit_cmd.make (text_window);
			!! quit_button.make (quit_cmd, classic_bar);
			!! quit_cmd_holder.make (quit_cmd, quit_button);
			!! change_font_cmd.make (text_window);
			!! change_font_button.make (change_font_cmd, classic_bar);
			if not change_font_cmd.tabs_disabled then
				change_font_button.add_button_click_action (3, change_font_cmd, change_font_cmd.tab_setting)
			end;
			!! change_font_cmd_holder.make (change_font_cmd, change_font_button);
			!! explain_hole.make (classic_bar, Current);
			!! system_hole.make (classic_bar, Current);
			!! class_hole.make (classic_bar, Current);
			!! routine_hole.make (classic_bar, Current);
			!! object_hole.make (classic_bar, Current);
			!! stop_points_hole.make (classic_bar, Current);

			classic_bar.attach_left (explain_hole, 0);
			classic_bar.attach_top (explain_hole, 0);
			classic_bar.attach_bottom (explain_hole, 0);
			classic_bar.attach_left_widget (explain_hole, system_hole,0);
			classic_bar.attach_top (system_hole, 0);
			classic_bar.attach_bottom (system_hole, 0);
			classic_bar.attach_left_widget (system_hole, class_hole,0);
			classic_bar.attach_top (class_hole, 0);
			classic_bar.attach_bottom (class_hole, 0);
			classic_bar.attach_left_widget (class_hole, routine_hole, 0);
			classic_bar.attach_top (routine_hole, 0);
			classic_bar.attach_bottom (routine_hole, 0);
			classic_bar.attach_left_widget (routine_hole, object_hole, 0);
			classic_bar.attach_top (object_hole, 0);
			classic_bar.attach_bottom (object_hole, 0);
			classic_bar.attach_left_widget (object_hole, stop_points_hole, 0);
			classic_bar.attach_top (stop_points_hole, 0);
			classic_bar.attach_bottom (stop_points_hole, 0);
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
		do
			!! format_bar.make (new_name, form_manager);

			!! exec_stop.make (format_bar, text_window);
			format_bar.attach_left (exec_stop, 0);
			format_bar.attach_top (exec_stop, 0);
			format_bar.attach_bottom (exec_stop, 0);
			!! exec_step.make (format_bar, text_window);
			format_bar.attach_top (exec_step, 0);
			format_bar.attach_bottom (exec_step, 0);
			format_bar.attach_left_widget (exec_stop, exec_step, 0);
			!! exec_last.make (format_bar, text_window);
			format_bar.attach_top (exec_last, 0);
			format_bar.attach_bottom (exec_last, 0);
			format_bar.attach_left_widget (exec_step, exec_last, 0);
			!! exec_nostop.make (format_bar, text_window);
			format_bar.attach_top (exec_nostop, 0);
			format_bar.attach_bottom (exec_nostop, 0);
			format_bar.attach_left_widget (exec_last, exec_nostop, 0);
		end;

	build_icing is
			-- Build icing area
		local
			update_cmd: UPDATE_PROJECT;
			update_button: EB_BUTTON;
			freeze_cmd: FREEZE_PROJECT;
			freeze_button: EB_BUTTON;
			finalize_cmd: FINALIZE_PROJECT;
			finalize_button: EB_BUTTON;
			special_cmd: SPECIAL_COMMAND;
			special_button: EB_BUTTON;
			debug_quit_cmd: DEBUG_QUIT;
			debug_quit_button: EB_BUTTON;
			debug_run_cmd: DEBUG_RUN;
			debug_run_button: EB_BUTTON;
			debug_status_cmd: DEBUG_STATUS;
			debug_status_button: EB_BUTTON
		do
			!! icing.make (new_name, form_manager);
			!! update_cmd.make (text_window);
			!! update_button.make (update_cmd, icing);
			update_button.set_action ("!c<Btn1Down>", update_cmd, update_cmd.generate_code_only);
			!! update_cmd_holder.make (update_cmd, update_button);
			!! debug_run_cmd.make (icing, text_window);
			!! debug_run_button.make (debug_run_cmd, icing);
			debug_run_button.add_button_click_action (3, debug_run_cmd, debug_run_cmd.specify_args);
			debug_run_button.set_action ("!c<Btn1Down>", debug_run_cmd, debug_run_cmd.melt_and_run);
			!! debug_run_cmd_holder.make (debug_run_cmd, debug_run_button);
			!! debug_status_cmd.make (text_window);
			!! debug_status_button.make (debug_status_cmd, icing);
			!! debug_status_cmd_holder.make (debug_status_cmd, debug_status_button);
			!! debug_quit_cmd.make (text_window);
			!! debug_quit_button.make (debug_quit_cmd, icing);
			debug_quit_button.set_action ("!c<Btn1Down>", debug_quit_cmd, debug_quit_cmd.kill_it);
			!! debug_quit_cmd_holder.make (debug_quit_cmd, debug_quit_button);
			!! special_cmd.make (text_window);
			!! special_button.make (special_cmd, icing);
			!! special_cmd_holder.make (special_cmd, special_button);
			!! freeze_cmd.make (text_window);
			!! freeze_button.make (freeze_cmd, icing);
			freeze_button.set_action ("!c<Btn1Down>", freeze_cmd, freeze_cmd.generate_code_only);
			!! freeze_cmd_holder.make (freeze_cmd, freeze_button);
			!! finalize_cmd.make (text_window);
			!! finalize_button.make (finalize_cmd, icing);
			finalize_button.set_action ("!c<Btn1Down>", finalize_cmd, finalize_cmd.generate_code_only);
			!! finalize_cmd_holder.make (finalize_cmd, finalize_button);
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
			form_manager.attach_left (classic_bar, 0);
			form_manager.attach_top (classic_bar, 0);
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

			form_manager.attach_top (icing, 0);
			form_manager.attach_right (icing, 0);
			form_manager.attach_bottom (icing, 0)

			form_manager.attach_left (format_bar, 0);
			form_manager.attach_right_widget (icing, format_bar, 0);
			form_manager.attach_bottom (format_bar, 0)
		end;

feature -- System Execution Modes

	exec_stop: EXEC_STOP;
			-- Set execution format so that user-defined stop
			-- points will be taken into account

	exec_nostop: EXEC_NOSTOP;
			-- Set execution format so that no stop points will
			-- be taken into account

	exec_step: EXEC_STEP;
			-- Set execution format so that each breakable points
			-- of the current routine will be taken into account

	exec_last: EXEC_LAST;
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
			stop_points_hole.receive (a_stone)
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
			new_tool.process_error (a_stone)
			new_tool.display
		end;
 
	process_system (a_stone: SYSTEM_STONE) is
			-- Process dropped stone `a_stone'.
		do
			System_tool.process_system (a_stone)
			System_tool.display
		end;
 
end -- class PROJECT_W
