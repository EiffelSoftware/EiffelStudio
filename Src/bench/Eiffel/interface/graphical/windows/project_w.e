--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.	  --
--|	270 Storke Road, Suite 7 Goleta, California 93117		--
--|				   (805) 685-1006							--
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

class PROJECT_W

inherit

	TOOL_W
		rename
			execute as old_execute
		redefine
			text_window, tool_name
		end
	TOOL_W
		redefine
			text_window, tool_name,
			execute
		select
			execute
		end;
	BASE
		rename
			make as base_make
		end;
	EXCEPTIONS
		rename
			raise as raise_exception
		end;
	SHARED_WORKBENCH

creation

	make

feature

	popdown: ANY is once !!Result end;
	remapped: ANY is once !!Result end;

	display: SCREEN is
		local
			display_name: STRING;
		do
			!!Result.make ("");
			if not Result.is_valid then
				io.error.putstring ("Cannot open display %"");
				display_name := Execution_environment.get ("DISPLAY");
				if display_name /= Void then
					io.error.putstring (display_name);
				end;
				io.error.putstring ("%"%N%
					%Check that $DISPLAY is properly set and that you are%N%
					%authorized to connect to the corresponding server%N");
				raise_exception ("Invalid display");
			end;
		end;

	make is
			-- Create a project application.
		local
			a_screen: SCREEN;
		do
			a_screen := display;
			base_make (tool_name, a_screen);
			forbid_resize;
			build_widgets;
			set_title (l_New_project);
			set_default_position;
			realize;
			transporter_init;
			if bm_Project_icon.is_valid then
				set_icon_pixmap (bm_Project_icon);
			end;
			set_action ("<Unmap>,<Prop>", Current, popdown);
			set_action ("<Configure>", Current, remapped);
			set_action ("<Visible>", Current, remapped);
			set_delete_command (quit_command)
		end;

	set_default_size is do end;

	close_windows is 
		do 
			change_font_command.close
		end;

	popup_file_selection is
		do
			open_command.execute (text_window);
		end;

	eiffel_symbol: PIXMAP is
		do
			Result := bm_Project
		end;

	tool_name: STRING is do Result := l_Project end;

	tell_type (a_type_name: STRING) is
			-- Display `a_type_name' in type teller.
		do
			type_teller.set_text (a_type_name)
		end;

	clean_type is
			-- Clean what's said in the type teller window.
		do
			type_teller.set_text (" ")
		end;

	form_manager: FORM;
			-- Manager of constraints on sub widgets.

	classic_bar: FORM;
			-- Main menu bar

	format_bar: FORM;
			-- Format menu bar

feature -- xterminal

	text_window: PROJECT_TEXT;

	execute (arg: ANY) is
			-- Resize xterm window when drawing area is resized
		do
			if arg = remapped then
				if hidden_project_tool then
						-- The project tool is being deiconified.
					hidden_project_tool := False;
					window_manager.show_all_editors
					if hidden_system_window then
						system_tool.show
						hidden_system_window := False;
					end;
					raise
					if hidden_warner then
						hidden_warner := false;
						last_warner.popup
					end
					if hidden_confirmer then
						hidden_confirmer := false;
						last_confirmer.popup
					end
					if hidden_name_chooser then
						hidden_name_chooser := false;
						name_chooser.popup
					end
				else
						-- The project tool is being raised, moved or resized.
						-- Raise popups with an exclusive grab.
					raise_grabbed_popup
				end
			elseif arg = popdown then
				hidden_project_tool := True;
				if  
					not initialized or else
					Workbench.system = Void or else 
					System.system_name = Void 
				then
					set_icon_name (tool_name)
				else
					set_icon_name (System.system_name)
				end;
				close_windows;
				window_manager.hide_all_editors;
				if 	system_tool.realized and then system_tool.shown then
					system_tool.hide;
					system_tool.close_windows;
					hidden_system_window := True;
				end;
				if name_chooser.is_popped_up then
					hidden_name_chooser := true;
					name_chooser.popdown
				end;	
				if last_warner /= Void and then last_warner.is_popped_up then
					hidden_warner := true;
					last_warner.popdown
				end;
				if 
					last_confirmer /= Void and then 
					last_confirmer.is_popped_up
				then
					hidden_confirmer := true;
					last_confirmer.popdown
				end
			else
				old_execute (arg)
			end
		end;

	hidden_system_window: BOOLEAN;
	hidden_name_chooser: BOOLEAN;
	hidden_warner: BOOLEAN;
	hidden_confirmer: BOOLEAN;
	hidden_project_tool: BOOLEAN;

feature -- rest

	icing: FORM;
			-- With global command buttons

	type_teller: LABEL_G;
			-- To tell what type of element we are dealing with

	stop_points_hole: DEBUG_STOPIN;
			-- To set breakpoints
	system_hole: SYSTEM_HOLE;
	class_hole: PROJ_CLASS_HOLE;
	routine_hole: ROUTINE_HOLE;
	object_hole: OBJECT_HOLE;
	explain_hole: EXPLAIN_HOLE;

	set_default_position is
			-- Display the window at the cursor position.
			-- Try to display the window in the screen.
		local
			new_x, new_y: INTEGER
		do
			new_x := screen.x;
			new_y := screen.y;
			if new_x + width > screen.width then
				new_x := screen.width - width
			end;
			if new_x < 0 then
				new_x := 0
			end;
			if new_y + height > screen.height then
				new_y := screen.height - height
			end;
			if new_y < 0 then
				new_y := 0
			end;
			set_x_y (new_x, new_y)
		end;

	build_widgets is
			-- Build widget.
		do
			set_size (478, 306);
			!!form_manager.make (new_name, Current);
			build_text;
			build_top;
			build_icing;
			build_format_bar;
			exec_stop.execute (Void);
			attach_all
		end; -- build

	build_top is
			-- Build top bar
		do
			!!open_command.make (text_window);
			!!classic_bar.make (new_name, form_manager);

			!!quit_command.make (classic_bar, text_window);
			!!change_font_command.make (classic_bar, text_window);
			!!type_teller.make (new_name, classic_bar);
				type_teller.set_center_alignment;
			!!explain_hole.make (classic_bar, Current);
			!!system_hole.make (classic_bar, Current);
			!!class_hole.make (classic_bar, Current);
			!!routine_hole.make (classic_bar, Current);
			!!object_hole.make (classic_bar, Current);
			!!stop_points_hole.make (classic_bar, Current);

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
			classic_bar.attach_left_widget (stop_points_hole, type_teller, 0);
			classic_bar.attach_top (type_teller, 0);
			classic_bar.attach_bottom (type_teller, 0);
			classic_bar.attach_right_widget (change_font_command, type_teller, 0);
			classic_bar.attach_top (change_font_command, 0);
			classic_bar.attach_bottom (change_font_command, 0);
			classic_bar.attach_right_widget (quit_command, change_font_command, 0);
			classic_bar.attach_top (quit_command, 0);
			classic_bar.attach_bottom (quit_command, 0);
			classic_bar.attach_right (quit_command, 23);

			clean_type;
		end;

	build_text is
			-- Build console text window.
		do
			!!text_window.make (new_name, form_manager, Current);
			text_window.set_size (200, 100);
		end;

	build_format_bar is
			-- Build formatting buttons in `format_bar'.
		do
			!!format_bar.make (new_name, form_manager);

			!!exec_stop.make (format_bar, text_window);
			format_bar.attach_left (exec_stop, 0);
			format_bar.attach_top (exec_stop, 0);
			format_bar.attach_bottom (exec_stop, 0);
			!!exec_step.make (format_bar, text_window);
			format_bar.attach_top (exec_step, 0);
			format_bar.attach_bottom (exec_step, 0);
			format_bar.attach_left_widget (exec_stop, exec_step, 0);
			!!exec_last.make (format_bar, text_window);
			format_bar.attach_top (exec_last, 0);
			format_bar.attach_bottom (exec_last, 0);
			format_bar.attach_left_widget (exec_step, exec_last, 0);
			!!exec_nostop.make (format_bar, text_window);
			format_bar.attach_top (exec_nostop, 0);
			format_bar.attach_bottom (exec_nostop, 0);
			format_bar.attach_left_widget (exec_last, exec_nostop, 0);
		end;

	exec_nostop: EXEC_NOSTOP;
			-- Set execution format so that no stop points will be taken 
			-- into account
	exec_stop: EXEC_STOP;
			-- Set execution format so that user-defined stop points will 
			-- be taken into account
	exec_step: EXEC_STEP;
			-- Set execution format so that each breakable points of the 
			-- current routine will be taken into account
	exec_last: EXEC_LAST;
			-- Set execution format so that only the last breakable point 
			-- of the current routine will be taken into account

	open_command: OPEN_PROJECT;
	quit_command: QUIT_PROJECT;

	update_command: UPDATE_PROJECT;
	debug_run_command: DEBUG_RUN;
	debug_status_command: DEBUG_STATUS;
	debug_quit_command: DEBUG_QUIT;
	special_command: SPECIAL_COMMAND;
	freeze_command: FREEZE_PROJECT;
	finalize_command: FINALIZE_PROJECT;

	change_font_command: CHANGE_FONT;

	build_icing is
			-- Build icing area
		do
			!!icing.make (new_name, form_manager);
				!!update_command.make (icing, text_window);
				!!debug_run_command.make (icing, text_window);
				!!debug_status_command.make (icing, text_window);
				!!debug_quit_command.make (icing, text_window);
				!!special_command.make (icing, text_window);
				!!freeze_command.make (icing, text_window);
				!!finalize_command.make (icing, text_window);
			icing.attach_top (update_command, 0);
			icing.attach_left (update_command, 0);
			icing.attach_right (update_command, 0);
			icing.attach_top_widget (update_command, debug_run_command, 0);
			icing.attach_left (debug_run_command, 0);
			icing.attach_right (debug_run_command, 0);
			icing.attach_top_widget (debug_run_command, debug_status_command, 0);
			icing.attach_left (debug_status_command, 0);
			icing.attach_right (debug_status_command, 0);
			icing.attach_top_widget (debug_status_command, debug_quit_command, 0);
			icing.attach_left (debug_quit_command, 0);
			icing.attach_right (debug_quit_command, 0);
			icing.attach_top_widget (debug_quit_command, special_command, 0);
			icing.attach_left (special_command, 0);
			icing.attach_right (special_command, 0);
			icing.attach_bottom_widget (freeze_command, special_command, 0);
			icing.attach_left (freeze_command, 0);
			icing.attach_right (freeze_command, 0);
			icing.attach_bottom_widget (finalize_command, freeze_command, 0);
			icing.attach_bottom (finalize_command, 0);
			icing.attach_left (finalize_command, 0);
			icing.attach_right (finalize_command, 0);
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

		--	form_manager.attach_left (xterminal, 5);
		--	form_manager.attach_top_widget (text_window, xterminal, 5);
		--	form_manager.attach_right_widget (icing, xterminal, 5);
				-- (xterminal will resize when window grows)
		--	form_manager.attach_bottom (xterminal, 5);

			form_manager.attach_bottom_widget (format_bar, text_window, 0);

			form_manager.attach_top (icing, 0);
			form_manager.attach_right (icing, 0);
			form_manager.attach_bottom (icing, 0)

			form_manager.attach_left (format_bar, 0);
			form_manager.attach_right_widget (icing, format_bar, 0);
			form_manager.attach_bottom (format_bar, 0)
		end;

	initialized: BOOLEAN;
			-- Is the workbench created?
 
	set_initialized is
			-- Set `initialized' to true.
		do
			initialized := true
		ensure
			initialized = true
		end;

	changed: BOOLEAN;

	set_changed (f: BOOLEAN) is
			-- Assign `f' to `changed'.
		do
			changed := f
		end

end
