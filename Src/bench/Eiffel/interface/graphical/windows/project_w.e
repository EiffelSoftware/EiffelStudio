--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.	  --
--|	270 Storke Road, Suite 7 Goleta, California 93117		--
--|				   (805) 685-1006							--
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- First window of the project
-- TODO:
--	Xterminal stuff

class PROJECT_W

inherit

	TOOL_W
		redefine
			text_window, work, tool_name
		end;
	BASE
		rename
			make as base_make
		end

creation

	make

feature

	make is
			-- Create a project application.
		local
			void_reference: ANY;
			a_screen: SCREEN;
--xterm_name: STRING
		do
--xterm_name := "Tregastel vaincra";
			!!a_screen.make ("");
			base_make (tool_name, a_screen);
			forbid_resize;
			build_widgets;
			set_title (l_New_project);
			set_x_y (0,0);
			realize;
			transporter_init;
			set_icon_pixmap (eiffel_symbol);
			set_icon_name (tool_name);
--get_xterm_in_xterminal (xterm_name);
		end;

	close_windows is do end;

	popup_file_selection is
		do
			open_command.execute (text_window);
		end;

	eiffel_symbol: PIXMAP is
		do
			Result := bm_Tower
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

	build_xterminal is
			-- Build drawing for xterminal.
		do
			!!xterminal.make (new_name, form_manager);
			xterminal.add_resize_action (Current, Void);
		end;

	get_xterm_in_xterminal (wname: STRING) is
		 	-- Get xterm and sqeeze it into `xterminal'.
		local
			n: ANY
		do
			n := wname.to_c;
			squeeze (xt_display (implementation.screen_object), $n,
				xt_window (xterminal.implementation.screen_object), xterminal.width, xterminal.height)
		end;

	text_window: PROJECT_TEXT;

	xterminal: DRAWING_AREA;
			-- Form where the xterminal is squeezed;

	work (arg: ANY) is
			-- Resize xterm window when drawing area is resized
		do
			resize_xterm (xt_display (implementation.screen_object), xterminal.width, xterminal.height)
		end;

feature -- rest

	icing: FORM;
			-- With global command buttons

	type_teller: LABEL_G;
			-- To tell what type of element we are dealing with

	build_widgets is
			-- Build widget.
		do
			set_size (478, 306);
			!!form_manager.make (new_name, Current);
			build_text;
			build_top;
			build_icing;
--build_xterminal;
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
				!!type_teller.make (new_name, classic_bar);
					type_teller.set_center_alignment;
				!!explain_hole.make (classic_bar, Current);
				!!system_hole.make (classic_bar, Current);
				!!class_hole.make (classic_bar, Current);
				!!routine_hole.make (classic_bar, Current);
				!!object_hole.make (classic_bar, Current);
				--!!shell_hole.make (classic_bar, Current);
					classic_bar.attach_top (quit_command, 0);
					classic_bar.attach_top (type_teller, 0);
					classic_bar.attach_top (explain_hole, 0);
					classic_bar.attach_top (system_hole, 0);
					classic_bar.attach_top (class_hole, 0);
					classic_bar.attach_top (routine_hole, 0);
					classic_bar.attach_top (object_hole, 0);
					classic_bar.attach_left (explain_hole, 0);
					classic_bar.attach_left_widget (explain_hole, system_hole,0);
					classic_bar.attach_left_widget (system_hole, class_hole,0);
					classic_bar.attach_left_widget (class_hole, routine_hole, 0);
					classic_bar.attach_left_widget (routine_hole, object_hole, 0);
					classic_bar.attach_left_widget (object_hole, type_teller,
0);
					classic_bar.attach_right_widget (quit_command, type_teller, 0);
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
	run_command: RUN;
	special_command: SPECIAL_COMMAND;
	freeze_command: FREEZE_PROJECT;
	finalize_command: FINALIZE_PROJECT;

	build_icing is
			-- Build icing area
		do
			!!icing.make (new_name, form_manager);
				!!update_command.make (icing, text_window);
				!!run_command.make (icing, text_window);
				!!special_command.make (icing, text_window);
				!!freeze_command.make (icing, text_window);
				!!finalize_command.make (icing, text_window);
			icing.attach_top (update_command, 0);
			icing.attach_top_widget (update_command, run_command, 0);
			icing.attach_top_widget (run_command, special_command, 0);
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

feature {NONE} -- external

	xt_window (scr_obj: POINTER): POINTER is
		external
			"C"
		end;
 
	xt_display (scr_obj: POINTER): POINTER is
		external
			"C"
		end;

	squeeze (disp: POINTER; xname: ANY; xwin: POINTER; w, h: INTEGER) is
		external
			"C"
		end;

	resize_xterm (disp: POINTER; w, h: INTEGER) is
		external
			"C"
		end

end
