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
		redefine
			delete_window_action
		end;

creation

	make

feature

	popup: ANY is
		once
			!! Result;
		end

	popdown: ANY is
		once
			!! Result;
		end

	display: SCREEN is
		local
			display_name: STRING;
		do
			!!Result.make ("");
		rescue
			io.error.putstring ("Cannot open display %"");
			display_name := env_get ("DISPLAY");
			if display_name /= Void then
				io.error.putstring (display_name);
			end;
			io.error.putstring ("%"%N%
				%Check that $DISPLAY is properly set and that you are%N%
				%authorized to connect to the corresponding server%N");
		end;

	make is
			-- Create a project application.
		local
			void_reference: ANY;
			a_screen: SCREEN;
		do
			if popup /= Void then end;
			if popdown /= Void then end;
			a_screen := display;
			base_make (tool_name, a_screen);
			forbid_resize;
			build_widgets;
			set_title (l_New_project);
			set_x_y (0,0);
			realize;
			transporter_init;
			if bm_Project_icon.is_valid then
				set_icon_pixmap (bm_Project_icon);
			end;
			set_icon_name (tool_name);
			set_action ("<Unmap>,<Prop>", Current, popdown);
			set_action ("<Map>,<Prop>", Current, popup);
		end;

	set_default_position is do end;

	set_default_size is do end;

	close_windows is 
		do 
			change_font_command.close (text_window)
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

feature -- xterminal

	text_window: PROJECT_TEXT;

	execute (arg: ANY) is
			-- Resize xterm window when drawing area is resized
		do
			if arg = popup then
				window_manager.show_all_editors
				if hidden_system_window then
					system_tool.display
					hidden_system_window := False;
				end;
				if initialized then
					raise
					if warner.is_poped_up then
						warner.raise
					end
				end
			elseif arg = popdown then
				window_manager.hide_all_editors;
				if 	
					system_tool.realized and then system_tool.shown 
				then
					system_tool.hide;
					system_tool.close_windows;
					hidden_system_window := True;
				end
			elseif arg = task_end then
				task_end.remove_action (Current, task_end);
				quit_command.execute (Void);
			else
				old_execute (arg)
			end
		end;

	hidden_system_window: BOOLEAN;

feature {NONE}

	task_end: TASK;

	delete_window_action is
		do
			!!task_end.make;
			task_end.add_action (Current, task_end);
			iterate
		end;

feature -- rest

	icing: FORM;
			-- With global command buttons

	type_teller: LABEL_G;
			-- To tell what type of element we are dealing with

	stop_points_hole: DEBUG_STOPIN;
			-- To set breakpoints

	build_widgets is
			-- Build widget.
		do
			set_size (478, 306);
			!!form_manager.make (new_name, Current);
			build_text;
			build_top;
			build_icing;
			attach_all
		end; -- build

	build_top is
			-- Build top bar
		local
			system_hole: SYSTEM_HOLE;
			class_hole: PROJ_CLASS_HOLE;
			routine_hole: ROUTINE_HOLE;
			object_hole: OBJECT_HOLE;
			explain_hole: EXPLAIN_HOLE;
			shell_hole: SHELL_HOLE;
			dummy_rc: ROW_COLUMN;
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
				--!!shell_hole.make (classic_bar, Current);
					classic_bar.attach_top (quit_command, 0);
					classic_bar.attach_top (change_font_command, 0);
					classic_bar.attach_top (type_teller, 0);
					classic_bar.attach_top (explain_hole, 0);
					classic_bar.attach_top (system_hole, 0);
					classic_bar.attach_top (class_hole, 0);
					classic_bar.attach_top (routine_hole, 0);
					classic_bar.attach_top (object_hole, 0);
					classic_bar.attach_top (stop_points_hole, 0);
					classic_bar.attach_left (explain_hole, 0);
					classic_bar.attach_left_widget (explain_hole, system_hole,0);
					classic_bar.attach_left_widget (system_hole, class_hole,0);
					classic_bar.attach_left_widget (class_hole, routine_hole, 0);
					classic_bar.attach_left_widget (routine_hole, object_hole, 0);
					classic_bar.attach_left_widget (object_hole, stop_points_hole, 0);
					classic_bar.attach_left_widget (stop_points_hole, type_teller,
0);
					classic_bar.attach_right_widget (change_font_command, type_teller, 0);
					classic_bar.attach_right_widget (quit_command, change_font_command, 0);
					classic_bar.attach_right (quit_command, 23);
					classic_bar.attach_bottom (type_teller, 0);
					--classic_bar.attach_right_widget (shell_hole, object_hole, 0);
					--classic_bar.attach_top (shell_hole, 0);
					--classic_bar.attach_right (shell_hole, 23);
					clean_type;
		end;

	build_text is
			-- Build console text window.
		do
			!!text_window.make (new_name, form_manager, Current);
			text_window.set_size (200, 100);
		end;

	open_command: OPEN_PROJECT;
	quit_command: QUIT_PROJECT;

	update_command: UPDATE_PROJECT;
--	run_command: RUN;
	debug_run_command: DEBUG_RUN;
	debug_step_command: DEBUG_STEP;
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
--				!!run_command.make (icing, text_window);
				!!debug_run_command.make (icing, text_window);
				!!debug_step_command.make (icing, text_window);
				!!debug_quit_command.make (icing, text_window);
				!!special_command.make (icing, text_window);
				!!freeze_command.make (icing, text_window);
				!!finalize_command.make (icing, text_window);
			icing.attach_top (update_command, 0);
--			icing.attach_top_widget (update_command, run_command, 0);
			icing.attach_top_widget (update_command, debug_run_command, 0);
			icing.attach_top_widget (debug_run_command, debug_step_command, 0);
			icing.attach_top_widget (debug_step_command, debug_quit_command, 0);
			icing.attach_top_widget (debug_quit_command, special_command, 0);
			icing.attach_bottom_widget (freeze_command, special_command, 0);
			icing.attach_bottom_widget (finalize_command, freeze_command, 0);
			icing.attach_bottom (finalize_command, 0);
			icing.attach_left (update_command, 0);
			icing.attach_right (update_command, 0);
			icing.attach_left (special_command, 0);
			icing.attach_right (special_command, 0);
			icing.attach_left (freeze_command, 0);
			icing.attach_left (finalize_command, 0);
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

			form_manager.attach_bottom (text_window, 5);

			form_manager.attach_top (icing, 0);
			form_manager.attach_right (icing, 0);
			form_manager.attach_bottom (icing, 0)
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
