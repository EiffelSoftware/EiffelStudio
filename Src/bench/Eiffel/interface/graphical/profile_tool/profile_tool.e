indexing

	description:
		"Tool for graphical output of the profiler.";
	date: "$Date$";
	revision: "$Revision$"

class PROFILE_TOOL

inherit
	TOP_SHELL
		rename
			make as top_shell_make,
			realize as display
		end;
	COMMAND;
	WINDOWS

creation
	make

feature {NONE} -- Initialization

	make (a_command: SHOW_PROFILE_TOOL) is
		require
			a_command_not_void: a_command /= Void
		do
			command := a_command;
			top_shell_make ("Profile Tool", Project_tool.screen);
			build_widgets
		end

feature {NONE} -- Graphical User Interface

	build_widgets is
		do
				-- User Interface Components
			!! global_form.make ("", Current);

			!! switch_form.make ("", global_form);
			!! language_form.make ("", global_form);
			!! text_form.make ("", global_form);
			!! button_form.make ("", global_form);
			button_form.set_fraction_base (2);

			!! menu_bar.make ("", global_form);
			!! file_menu.make ("File", menu_bar);
			!! command_menu.make ("Commands", menu_bar);
			!! switch_menu.make ("Switches", menu_bar);

			!! exit_button.make ("Exit", button_form);
			!! run_button.make ("Run Query", button_form);

			!! name_switch.make ("Feature name", switch_form);
			name_switch.set_toggle_on;
			!! number_of_calls_switch.make ("Number of calls", switch_form);
			number_of_calls_switch.set_toggle_on;
			!! time_switch.make ("Function time", switch_form);
			!! descendent_switch.make ("Descendent time", switch_form);
			!! total_time_switch.make ("Total time", switch_form);
			!! percentage_switch.make ("Percentage", switch_form);

			!! eiffel_switch.make ("Eiffel features", language_form);
			eiffel_switch.set_toggle_on;
			!! c_switch.make ("C functions", language_form);
			!! recursive_switch.make ("Recursive functions", language_form);

			!! input_label.make ("Input file", text_form);
			!! input_text.make ("", text_form);
			!! query_label.make ("Query", text_form);
			!! query_text.make ("", text_form);

				-- Commands
			exit_button.add_activate_action (Current, exit_it);

				-- Attachments
			global_form.attach_top (switch_form, 0);
			global_form.attach_left (switch_form, 0);
			global_form.attach_bottom_widget (language_form, switch_form, 1);
			global_form.attach_right (switch_form, 0);
			global_form.attach_left (language_form, 0);
			global_form.attach_bottom_widget (text_form, language_form, 1);
			global_form.attach_right (language_form, 0);
			global_form.attach_left (text_form, 0);
			global_form.attach_bottom_widget (button_form, text_form, 1);
			global_form.attach_right (text_form, 0);			
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

			text_form.attach_top (input_label, 5);
			text_form.attach_left (input_label, 0);
			text_form.attach_bottom_widget (input_text, input_label, 2);
			text_form.attach_left (input_text, 5);
			text_form.attach_bottom_widget (query_label, input_text, 5);
			text_form.attach_right (input_text, 5);
			text_form.attach_left (query_label, 0);
			text_form.attach_bottom_widget (query_text, query_label, 5);
			text_form.attach_left (query_text, 5);
			text_form.attach_bottom (query_text, 5);
			text_form.attach_right (query_text, 5);

				-- Sizing policy
			set_size (400, 400)
		end

feature {NONE} -- Attributes

	global_form,
			-- Form for Current

	button_form,
			-- Form for the buttons

	text_form: FORM;
			-- Form to display text fields on

	run_button,
			-- Button to run the query

	exit_button: PUSH_B;
			-- Button to exit the tool with

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

	descendent_switch,
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

	query_text,
			-- Text field for query input

	input_text: TEXT_FIELD;
			-- Text field for file name of input file

	query_label,
			-- Label for `query_text'

	input_label: LABEL;
			-- Label for `input_text'

	menu_bar: BAR;
			-- Menu bar

	command_menu,
			-- Menu for commands

	switch_menu,
			-- Menu for certain switches

	file_menu: MENU_PULL;
			-- File menu

	command: SHOW_PROFILE_TOOL
			-- Command that invokes Current

feature {NONE} -- Execution Arguments

	exit_it: ANY is
		once
			!! Result
		end

feature {NONE} -- Execution

	execute (arg: ANY) is
			-- Execute Current
		do
			if arg = exit_it then
				command.done_profiling
			end
		end

end -- class PROFILE_TOOL
