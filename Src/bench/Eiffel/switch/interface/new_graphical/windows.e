indexing
	description: "All shared access windows."
	date: "$Date$"
	revision: "$Revision $"

class
	WINDOWS

feature {NONE}

	Project_tool: PROJECT_W is
			-- Main and unique control window
		once
			!! Result.make (ewb_display)
		end

	Transporter: TRANSPORTER is
		once
			!! Result.make (project_tool)
		end

	System_tool: SYSTEM_W is
			-- Unique assembly tool
		once
			!! Result.make (ewb_display)
			is_system_tool_created := True
		end

	is_system_tool_created: BOOLEAN
			-- To know if the system tool has been created.

	Dynamic_lib_tool: DYNAMIC_LIB_W is
			-- Unique assembly tool
		once
			!! Result.make (ewb_display)
			is_dynamic_lib_tool_created := True
		end

	is_dynamic_lib_tool_created: BOOLEAN
			-- To know if the Dynamic_lib tool has been created.

	name_chooser (popup_parent: COMPOSITE): NAME_CHOOSER_W is
			-- File selection window
		require
			popup_parent_not_void: popup_parent /= Void
		do
			!! Result.make (popup_parent)
			Result.set_window (popup_parent)
			if last_name_chooser /= Void and then not last_name_chooser.destroyed then
				last_name_chooser.popdown
				last_name_chooser.destroy
			end
			last_name_chooser_cell.put (Result)
		ensure
			last_name_chooser_set: equal (last_name_chooser, Result)
		end

	last_name_chooser: NAME_CHOOSER_W is
			-- Last name chooser created
		do
			Result := last_name_chooser_cell.item
		end

	warner (popup_parent: COMPOSITE): WARNER_W is
			-- Warning window associated with `window'
		require
			popup_parent_not_void: popup_parent /= Void
		local
			old_warner: WARNER_W
		do
			!! Result.make (popup_parent)
			Result.set_window (popup_parent)
			old_warner := last_warner
			if old_warner /= Void and then not old_warner.destroyed then
				old_warner.popdown
				old_warner.destroy
			end
			last_warner_cell.put (Result)
		end

	last_warner: WARNER_W is
			-- Last warner window created
		do
			Result := last_warner_cell.item
		end

	confirmer (popup_parent: COMPOSITE): CONFIRMER_W is
			-- Confirmation widget associated with `window'
		require
			popup_parent_not_void: popup_parent /= Void
		local
			old_confirmer: CONFIRMER_W
		do
			!! Result.make (popup_parent)
			Result.set_window (popup_parent)
			old_confirmer := last_confirmer
			if old_confirmer /= Void and then not old_confirmer.destroyed then
				old_confirmer.popdown
				old_confirmer.destroy
			end
			last_confirmer_cell.put (Result)
		end

	last_confirmer: CONFIRMER_W is
			-- Last confirmer window created
		do
			Result := last_confirmer_cell.item
		end

	routine_custom_window (popup_parent: COMPOSITE): ROUTINE_CUSTOM_W is
			-- Routine custom window associated with `popup_parent'
		require
			popup_parent_not_void: popup_parent /= Void
		do
			!! Result.make (popup_parent)
			if last_routine_custom_window /= Void then
				last_routine_custom_window.popdown
				last_routine_custom_window.destroy
			end
			last_routine_custom_window_cell.put (Result)
		end

	last_routine_custom_window: ROUTINE_CUSTOM_W is
			-- Last routine custom window created
		do
			Result := last_routine_custom_window_cell.item
		end

	error_window: OUTPUT_WINDOW is
			-- Error window that displays error message
		once
			if mode.item then
				Result := term_window
			else
				Result := bench_error_window
			end
		end

	Debug_window: TEXT_WINDOW is
			-- Debug window
		once
			Result := bench_error_window
		end

	Window_manager: WINDOW_MGR is
			-- Window manager for ebench windows
		once
			!! Result.make (project_tool.screen)
		end

	Argument_window: ARGUMENT_W is
			-- General argument window.
		once
			!! Result.make
		end

	Preference_tool: EB_PREFERENCE_TOOL is
			-- The preference tool
		do
			Result := preference_tool_cell.item
		end

	Profile_tool: EB_PROFILE_TOOL is
			-- The profile tool
		do
			Result := profile_tool_cell.item
		end

	Progress_dialog: DEGREE_OUTPUT is
		do
			Result := Project_tool.progress_dialog
		end

feature {NONE} -- Implementation

	last_warner_cell: CELL [WARNER_W] is
			-- Cell containing the last warner window created
		once
			!! Result.put (Void)
		end

	last_confirmer_cell: CELL [CONFIRMER_W] is
			-- Cell containing the last confirmer window created
		once
			!! Result.put (Void)
		end

	last_name_chooser_cell: CELL [NAME_CHOOSER_W] is
			-- Cell containing the last name chooser window created
		once
			!! Result.put (Void)
		end

	last_routine_custom_window_cell: CELL [ROUTINE_CUSTOM_W] is
			-- Cell containing the last name routine custom window created
		once
			!! Result.put (Void)
		end

	mode: BOOLEAN_REF is
		once
			!! Result
			Result.set_item (True)
		end

	bench_error_window: TEXT_WINDOW is
		do
			Result := project_tool.text_window
		end

	term_window: TERM_WINDOW is
		once
			!! Result
		end

	preference_tool_cell: CELL [EB_PREFERENCE_TOOL] is
			-- Cell for the preference tool
		once
			!! Result.put (Void)
		end

	profile_tool_cell: CELL [EB_PROFILE_TOOL] is
			-- Cell for the profile tool
		once
			!! Result.put (Void)
		end

feature {NONE} -- Implementation

	init_windowing is
			-- Initialize the windowing environment.
		local
			new_resources: EB_RESOURCES
			display_name: STRING
			exc: EXCEPTIONS
			exec_env: EXECUTION_ENVIRONMENT
			g_degree_output: GRAPHICAL_DEGREE_OUTPUT
			launched_project_tool: PROJECT_W
		do
			if not ewb_display.is_valid then
				io.error.putstring ("Cannot open display %"")
				!! exec_env
				display_name := exec_env.get ("DISPLAY")
				if display_name /= Void then
					io.error.putstring (display_name)
				end
				io.error.putstring ("%"%N%
					%Check that $DISPLAY is properly set and that you are%N%
					%authorized to connect to the corresponding server%N")
				!! exc
				exc.raise ("Invalid display")
			end
				--| If we don't put bench mode here,
				--| `error_window' will assume batch
				--| mode and thus it will initialize
				--| `error_window' as a TERM_WINDOW.
				--| Also note that `error_window' is a
				--| once-function!!
			mode.set_item (False)
			!! new_resources.initialize
			launched_project_tool := Project_tool
		end

	ewb_display: SCREEN is
			-- Display of $EiffelGraphicalCompiler$.
		local
			p: PLATFORM_CONSTANTS
		once
			!! p
			if p.is_vms then
				!! Result.make ("")
			else
				!! Result.make (Void)
			end
		end

end -- class WINDOWS
