indexing

	description: 
		"All shared access windows.";
	date: "$Date$";
	revision: "$Revision $"

class WINDOWS

feature {NONE}

	Project_tool: PROJECT_W is
			-- Main and unique control window
		once
			!!Result
		end;

	Focus_label: FOCUS_LABEL_I is
			-- Focus label
		once
			!FOCUS_LABEL! Result.initialize (Project_tool)
		end;

	Transporter: TRANSPORTER is
		once
			!! Result.make (project_tool)
		end;

	System_tool: SYSTEM_W is
			-- Unique assembly tool
		once
			!! Result.make
		end;

	name_chooser (popup_parent: COMPOSITE): NAME_CHOOSER_W is
			-- File selection window
		require
			popup_parent_not_void: popup_parent /= Void
		do
			!! Result.make (popup_parent);
			Result.set_window (popup_parent);
			if last_name_chooser /= Void then
				last_name_chooser.popdown;
				last_name_chooser.destroy
			end;
			last_name_chooser_cell.put (Result)
		ensure
			last_name_chooser_set: equal (last_name_chooser, Result)
		end;

	last_name_chooser: NAME_CHOOSER_W is
			-- Last name chooser created
		do
			Result := last_name_chooser_cell.item
		end;

	warner (popup_parent: COMPOSITE): WARNER_W is
			-- Warning window associated with `window'
		require
			popup_parent_not_void: popup_parent /= Void
		local
			old_warner: WARNER_W
		do
			!! Result.make (popup_parent);
			Result.set_window (popup_parent);
			old_warner := last_warner;
			if old_warner /= Void and then not old_warner.destroyed then
				old_warner.popdown;
				old_warner.destroy
			end;
			last_warner_cell.put (Result)
		end;

	last_warner: WARNER_W is
			-- Last warner window created
		do
			Result := last_warner_cell.item
		end;

	confirmer (popup_parent: COMPOSITE): CONFIRMER_W is
			-- Confirmation widget associated with `window'
		require
			popup_parent_not_void: popup_parent /= Void
		local
			old_confirmer: CONFIRMER_W
		do
			!! Result.make (popup_parent);
			Result.set_window (popup_parent);
			old_confirmer := last_confirmer;
			if old_confirmer /= Void then
				old_confirmer.popdown;
				old_confirmer.destroy
			end;
			last_confirmer_cell.put (Result)
		end;

	last_confirmer: CONFIRMER_W is
			-- Last confirmer window created
		do
			Result := last_confirmer_cell.item
		end;

	routine_custom_window (popup_parent: COMPOSITE): ROUTINE_CUSTOM_W is
			-- Routine custom window associated with `popup_parent'
		require
			popup_parent_not_void: popup_parent /= Void
		do
			!! Result.make (popup_parent);
			if last_routine_custom_window /= Void then
				last_routine_custom_window.popdown;
				last_routine_custom_window.destroy
			end;
			last_routine_custom_window_cell.put (Result)
		end;

	last_routine_custom_window: ROUTINE_CUSTOM_W is
			-- Last routine custom window created
		do
			Result := last_routine_custom_window_cell.item
		end;

	error_window: OUTPUT_WINDOW is
			-- Error window that displays error message
		once
			if mode.item then
				Result := term_window
			else
				Result := bench_error_window
			end;
		end;

	Debug_window: TEXT_WINDOW is
			-- Debug window
		once
			Result := bench_error_window
		end;

	Window_manager: WINDOW_MGR is
			-- Window manager for ebench windows
		once
			!! Result.make (project_tool.screen);
		end;

	Argument_window: ARGUMENT_W is
			-- General argument window.
		once
			!! Result.make_plain
		end;

	Preference_tool: EB_PREFERENCE_TOOL is
			-- The preference tool
		do
			Result := preference_tool_cell.item
		end;

	Profile_tool: PROFILE_TOOL is
			-- The profile tool
		do
			Result := profile_tool_cell.item
		end;

	Generate_window: DEGREE_OUTPUT is
			-- The generate window
		do
			Result := generate_window_cell.item
		end;

	Reverse_engineering_window: DEGREE_OUTPUT is
			-- The reverse engineering window
		do
			Result := reverse_engineering_window_cell.item
		end;

feature {NONE} -- Implementation

	last_warner_cell: CELL [WARNER_W] is
			-- Cell containing the last warner window created
		once
			!! Result.put (Void)
		end;

	last_confirmer_cell: CELL [CONFIRMER_W] is
			-- Cell containing the last confirmer window created
		once
			!! Result.put (Void)
		end;

	last_name_chooser_cell: CELL [NAME_CHOOSER_W] is
			-- Cell containing the last name chooser window created
		once
			!! Result.put (Void)
		end;

	last_routine_custom_window_cell: CELL [ROUTINE_CUSTOM_W] is
			-- Cell containing the last name routine custom window created
		once
			!! Result.put (Void)
		end;

	mode: CELL [BOOLEAN] is
		once
			!! Result.put (True)
		end;

	bench_error_window: TEXT_WINDOW is
		do
			Result := project_tool.text_window
		end;

	term_window: TERM_WINDOW is
		once
			!! Result
		end;

	preference_tool_cell: CELL [EB_PREFERENCE_TOOL] is
			-- Cell for the preference tool
		once
			!! Result.put (Void)
		end;

	profile_tool_cell: CELL [PROFILE_TOOL] is
			-- Cell for the profile tool
		once
			!! Result.put (Void)
		end;

	generate_window_cell: CELL [DEGREE_OUTPUT] is
			-- Cell for the generate window
		local
			dg: DEGREE_OUTPUT
		once
			!! dg;
			!! Result.put (dg)
		end;

	reverse_engineering_window_cell: CELL [DEGREE_OUTPUT] is
			-- Cell for the reverse engineering window
		local
			dg: DEGREE_OUTPUT
		once
			!! dg;
			!! Result.put (dg)
		end;

feature {NONE} -- Implementation

	init_windowing is
			-- Initialize the windowing environment.
		local
			new_resources: EB_RESOURCES;
			display_name: STRING;
			exc: EXCEPTIONS;
			exec_env: EXECUTION_ENVIRONMENT;
			eb_display: SCREEN;
			g_degree_output: GRAPHICAL_DEGREE_OUTPUT
		do
			!! eb_display.make ("");
			if not eb_display.is_valid then
				io.error.putstring ("Cannot open display %"");
				!! exec_env;
				display_name := exec_env.get ("DISPLAY");
				if display_name /= Void then
					io.error.putstring (display_name);
				end;
				io.error.putstring ("%"%N%
					%Check that $DISPLAY is properly set and that you are%N%
					%authorized to connect to the corresponding server%N");
				!! exc;
				exc.raise ("Invalid display");
			end;
				--| First we put bench mode, for
				--| `popup_file_selection' uses 
				--| `error_window'.
				--| If we don't put bench mode here,
				--| `error_window' will assume batch
				--| mode and thus it will initialize
				--| `error_window' as a TERM_WINDOW.
				--| Also note that `error_window' is a
				--| once-function!!
			mode.put (False);
			!! new_resources.initialize;
			project_tool.make (eb_display);
			project_tool.popup_file_selection;
			if not new_resources.is_graphical_output_disabled then
				!! g_degree_output;
				reverse_engineering_window_cell.put (g_degree_output);
				!! g_degree_output;
				generate_window_cell.put (g_degree_output);
			end
		end

end -- class WINDOWS
