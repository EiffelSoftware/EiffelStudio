indexing

	description:	
		"The project window.";
	date: "$Date$";
	revision: "$Revision$"

class PROJECT_W

inherit

	TOOL_W
		redefine
			tool_name, process_system, process_error,
			process_object, process_breakable, process_class,
			process_classi, compatible, process_feature,
			process_class_syntax, process_ace_syntax, display
		end;
	COMMAND;
	BASE
		rename
			make as base_make
		export
			{GRAPHICAL_DEGREE_OUTPUT} implementation
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
			if bm_Project_icon.is_valid then
				set_icon_pixmap (bm_Project_icon);
			end;
			set_action ("<Unmap>,<Prop>", Current, popdown);
			set_action ("<Configure>", Current, remapped);
			set_action ("<Visible>", Current, remapped);
			set_delete_command (quit_cmd_holder.associated_command);
			set_composite_attributes (Current);
			set_font_to_default;
			!! app_stopped_cmd;
			Application.set_before_stopped_command (app_stopped_cmd);
			Application.set_after_stopped_command (app_stopped_cmd);
			set_default_position;
			realize;
			init_text_window;
			set_composite_attributes (Current);
		end;

feature -- Properties

	split_window: SPLIT_WINDOW;

	popdown: ANY is
		once
			!! Result
		end;

	remapped: ANY is
		once
			!! Result
		end;

	global_form: FORM is
			-- For representing Current
		do
			Result := std_form
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

	eb_shell: EB_SHELL is
		do
			Result := Void
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
		local
			default_x, default_y: INTEGER
		do
			default_x := Resources.get_integer (r_Project_tool_x, 0);
			default_y := Resources.get_integer (r_Project_tool_y, 0);
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

	close_windows is 
		local
			cf: CHANGE_FONT
		do 
			cf ?= change_font_cmd_holder.associated_command;
			cf.close
		end;

	popup_file_selection is
		do
			open_command.execute (Current);
		end;

feature -- Window Properties

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

	help_menu: MENU_PULL;
			-- Help menu.

feature -- Window Forms

	form_manager: FORM;
			-- Manager of constraints on sub widgets

	std_form: FORM;
			-- Form on which the std protject tool is displayed

	feature_form: FORM;
			-- Form on which the feature tool during debug will be shown

	object_form: FORM;
			-- Form on which the object tool during debug will be shown

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
				close_windows;
				window_manager.hide_all_editors;
				if 	system_tool.realized and then system_tool.shown then
					system_tool.hide;
					system_tool.close_windows;
					is_system_window_hidden := True;
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

	show_stoppoint (e_feature: E_FEATURE; index: INTEGER) is
			-- Show breakable mark in the feature part if
			-- the part is displayed
		local
			display_cmd: DISPLAY_ROUTINE_PORTION;
			new_stone: FEATURE_STONE
		do
			display_cmd ?= display_feature_cmd_holder.associated_command
			if display_cmd /= Void then
				if display_cmd.is_shown then
					if (feature_part.stone /= Void) and then
							feature_part.stone.e_feature /= Void and then
							not equal (feature_part.stone.e_feature.body_id, 
								e_feature.body_id) 
					then
						!! new_stone.make (e_feature, e_feature.written_class)
						feature_part.process_feature (new_stone)
						feature_part.text_window.redisplay_breakable_mark (e_feature, index)
					end;
				end
			end
		end

feature -- Graphical Interface

	build_widgets is
			-- Build widget.
		local
			default_width, default_height: INTEGER
		do
			shown_portions := 1;

			default_width := Resources.get_integer (r_Project_tool_width, 481);
			default_height := Resources.get_integer (r_Project_tool_height, 340);
			set_size (default_width, default_height);
			--!! form_manager.make (new_name, Current);
			--form_manager.set_fraction_base (6);

			--form_manager.attach_left (std_form, 0);
			--form_manager.attach_right (std_form, 0);
			--form_manager.attach_left (feature_form, 0);
			--form_manager.attach_right (feature_form, 0);
			--form_manager.attach_left (object_form, 0);
			--form_manager.attach_right (object_form, 0);
			--form_manager.attach_top_position (std_form, 0);
			--form_manager.attach_bottom_position (std_form, 6);
				--| We have to attach to position 6 to
				--| be sure that `std_form' is as big as the tool!

			--form_manager.attach_top_position (feature_form, 1);
			--form_manager.attach_bottom_position (feature_form, 2);
			--form_manager.attach_top_position (object_form, 2);
			--form_manager.attach_bottom_position (object_form, 3);
			
			!! split_window.make ("toto", Current);
			!! std_form.make (new_name, split_window);
			!! feature_form.make_unmanaged (new_name, split_window);
			!! object_form.make_unmanaged (new_name, split_window);

			build_menu;
			build_text_windows;
			build_top;
			build_compile_menu;
			build_format_bar;
			exec_stop_frmt_holder.execute (Void);
			attach_all;
		end;

	build_menu is
			-- Build the menu bar
		do
			!! menu_bar.make (new_name, std_form);
			!! file_menu.make ("File", menu_bar);
			!! edit_menu.make ("Edit", menu_bar);
			edit_menu.button.set_insensitive;
			!! compile_menu.make ("Compile", menu_bar);
			!! debug_menu.make ("Debug", menu_bar);
			!! format_menu.make ("Formats", menu_bar);
			!! special_menu.make ("Special", menu_bar);
			special_menu.button.set_insensitive;
			!! window_menu.make ("Windows", menu_bar);
			!! help_menu.make ("Help", menu_bar);
			menu_bar.set_help_button (help_menu.menu_button);

				--| Creation of empty menus that are disabled goes here,
				--| for we want to create the object and / or feature portion
				--| on demand and not on purpose.
			!! edit_feature_menu.make ("Feature", edit_menu);
			edit_feature_menu.button.set_insensitive;
			!! format_feature_menu.make ("Feature", format_menu);
			format_feature_menu.button.set_insensitive;
			!! special_feature_menu.make ("Feature", special_menu);
			special_feature_menu.button.set_insensitive;

			!! edit_object_menu.make ("Object", edit_menu);
			edit_object_menu.button.set_insensitive;
			!! special_object_menu.make ("Object", special_menu);
			special_object_menu.button.set_insensitive;
			!! format_object_menu.make ("Object", format_menu);
			format_object_menu.button.set_insensitive
		end;

	build_top is
			-- Build top bar
		local
			quit_cmd: QUIT_PROJECT;
			quit_button: EB_BUTTON;
			quit_menu_entry: EB_MENU_ENTRY;
			change_font_cmd: CHANGE_FONT;
			change_font_button: EB_BUTTON;
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
			show_pref_cmd: SHOW_PREFERENCE_TOOL;
			show_pref_menu_entry: EB_MENU_ENTRY;
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
		do
			!! open_command.make (text_window);
			!! classic_bar.make (new_name, std_form);
			!! quit_cmd.make (text_window);
			!! quit_menu_entry.make (quit_cmd, file_menu);
			!! quit_cmd_holder.make_plain (quit_cmd);
			quit_cmd_holder.set_menu_entry (quit_menu_entry);
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
			--if not change_font_cmd.tabs_disabled then
				--change_font_button.add_button_press_action (3, change_font_cmd, change_font_cmd.tab_setting)
			--end;
			!! change_font_cmd_holder.make_plain (change_font_cmd);
			!! sep.make ("", window_menu);
			!! show_pref_cmd.make (text_window);
			!! show_pref_menu_entry.make (show_pref_cmd, window_menu);
			!! show_preference_cmd_holder.make_plain (show_pref_cmd);
			show_preference_cmd_holder.set_menu_entry (show_pref_menu_entry);

			!! display_feature_cmd.make (text_window);
			!! display_feature_button.make (display_feature_cmd, classic_bar);
			!! display_feature_menu_entry.make (display_feature_cmd, format_menu);
			!! display_feature_cmd_holder.make (display_feature_cmd, display_feature_button, display_feature_menu_entry);

			!! display_object_cmd.make (text_window);
			!! display_object_button.make (display_object_cmd, classic_bar);
			!! display_object_menu_entry.make (display_object_cmd, format_menu);
			!! display_object_cmd_holder.make (display_object_cmd, display_object_button, display_object_menu_entry);

			!! update_cmd.make (Current);
			!! update_button.make (update_cmd, classic_bar);
			update_button.set_action ("!c<Btn1Down>", update_cmd, update_cmd.generate_code_only);
			!! update_menu_entry.make (update_cmd, compile_menu);
			!! update_cmd_holder.make (update_cmd, update_button, update_menu_entry);

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

			classic_bar.attach_right (update_button, 0);
			classic_bar.attach_top (update_button, 0);
			classic_bar.attach_bottom (update_button, 0);

			classic_bar.attach_left_widget (stop_points_button, display_feature_button, 60);
			classic_bar.attach_top (display_feature_button, 0);
			classic_bar.attach_bottom (display_feature_button, 0);
			classic_bar.attach_right_widget (display_feature_button, display_object_button, 0);
			classic_bar.attach_top (display_object_button, 0);
			classic_bar.attach_bottom (display_object_button, 0)
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
		do
			!! format_bar.make (new_name, std_form);

			!! debug_run_cmd.make (Current);
			!! debug_run_button.make (debug_run_cmd, format_bar);
			debug_run_button.add_button_press_action (3, debug_run_cmd, debug_run_cmd.specify_args);
			debug_run_button.set_action ("!c<Btn1Down>", debug_run_cmd, debug_run_cmd.melt_and_run);
			!! debug_run_menu_entry.make (debug_run_cmd, debug_menu);
			!! debug_run_cmd_holder.make (debug_run_cmd, debug_run_button, debug_run_menu_entry);
			!! debug_status_cmd.make (text_window);
			!! debug_status_button.make (debug_status_cmd, format_bar);
			!! debug_status_menu_entry.make (debug_status_cmd, debug_menu);
			!! debug_status_cmd_holder.make (debug_status_cmd, debug_status_button, debug_status_menu_entry);
			!! debug_quit_cmd.make (text_window);
			!! debug_quit_button.make (debug_quit_cmd, format_bar);
			debug_quit_button.set_action ("!c<Btn1Down>", debug_quit_cmd, debug_quit_cmd.kill_it);
			!! debug_quit_menu_entry.make (debug_quit_cmd, debug_menu);
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

			!! run_final_cmd.make (text_window);
			!! run_final_menu_entry.make (run_final_cmd, debug_menu);
			!! run_final_cmd_holder.make_plain (run_final_cmd);
			run_final_cmd_holder.set_menu_entry (run_final_menu_entry);

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

			format_bar.attach_right (debug_run_button, 0);
			format_bar.attach_top (debug_run_button, 0);
			format_bar.attach_bottom (debug_run_button, 0);
			format_bar.attach_right_widget (debug_run_button, debug_status_button, 0);
			format_bar.attach_top (debug_status_button, 0);
			format_bar.attach_bottom (debug_status_button, 0);
			format_bar.attach_right_widget (debug_status_button, debug_quit_button, 0);
			format_bar.attach_top (debug_quit_button, 0);
			format_bar.attach_bottom (debug_quit_button, 0);

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
		do
--			!! special_cmd.make (text_window);
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
		end;

	attach_all is
			-- Adjust and attach main widgets together.
		local
			separator: SEPARATOR
		do
			std_form.attach_left (menu_bar, 0);
			std_form.attach_right (menu_bar, 0);
			std_form.attach_top (menu_bar, 0);

			std_form.attach_left (classic_bar, 0);
			std_form.attach_top_widget (menu_bar, classic_bar, 2);
			std_form.attach_right (classic_bar, 0);

			!! separator.make ("", std_form);
			std_form.attach_top_widget (classic_bar, separator, 1);
			std_form.attach_left (separator, 0);
			std_form.attach_right (separator, 0);

			std_form.attach_top_widget (separator, format_bar, 1);
			std_form.attach_left (format_bar, 0);
			std_form.attach_right (format_bar, 0);

			std_form.attach_left (text_window.widget, 0);
			std_form.attach_top_widget (format_bar, text_window.widget, 0);
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

	debug_run_cmd_holder: COMMAND_HOLDER;

	debug_status_cmd_holder: COMMAND_HOLDER;

	debug_quit_cmd_holder: COMMAND_HOLDER;

	special_cmd_holder: COMMAND_HOLDER;

	freeze_cmd_holder: COMMAND_HOLDER;

	finalize_cmd_holder: COMMAND_HOLDER;

	precompile_cmd_holder: COMMAND_HOLDER;

	change_font_cmd_holder: COMMAND_HOLDER;

	run_final_cmd_holder: COMMAND_HOLDER;
 
	display_feature_cmd_holder: COMMAND_HOLDER;

	display_object_cmd_holder: COMMAND_HOLDER;

	show_preference_cmd_holder: COMMAND_HOLDER;

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
			new_tool := window_manager.dialog_object_window;
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
 
feature {NONE} -- Implementation

	build_feature_menus is
			-- Build the feature menus.
		require
			feature_part_exists: feature_part /= Void
		local
			fp: like feature_part;

			search: EB_MENU_ENTRY;
			shell: EB_MENU_ENTRY;
			f_current: EB_MENU_ENTRY;
			next: EB_MENU_ENTRY;
			previous: EB_MENU_ENTRY;

			clients: EB_TICKABLE_MENU_ENTRY;
			hist: EB_TICKABLE_MENU_ENTRY;
			past: EB_TICKABLE_MENU_ENTRY;
			flat: EB_TICKABLE_MENU_ENTRY;
			future: EB_TICKABLE_MENU_ENTRY;
			stop_points: EB_TICKABLE_MENU_ENTRY;
			text: EB_TICKABLE_MENU_ENTRY;
			homonym: EB_TICKABLE_MENU_ENTRY;

			separator: SEPARATOR
		do

			fp := feature_part
			!! search.make (fp.search_cmd_holder.associated_command, edit_feature_menu);
			fp.search_cmd_holder.set_menu_entry (search);
			!! shell.make (fp.shell.associated_command, special_feature_menu);
			fp.shell.set_menu_entry (shell);

			!! separator.make (new_name, special_feature_menu);

			!! f_current.make (fp.current_target_cmd_holder.associated_command, special_feature_menu);
			fp.current_target_cmd_holder.set_menu_entry (f_current);
			!! next.make (fp.next_target_cmd_holder.associated_command, special_feature_menu);
			fp.next_target_cmd_holder.set_menu_entry (next);
			!! previous.make (fp.previous_target_cmd_holder.associated_command, special_feature_menu);
			fp.previous_target_cmd_holder.set_menu_entry (previous);

			!! text.make (fp.showtext_frmt_holder.associated_command, format_feature_menu);
			fp.showtext_frmt_holder.set_menu_entry (text);
			!! flat.make (fp.showflat_frmt_holder.associated_command, format_feature_menu);
			fp.showflat_frmt_holder.set_menu_entry (flat);
			!! separator.make (new_name, format_feature_menu);
			!! clients.make (fp.showroutclients_frmt_holder.associated_command, format_feature_menu);
			fp.showroutclients_frmt_holder.set_menu_entry (clients);
			!! hist.make (fp.showhistory_frmt_holder.associated_command, format_feature_menu);
			fp.showhistory_frmt_holder.set_menu_entry (hist);
			!! past.make (fp.showpast_frmt_holder.associated_command, format_feature_menu);
			fp.showpast_frmt_holder.set_menu_entry (past);
			!! future.make (fp.showfuture_frmt_holder.associated_command, format_feature_menu);
			fp.showfuture_frmt_holder.set_menu_entry (future);
			!! homonym.make (fp.showhomonyms_frmt_holder.associated_command, format_feature_menu);
			fp.showhomonyms_frmt_holder.set_menu_entry (homonym);
			!! separator.make (new_name, format_feature_menu);
			!! stop_points.make (fp.showstop_frmt_holder.associated_command, format_feature_menu);
			fp.showstop_frmt_holder.set_menu_entry (stop_points)
		end;

	build_object_menus is
			-- Build the object menus.
		local
			op: like object_part;

			next: EB_MENU_ENTRY;
			o_current: EB_MENU_ENTRY;
			previous: EB_MENU_ENTRY;
			search: EB_MENU_ENTRY;
			slice: EB_MENU_ENTRY;

			onces: EB_TICKABLE_MENU_ENTRY;
			attr: EB_TICKABLE_MENU_ENTRY;

			sep: SEPARATOR
		do
			op := object_part;
			!! search.make (op.search_cmd_holder.associated_command, edit_object_menu);
			op.search_cmd_holder.set_menu_entry (search);

			!! slice.make (op.slice_cmd_holder.associated_command, special_object_menu);
			slice.remove_activate_action (op.slice_cmd_holder.associated_command, op.slice_cmd_holder.associated_command.text_window);
			slice.add_activate_action (op.slice_cmd_holder.associated_command, Void);
			op.slice_cmd_holder.set_menu_entry (slice);

			!! sep.make (new_name, special_object_menu);

			!! o_current.make (op.current_target_cmd_holder.associated_command, special_object_menu);
			op.current_target_cmd_holder.set_menu_entry (o_current);
			!! next.make (op.next_target_cmd_holder.associated_command, special_object_menu);
			op.next_target_cmd_holder.set_menu_entry (next);
			!! previous.make (op.previous_target_cmd_holder.associated_command, special_object_menu);
			op.previous_target_cmd_holder.set_menu_entry (previous);

			!! onces.make (op.showonce_frmt_holder.associated_command, format_object_menu);
			op.showonce_frmt_holder.set_menu_entry (onces);
			!! attr.make (op.showattr_frmt_holder.associated_command, format_object_menu);
			op.showattr_frmt_holder.set_menu_entry (attr)
		end;

feature {DISPLAY_ROUTINE_PORTION} -- Implementation

	hide_feature_portion is
			-- Hide the feature potion and hide the menu entries
			-- regarding the feature tool.
		local
			new_height: INTEGER
			new_pos: INTEGER
		do
			shown_portions := shown_portions - 1;
			new_pos := 6 // shown_portions;
			feature_form.unmanage;
			feature_part.close_windows;

			std_form.unmanage;
			form_manager.detach_bottom (std_form);
			form_manager.attach_bottom_position (std_form, new_pos)
			if shown_portions = 2 then
				object_form.unmanage;
				form_manager.detach_top (object_form);
				form_manager.detach_bottom (object_form);
				form_manager.attach_top_position (object_form, new_pos);
				form_manager.attach_bottom_position (object_form, new_pos + 3);
				object_form.manage
			else
				edit_menu.button.set_insensitive;
				special_menu.button.set_insensitive
			end;

			std_form.manage;

			edit_feature_menu.button.set_insensitive;
			special_feature_menu.button.set_insensitive;
			format_feature_menu.button.set_insensitive;

			new_height := height - Resources.get_integer (r_Debugger_feature_height, 214);
			set_height (new_height)
		end;

	show_feature_portion is
			-- Show the feature portion and the menu entries
			-- regarding the feature tool.
		local
			new_height: INTEGER;
			new_pos: INTEGER;
			mp: MOUSE_PTR
		do
			if feature_part = Void then
				feature_form.unmanage;
				!! mp.set_watch_cursor;
				!! feature_part.form_create (feature_form);
				mp.restore
				build_feature_menus
			end;

			shown_portions := shown_portions + 1;
			new_pos := 6 // shown_portions;
			std_form.unmanage;
			form_manager.detach_bottom (std_form);
			form_manager.detach_top (feature_form);
			form_manager.detach_bottom (feature_form);
			form_manager.attach_bottom_position (std_form, new_pos);
			form_manager.attach_top_position (feature_form, new_pos);
			form_manager.attach_bottom_position (feature_form, new_pos + new_pos);

			if shown_portions = 3 then
				object_form.unmanage;
				form_manager.detach_top (object_form);
				form_manager.attach_top_position (object_form, new_pos + new_pos);
				object_form.manage;
			end;

			feature_form.manage;
			std_form.manage;

			edit_feature_menu.button.set_sensitive;
			special_feature_menu.button.set_sensitive;
			format_feature_menu.button.set_sensitive;
			if shown_portions = 2 then
				special_menu.button.set_sensitive;
				edit_menu.button.set_sensitive
			end;

			new_height := height + Resources.get_integer (r_Debugger_feature_height, 214);
			set_height (new_height)
		end;

feature {DISPLAY_OBJECT_PORTION} -- Implementation

	hide_object_portion is
			-- Hide the object portion and the menu entries
			-- regarding the feature tool.
		local
			new_height: INTEGER;
			new_pos: INTEGER
		do
			shown_portions := shown_portions - 1;
			new_pos := 6 // shown_portions;

			std_form.unmanage;
			object_form.unmanage;
			object_part.close_windows;

			form_manager.detach_bottom (std_form);
			form_manager.attach_bottom_position (std_form, new_pos)
			if shown_portions = 2 then
				feature_form.unmanage;
				form_manager.detach_top (feature_form);
				form_manager.detach_bottom (feature_form);
				form_manager.attach_top_position (feature_form, new_pos);
				form_manager.attach_bottom_position (feature_form, new_pos + 3);
				feature_form.manage
			else
				edit_menu.button.set_insensitive;
				special_menu.button.set_insensitive;
			end;

			std_form.manage;

			edit_object_menu.button.set_insensitive;
			special_object_menu.button.set_insensitive;
			format_object_menu.button.set_insensitive;

			new_height := height - Resources.get_integer (r_Debugger_object_height, 214);
			set_height (new_height)
		end;

	show_object_portion is
			-- Show the object portion and the menu entries
			-- regarding the feature tool.
		local
			new_height: INTEGER;
			new_pos: INTEGER
		do
			if object_part = Void then
				!! object_part.form_create (object_form);
				build_object_menus
			end;

			shown_portions := shown_portions + 1;
			new_pos := 6 // shown_portions;
			object_form.manage;

			--std_form.unmanage;

			--form_manager.detach_bottom (std_form);
			--form_manager.detach_top (object_form);
			--form_manager.detach_bottom (object_form);
			--form_manager.attach_bottom_position (std_form, new_pos);
			--form_manager.attach_top_position (object_form, new_pos);
			--form_manager.attach_bottom_position (object_form, new_pos + new_pos);

			if shown_portions = 3 then
				--form_manager.detach_top (feature_form);
				--form_manager.attach_top_position (feature_form, new_pos + new_pos)
			end;

			--object_form.manage;
			--std_form.manage;

			edit_object_menu.button.set_sensitive;
			special_object_menu.button.set_sensitive;
			format_object_menu.button.set_sensitive;
			if shown_portions = 2 then
				special_menu.button.set_sensitive;
				edit_menu.button.set_sensitive
			end;

			new_height := height + Resources.get_integer (r_Debugger_object_height, 214);
			object_form.set_height (Resources.get_integer
					(r_Debugger_object_height, 214));
			set_height (new_height)
		end;

end -- class PROJECT_W
