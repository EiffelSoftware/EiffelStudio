indexing

	description:
		"EiffelBench profiler tool."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PROFILE_TOOL

inherit
	EB_TOOL
		redefine
			show_imp, hide_imp
		end

	EV_COMMAND

	EB_CONSTANTS

	WINDOWS

	RESOURCE_USER
		redefine
			update_integer_resource
		end

	SYSTEM_CONSTANTS

creation
	make

feature {NONE} -- Initialization

--	make (a_command: EB_SHOW_PROFILE_TOOL) is
	make (man: EB_TOOL_CONTAINER; par: EV_WINDOW) is
		require
--			a_command_not_void: a_command /= Void
		do
			Profiler_resources.add_user (Current)

				-- Linking with parent
			parent := par
			manager := man
			set_title ("Profile Tool")

--			Precursor {EB_TOOL} (man, par)			

			create open_tools.make 
--			command := a_command

			
--			if Platform_constants.is_windows then
--					-- For windows we need the id for the Icon
--				top_shell_make (Interface_names.i_Class_id.out, Project_tool.screen)
--			else
--					-- For unix we need this for the X resource file
--			 	top_shell_make (Interface_names.n_X_resource_name, Project_tool.screen)
--			end
			
			set_title (Interface_names.t_Profile_tool)
--			set_icon_name (Interface_names.t_Profile_tool)
			init_commands
			build_widgets
		end


feature -- Updating

	update_integer_resource (old_res, new_res: INTEGER_RESOURCE) is
		local
--			pr: like Profiler_resources
		do
--			pr := Profiler_resources
--			if new_res.actual_value >= 0 then
--				if old_res = pr.tool_width then
--					set_width (new_res.actual_value)
--				elseif old_res = pr.tool_height then
--					set_height (new_res.actual_value)
--				elseif old_res = pr.query_tool_width then
--					from
--						open_tools.start
--					until
--						open_tools.after
--					loop
--						open_tools.item.set_width (new_res.actual_value)
--						open_tools.forth
--					end
--				elseif old_res = pr.query_tool_height then
--					from
--						open_tools.start
--					until
--						open_tools.after
--					loop
--						open_tools.item.set_height (new_res.actual_value)
--						open_tools.forth
--					end
--				end
--				old_res.update_with (new_res)
--			end
		end

feature -- Graphical User Interface

	show_new_window (st: STRUCTURED_TEXT; pq: PROFILER_QUERY;
				po: PROFILER_OPTIONS; profinfo: PROFILE_INFORMATION) is
			-- create and show a new EB_PROFILE_QUERY_WINDOW
		local
			new_window: EB_PROFILE_QUERY_WINDOW
		do
			create new_window.make (Current)
			new_window.show
			new_window.update_window (st, pq, po, profinfo)
			open_tools.extend (new_window)
		end

	display is
			-- Display the tool
		do
--			if not realized then
--				realize
--			else
--				show
--			end
--			raise
		end

feature {EB_RUN_PROFILE_QUERY_CMD} -- Access

	fill_values (shared_values: SHARED_QUERY_VALUES): BOOLEAN is
			-- Fill `shared_values' with value specified
			-- by the user.
		local
			parser: QUERY_PARSER
			filename: STRING
			i: INTEGER
			-- warner: EV_WARNING_DIALOG
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
			end
			if time_switch.state then
				shared_values.output_names.force ("self", i)
				i := i + 1
			end
			if descendant_switch.state then
				shared_values.output_names.force ("descendants", i)
				i := i + 1
			end
			if total_time_switch.state then
				shared_values.output_names.force ("total", i)
				i := i + 1
			end
			if percentage_switch.state then
				shared_values.output_names.force ("percentage", i)
				i := i + 1
			end
			if name_switch.state then
				shared_values.output_names.force ("featurename", i)
				i := i + 1
			end

				--| Copy the filename
			create filename.make(0)
			filename := input_text.text
			filename.prepend(working_directory)

			shared_values.filenames.force (filename, shared_values.filenames.lower)

				--| Copy the subqueries
			if not query_text.text.empty then
				create parser
				Result := parser.parse (query_text.text, shared_values)
			else
				Result := false
				-- create warner.make_default (Current, "Warning", "Verify your query!")
			end
		end

feature {NONE} -- Graphical User Interface

	build_widgets is
		local
			h_box: EV_HORIZONTAL_BOX
			switch_form, language_form, compile_form: EV_FRAME
			input_frame, query_frame: EV_FRAME
		do
				-- User Interface Components
			create container.make (parent)
			container.set_spacing (4)
			container.set_border_width (4)

			create h_box.make (container)
			h_box.set_spacing (4)

				-- Switches frame
			create switch_form.make_with_text (h_box, Interface_names.l_Output_switches)
			create switch_box.make (switch_form)
			create name_switch.make_with_text (switch_box, Interface_names.b_Feature_name)
			name_switch.set_state (True)
			create number_of_calls_switch.make_with_text (switch_box, Interface_names.b_Number_of_calls)
			number_of_calls_switch.set_state (True)
			create time_switch.make_with_text (switch_box, Interface_names.b_Function_time)
			create descendant_switch.make_with_text (switch_box, Interface_names.b_Descendant_time)
			create total_time_switch.make_with_text (switch_box, Interface_names.b_Total_time)
			create percentage_switch.make_with_text (switch_box, Interface_names.b_Percentage)

				-- Language Frame
			create language_form.make_with_text (h_box, Interface_names.l_Language_type)
			create language_box.make (language_form)
			create eiffel_switch.make_with_text (language_box, Interface_names.b_Eiffel_features)
			eiffel_switch.set_state (True)
			create c_switch.make_with_text (language_box, Interface_names.b_C_functions)
			create recursive_switch.make_with_text (language_box, Interface_names.b_Recursive_functions)

				-- Compilation Mode Frame
			create compile_form.make_with_text (container, "Input file compilation type")
			create compile_box.make (compile_form)
			create workbench_button.make_with_text (compile_box, Interface_names.b_Workbench)
			workbench_button.set_state (True)
			create final_button.make_with_text (compile_box, Interface_names.b_Final)

				-- Input File Frame
			create input_frame.make_with_text (container, Interface_names.l_Input_file)
			create h_box.make (input_frame)
			create input_text.make_with_text (h_box, Interface_names.t_Empty)
			input_text.set_text ("profinfo.pfi")
			create browse_button.make_with_text (h_box, Interface_names.b_Browse)
			browse_button.set_minimum_width (100)
			browse_button.set_horizontal_resize (False)
			browse_button.set_vertical_resize (False)
--			browse_button.add_click_command (Current, browse_it)

				-- Query Frame
			create query_frame.make_with_text (container, Interface_names.l_Query)
			create query_text.make_with_text (query_frame, Interface_names.t_Empty)
			query_text.set_horizontal_resize (True)
			query_text.add_activate_command (run_prof_query_cmd, Void)

				-- Button bar
			create button_bar.make (container)
			button_bar.set_expand (False)
			button_bar.set_border_width (4)

			create run_button.make_with_text (button_bar, Interface_names.b_Run_query)
			run_button.add_click_command (run_prof_query_cmd, Void)
			run_button.set_minimum_width (100)
			run_button.set_horizontal_resize (False)
			run_button.set_vertical_resize (False)
			create exit_button.make_with_text (button_bar, Interface_names.b_Exit)
			exit_button.add_click_command (quit_cmd, Void)
			exit_button.set_minimum_width (100)
			exit_button.set_horizontal_resize (False)
			exit_button.set_vertical_resize (False)

				-- Sizing policy
			set_minimum_size (Profiler_resources.tool_width.actual_value,
				Profiler_resources.tool_height.actual_value)
		end

init_commands is
			-- Initialize basic commands
		do
			create quit_cmd.make (Current)
			create run_prof_query_cmd.make (Current)
		end
	

feature {NONE} -- Execution Arguments

	browse_it: EV_ARGUMENT1 [ANY] is
		once
			create Result.make (Void)
		end

feature -- Update

	close is
			-- Close Current
		local
--			a_wnd: EB_PROFILE_QUERY_WINDOW
		do
--			from
--				open_tools.start
--			until
--				open_tools.after
--			loop
--				a_wnd := open_tools.item
--				a_wnd.popdown
--				a_wnd.destroy
--				open_tools.remove
--			end
			command.done_profiling
		end

feature -- Update

	update_graphical_resources is
			-- Update the graphical resources of the profile
			-- query tool's text.
		do
			show
			from
				open_tools.start
			until
				open_tools.after
			loop
				open_tools.item.update_graphical_resources
				open_tools.forth
			end
		end

feature {EB_TOOL_CONTAINER} -- Widget Implementation

	show_imp is
			-- Show Current and open_tools.
		do
			container.show
			from
				open_tools.start
			until
				open_tools.after
			loop
				open_tools.item.show
				open_tools.forth
			end
		end

	hide_imp is
			-- Hide Current and open_tools.
		do
			container.hide
			from
				open_tools.start
			until
				open_tools.after
			loop
				open_tools.item.hide
				open_tools.forth
			end
		end

feature {NONE} -- Execution

	execute (arg: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
			-- Execute Current
		do
			if arg = browse_it then
					--| User wants to browse
				browse_for_inputfile
			elseif arg.first = last_name_chooser then
					--| User came up with OK in file selection
				input_text.set_text (last_name_chooser.selected_file)
				last_name_chooser.hide
			end
		end

feature {NONE} -- Implementation

	browse_for_inputfile is
			-- Bring up a dialog with which the user can browse for an
			-- input file.
		local
		--	new_name_chooser: EV_FILE_OPEN_DIALOG
		--	arg: EV_ARGUMENT1 [EV_FILE_OPEN_DIALOG]
		do
--			new_name_chooser := name_chooser (Current)
		--	create new_name_chooser.make (container)
		--	new_name_chooser.set_title (Interface_names.t_Browse)
		--	new_name_chooser.set_default_extension ("pfi")
		--	new_name_chooser.set_filter ( <<"Profile File Info (*.pfi)">> , <<"*.pfi">>)
--			new_name_chooser.set_file_selection
		--	create arg.make (Current)
		--	new_name_chooser.add_ok_action (Current, Void)
		--	new_name_chooser.show
		end

	working_directory : STRING is
		do
			create Result.make(0)
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

feature {EB_PROFILE_QUERY_WINDOW} -- Window updates

	query_window_is_closed (a_window: EB_PROFILE_QUERY_WINDOW) is
			-- Update list of open query_windows.
		do
			open_tools.start
			open_tools.prune (a_window)
		end

feature -- Implementation

	container: EV_VERTICAL_BOX
			-- Form for Current

	
feature {NONE} -- Implementation

	button_bar: EV_HORIZONTAL_BOX
			-- Form for the buttons

	browse_button,
			-- Button to browse for input filename

	run_button,
			-- Button to run the query

	exit_button: EV_BUTTON
			-- Button to exit the tool with

	switch_box,
			-- Form to display switches on

	compile_box,

	language_box: EV_VERTICAL_BOX
			-- Form to display possible languages on

--	
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

	recursive_switch: EV_CHECK_BUTTON
			-- Switch for display of recursive funtions.

	workbench_button,
			-- Check button for workbench mode

	final_button: EV_RADIO_BUTTON
			-- Check button for final mode

	query_text: EV_TEXT_FIELD
			-- Text field for query input

	input_text: EV_TEXT_FIELD
			-- Text field for file name of input file

	query_label,
			-- Label for `query_text'

	input_label,
			-- Label for `input_text'

	compilation_label: EV_LABEL
			--Label for 'compilation mode buttons' 

	open_tools: LINKED_LIST [EB_PROFILE_QUERY_WINDOW]
			-- List of all open query windows

feature {EB_PROFILE_WINDOW} -- Commands

	quit_cmd: EB_QUIT_PROFILE_TOOL
			-- Command to quit Current

	run_prof_query_cmd: EB_RUN_PROFILE_QUERY_CMD
			-- Command to run the typed query

	command: EB_SHOW_PROFILE_TOOL
			-- Command that invokes Current

end -- EB_PROFILE_TOOL
