indexing

	description:
		"Tool for graphical output of the profiler.";
	date: "$Date$";
	revision: "$Revision$"

class PROFILE_TOOL

inherit
	TOP_SHELL
		rename
			hide as top_shell_hide,
			show as top_shell_show,
			make as top_shell_make
		end

	COMMAND

	EB_CONSTANTS

	WINDOWS

	WINDOW_ATTRIBUTES

	RESOURCE_USER
		redefine
			update_integer_resource
		end

	SYSTEM_CONSTANTS

creation
	make

feature {NONE} -- Initialization

	make (a_command: SHOW_PROFILE_TOOL) is
		require
			a_command_not_void: a_command /= Void
		do
			Profiler_resources.add_user (Current);

			!! open_tools.make 
			command := a_command;
			
			if Platform_constants.is_windows then
					-- For windows we need the id for the Icon
				top_shell_make (Interface_names.i_Class_id.out, Project_tool.screen);
			else
					-- For unix we need this for the X resource file
			 	top_shell_make (Interface_names.n_X_resource_name, Project_tool.screen);
			end;
			
			set_title (Interface_names.t_Profile_tool);
			set_icon_name (Interface_names.t_Profile_tool);
			!! quit_cmd.make (Current);
			!! run_prof_query_cmd.make (Current);
			set_delete_command (quit_cmd);
			build_widgets
			set_composite_attributes (Current);	
		end

feature -- Updating

	update_integer_resource (old_res, new_res: INTEGER_RESOURCE) is
		local
			pr: like Profiler_resources
		do
			pr := Profiler_resources;
			if new_res.actual_value >= 0 then
				if old_res = pr.tool_width then
					set_width (new_res.actual_value)
				elseif old_res = pr.tool_height then
					set_height (new_res.actual_value)
				elseif old_res = pr.query_tool_width then
					from
						open_tools.start
					until
						open_tools.after
					loop
						open_tools.item.set_width (new_res.actual_value)
						open_tools.forth
					end;
				elseif old_res = pr.query_tool_height then
					from
						open_tools.start
					until
						open_tools.after
					loop
						open_tools.item.set_height (new_res.actual_value)
						open_tools.forth
					end;
				end;
				old_res.update_with (new_res)
			end;
		end

feature -- Graphical User Interface

	show_new_window (st: STRUCTURED_TEXT; pq: PROFILER_QUERY;
				po: PROFILER_OPTIONS; profinfo: PROFILE_INFORMATION) is
			-- Create and show a new PROFILE_QUERY_WINDOW
		local
			new_window: PROFILE_QUERY_WINDOW
		do
			!! new_window.make (Current);
			new_window.popup;
			new_window.update_window (st, pq, po, profinfo);
			open_tools.extend (new_window)
		end;

	display is
			-- Display the tool
		do
			if not realized then
				realize
			else
				show
			end
			raise
		end;

feature {RUN_PROFILE_QUERY_CMD} -- Access

	fill_values (shared_values: SHARED_QUERY_VALUES): BOOLEAN is
			-- Fill `shared_values' with value specified
			-- by the user.
		local
			parser: QUERY_PARSER
			filename: STRING
			i: INTEGER
			-- warner: WARNER_W
		do
			i := shared_values.language_names.lower

				--| Copy the language names
			if eiffel_switch.state then
				shared_values.language_names.force ("eiffel", i)
				i := i + 1
			end
			if c_switch.state then
				shared_values.language_names.force ("c", i)
				i := i + 1
			end
			if recursive_switch.state then
				shared_values.language_names.force ("cycle", i)
				i := i + 1
			end

			i := shared_values.output_names.lower

				--| Copy the output column switches
			if number_of_calls_switch.state then
				shared_values.output_names.force ("calls", i)
				i := i + 1
			end;
			if time_switch.state then
				shared_values.output_names.force ("self", i)
				i := i + 1
			end;
			if descendant_switch.state then
				shared_values.output_names.force ("descendants", i)
				i := i + 1
			end;
			if total_time_switch.state then
				shared_values.output_names.force ("total", i)
				i := i + 1
			end;
			if percentage_switch.state then
				shared_values.output_names.force ("percentage", i)
				i := i + 1
			end;
			if name_switch.state then
				shared_values.output_names.force ("featurename", i)
				i := i + 1
			end;

				--| Copy the filename
			!! filename.make(0)
			filename := input_text.text
			filename.prepend(working_directory)

			shared_values.filenames.force (filename, shared_values.filenames.lower);

				--| Copy the subqueries
			if not query_text.text.is_empty then
				!! parser;
				Result := parser.parse (query_text.text, shared_values)
			else
				Result := false
				-- warner.make(Current)
				-- warner.gotcha_call ("Verify your query!")
			end
		end

feature {NONE} -- Graphical User Interface

	build_widgets is
		local
			horizontal_sep,
			upper_sep, text_sep: THREE_D_SEPARATOR;
			switch_label,
			language_label: LABEL;
		do
				-- User Interface Components
			!! global_form.make (Interface_names.t_Empty, Current);

			!! upper_sep.make (Interface_names.t_Empty, global_form);
			!! switch_label.make (Interface_names.l_Output_switches, global_form);
			!! switch_form.make (Interface_names.t_Empty, global_form);
			!! language_label.make (Interface_names.l_Language_type, global_form);
			!! language_form.make (Interface_names.t_Empty, global_form);
			!! horizontal_sep.make (Interface_names.t_Empty, global_form);
			!! text_form.make (Interface_names.t_Empty, global_form);
			!! text_sep.make (Interface_names.t_Empty, global_form);
			!! button_form.make (Interface_names.t_Empty, global_form);
			button_form.set_fraction_base (2);

			!! menu_bar.make (Interface_names.t_Empty, global_form);
			!! file_menu.make (Interface_names.m_File, menu_bar);
			!! command_menu.make (Interface_names.m_Commands, menu_bar);
			!! window_menu.make (Interface_names.m_window, menu_bar);
			!! help_menu.make (Interface_names.m_Help, menu_bar);
			menu_bar.set_help_button (help_menu.menu_button);

				-- Put entries in the menus.
			fill_menus;

			!! exit_button.make (Interface_names.b_Exit, button_form);
			!! run_button.make (Interface_names.b_Run_query, button_form);

			!! name_switch.make (Interface_names.b_Feature_name, switch_form);
			name_switch.set_toggle_on;
			!! number_of_calls_switch.make (Interface_names.b_Number_of_calls, switch_form);
			number_of_calls_switch.set_toggle_on;
			!! time_switch.make (Interface_names.b_Function_time, switch_form);
			time_switch.set_toggle_on
			!! descendant_switch.make (Interface_names.b_Descendant_time, switch_form);
			descendant_switch.set_toggle_on
			!! total_time_switch.make (Interface_names.b_Total_time, switch_form);
			total_time_switch.set_toggle_on
			!! percentage_switch.make (Interface_names.b_Percentage, switch_form);
			percentage_switch.set_toggle_on

			!! eiffel_switch.make (Interface_names.b_Eiffel_features, language_form);
			eiffel_switch.set_toggle_on;
			!! c_switch.make (Interface_names.b_C_functions, language_form);
			c_switch.set_toggle_on;
			!! recursive_switch.make (Interface_names.b_Recursive_functions, language_form);
			recursive_switch.set_toggle_on;

			!! input_label.make (Interface_names.l_Input_file, text_form);
			!! input_text.make (Interface_names.t_Empty, text_form);
			input_text.set_text ("profinfo.pfi");
			!! query_label.make (Interface_names.l_Query, text_form);
			!! query_text.make (Interface_names.t_Empty, text_form);
			!! browse_button.make (Interface_names.b_Browse, text_form);
			browse_button.add_activate_action (Current, browse_it);

				-- Compilation Mode
			!! compilation_label.make ("Input file compilation type", text_form)
			!! compile_box.make (Interface_names.t_Empty, text_form);
			compile_box.set_always_one (True);
			!! workbench_button.make (Interface_names.b_Workbench, compile_box);
			workbench_button.set_toggle_on;
			!! final_button.make (Interface_names.b_Final, compile_box);

				-- Commands
			exit_button.add_activate_action (quit_cmd, Void);
			run_button.add_activate_action (run_prof_query_cmd, Void);
			query_text.add_activate_action (run_prof_query_cmd, Void);

			global_form.set_fraction_base (2);

				-- Attachments
			global_form.attach_top (menu_bar, 0);
			global_form.attach_left_position (menu_bar, 0);
			global_form.attach_right_position (menu_bar, 2);

			global_form.attach_top_widget (menu_bar, upper_sep, 1);
			global_form.attach_left (upper_sep, 0);
			global_form.attach_right (upper_sep, 0 );
			global_form.attach_top_widget (upper_sep, switch_label, 1);
			global_form.attach_left_position (switch_label, 0);
			global_form.attach_top_widget (switch_label, switch_form, 1);
			global_form.attach_left_position (switch_form, 0);

			global_form.attach_top_widget (upper_sep, language_label, 1);
			global_form.attach_left_position (language_label, 1);
			global_form.attach_top_widget (language_label, language_form, 1);
			global_form.attach_left_position (language_form, 1);

			global_form.attach_top_widget (switch_form, horizontal_sep, 0);
			global_form.attach_left (horizontal_sep, 0);
			global_form.attach_right (horizontal_sep, 0);

			global_form.attach_top_widget (horizontal_sep, text_form, 1);
			global_form.attach_left_position (text_form, 0);
			global_form.attach_bottom_widget (text_sep, text_form, 1);

			global_form.attach_bottom_widget (button_form, text_sep, 1);
			global_form.attach_left (text_form, 5)
			global_form.attach_right (text_form, 5)
			global_form.attach_left_position (text_sep, 0);
			global_form.attach_right_position (text_sep, 2);

			global_form.attach_left (button_form, 0);
			global_form.attach_bottom (button_form, 0);
			global_form.attach_right (button_form, 0);

			button_form.attach_top (run_button, 5);
			button_form.attach_left_position (run_button, 0);
			button_form.attach_bottom (run_button, 5);
			button_form.attach_right_position (run_button, 1);
			button_form.attach_top (exit_button, 5);
			button_form.attach_left_position (exit_button, 1);
			button_form.attach_bottom (exit_button, 5);
			button_form.attach_right_position (exit_button, 2);

			text_form.attach_top (compilation_label, 5);
			text_form.attach_left (compilation_label, 0);
			text_form.attach_top_widget(compilation_label, compile_box, 0)
			text_form.attach_left (compile_box, 15);
			text_form.attach_right (compile_box, 0);
			text_form.attach_top_widget (compile_box, input_label, 1);			
			text_form.attach_left (input_label, 0);
			text_form.attach_top_widget (input_label, input_text, 5);
			text_form.attach_left (input_text, 15);
			text_form.attach_top_widget (input_text, query_label, 5);
			text_form.attach_right_widget (browse_button, input_text, 5);
			text_form.attach_top_widget (input_label, browse_button, 1);
			text_form.attach_right (browse_button, 5);
			text_form.attach_left (query_label, 0);
			text_form.attach_top_widget (query_label, query_text, 5);
			text_form.attach_left (query_text, 15);
			text_form.attach_bottom (query_text, 5);
			text_form.attach_right (query_text, 5);

				-- Sizing policy
			set_width (Profiler_resources.tool_width.actual_value)
			set_height (Profiler_resources.tool_height.actual_value)
		end;

	fill_menus is
			-- Fill the menus with commands.
		local
			generate_menu_entry: EB_MENU_ENTRY;
			generate_cmd: GENERATE_PROFILE_INFO_CMD
			quit_menu_entry: EB_MENU_ENTRY;
			help_cmd: PROFILE_HELP_CMD;
			help_menu_entry: EB_MENU_ENTRY;
			show_pref_cmd: SHOW_PREFERENCE_TOOL;
			show_pref_menu_entry: EB_MENU_ENTRY;
			menu_entry: EB_MENU_ENTRY;
			raise_tool_cmd: RAISE_TOOL_CMD;
			sep: SEPARATOR
		do
			!! quit_menu_entry.make_default (quit_cmd, file_menu);
			!! generate_cmd;
			!! generate_menu_entry.make_default (generate_cmd, command_menu);
			!! help_cmd;
			!! help_menu_entry.make_default (help_cmd, help_menu);

			!! menu_entry.make 
				(Project_tool.class_hole_holder.associated_command, window_menu);
			!! menu_entry.make 
				(Project_tool.routine_hole_holder.associated_command, window_menu);
			!! menu_entry.make 
				(Project_tool.object_hole_holder.associated_command, window_menu);
			!! sep.make (Interface_names.t_Empty, window_menu);
			!! show_pref_cmd.make (Profiler_resources);
			!! show_pref_menu_entry.make_default (show_pref_cmd, window_menu);
			!! raise_tool_cmd.make (Project_tool);
			!! menu_entry.make (raise_tool_cmd, window_menu);
		end

feature {NONE} -- Attributes

	quit_cmd: QUIT_PROFILE_TOOL;
			-- Command to quit Current

	run_prof_query_cmd: RUN_PROFILE_QUERY_CMD;
			-- Command to run the typed query

	global_form,
			-- Form for Current

	button_form,
			-- Form for the buttons

	text_form: FORM;
			-- Form to display text fields on

	browse_button,
			-- Button to browse for input filename

	run_button,
			-- Button to run the query

	exit_button: PUSH_B;
			-- Button to exit the tool with
	
	compile_box: RADIO_BOX
			-- Form to select input file compilation mode

	switch_form,
			-- Form to display switches on

	language_form: CHECK_BOX;
			-- Form to display possible languages on

	name_switch,
			-- Switch for the feature names

	number_of_calls_switch,
			-- Switch for the number of calls

	percentage_switch,
			-- Switch for the percentage of time

	time_switch,
			-- Switch for the amount of time
			-- spent in the function itself

	descendant_switch,
			-- Switch for the amount of time
			-- spent in the called functions

	total_time_switch,
			-- Switch for the amount of time
			-- spent in both the function itself
			-- and the called ones.

	eiffel_switch,
			-- Switch for output of eiffel features

	c_switch,
			-- Switch for output of c functions

	recursive_switch: TOGGLE_B;
			-- Switch for display of recursive funtions.

	workbench_button,
			-- Check button for workbench mode

	final_button: TOGGLE_B;
			-- Check button for final mode

	query_text: TEXT_FIELD
			-- Text field for query input

	input_text: TEXT_FIELD;
			-- Text field for file name of input file

	query_label,
			-- Label for `query_text'

	input_label,
			-- Label for `input_text'

	compilation_label: LABEL
			--Label for 'compilation mode buttons' 

	menu_bar: BAR;
			-- Menu bar

	help_menu,
			-- Help menu

	command_menu,
			-- Menu for commands

	file_menu: MENU_PULL;
			-- File menu

	window_menu: MENU_PULL;
			-- Windows menu

	command: SHOW_PROFILE_TOOL;
			-- Command that invokes Current

	open_tools: LINKED_LIST [PROFILE_QUERY_WINDOW]
			-- List of all open query windows

feature {NONE} -- Execution Arguments

	browse_it: ANY is
		once
			!! Result
		end

feature -- Update

	close is
			-- Close Current
		local
			a_wnd: PROFILE_QUERY_WINDOW
		do
			from
				open_tools.start
			until
				open_tools.after
			loop
				a_wnd := open_tools.item;
				a_wnd.popdown;
				a_wnd.destroy;
				open_tools.remove
			end;
			command.done_profiling
		end

feature -- Update

	update_graphical_resources is
			-- Update the graphical resources of the profile
			-- query tool's text.
		do
			top_shell_show;
			from
				open_tools.start
			until
				open_tools.after
			loop
				open_tools.item.update_graphical_resources;
				open_tools.forth
			end;
		end;

	show is
			-- Show Current and open_tools.
		do
			top_shell_show;
			from
				open_tools.start
			until
				open_tools.after
			loop
				open_tools.item.popup;
				open_tools.forth
			end;
		end;

	hide is
			-- Hide Current and open_tools.
		do
			top_shell_hide;
			from
				open_tools.start
			until
				open_tools.after
			loop
				open_tools.item.popdown;
				open_tools.forth
			end;
		end

feature {NONE} -- Execution

	execute (arg: ANY) is
			-- Execute Current
		do
			if arg = browse_it then
					--| User wants to browse
				browse_for_inputfile
			elseif arg = last_name_chooser then
					--| User came up with OK in file selection
				input_text.set_text (last_name_chooser.selected_file);
				last_name_chooser.popdown
			end
		end

feature {NONE} -- Implementation

	browse_for_inputfile is
			-- Bring up a dialog with which the user can browse for an
			-- input file.
		local
			new_name_chooser: NAME_CHOOSER_W
		do
			new_name_chooser := name_chooser (Current)
			new_name_chooser.set_title (Interface_names.t_Browse);
			new_name_chooser.set_pattern ("*.pfi")
			new_name_chooser.set_pattern_name ("Profile File Info (*.pfi)")
			new_name_chooser.set_file_selection
			new_name_chooser.hide_help_button;
			new_name_chooser.show_filter_button;
			new_name_chooser.add_ok_action (Current, Void);
			new_name_chooser.call (Current)
		end;

	working_directory : STRING is
		do
			!! Result.make(0)
			if input_text.text.has(Operating_environment.Directory_separator) then
				Result := ""
			else
				Result.append ("EIFGEN")
				Result.extend (Operating_environment.Directory_separator)
				if workbench_button.state then
					Result.append ("W_code")
					Result.extend (Operating_environment.Directory_separator)
				else
					Result.append ("F_code")
					Result.extend (Operating_environment.Directory_separator)
				end
			end
		end --| Guillaume - 09/26/97

feature {PROFILE_QUERY_WINDOW} -- Window updates

	query_window_is_closed (a_window: PROFILE_QUERY_WINDOW) is
			-- Update list of open query_windows.
		do
			open_tools.start;
			open_tools.prune (a_window)
		end

end -- class PROFILE_TOOL
