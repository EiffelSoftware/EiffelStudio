indexing
	description: "All shared access windows."
	date: "$Date$"
	revision: "$Revision $"

class
	EB_SHARED_INTERFACE_TOOLS

feature {NONE} -- Shared tools access

	project_tool: EB_PROJECT_TOOL is
			-- Main and unique control window
		do
			Result := Project_tool_cell.item
		end

	project_tool_is_valid: BOOLEAN is
		do
			Result := (project_tool /= Void) and then
				(not project_tool.destroyed)
		end

	debug_tool: EB_DEBUG_TOOL is
			-- Main and unique control window
		do
			Result := Debug_tool_cell.item
		end

	debug_tool_is_valid: BOOLEAN is
		do
			Result := (debug_tool /= Void) and then
				(not debug_tool.destroyed)
		end

	select_tool: EB_SELECT_TOOL is
			-- Main and unique control window
		do
			Result := Select_tool_cell.item
		end

	select_tool_is_valid: BOOLEAN is
		do
			Result := (select_tool /= Void) and then
				(not select_tool.destroyed)
		end

	system_tool: EB_SYSTEM_TOOL is
			-- Unique assembly tool
		do
			Result := System_tool_cell.item
		end

	system_tool_is_valid: BOOLEAN is
		do
			Result := (system_tool /= Void) and then
				(not system_tool.destroyed)
		end

	preference_tool: EB_PREFERENCE_TOOL is
			-- The preference tool
		do
			Result := Preference_tool_cell.item
		end

	preference_tool_is_valid: BOOLEAN is
		do
			Result := (preference_tool /= Void) and then
				(not preference_tool.destroyed)
		end

	profile_tool: EB_PROFILE_TOOL is
			-- The profile tool
		do
			Result := Profile_tool_cell.item
		end

	profile_tool_is_valid: BOOLEAN is
		do
			Result := (profile_tool /= Void) and then
				(not profile_tool.destroyed)
		end

	dynamic_lib_tool: EB_DYNAMIC_LIB_TOOL is
			-- Unique assembly tool
		do
			Result := Dynamic_lib_tool_cell.item
		end

	dynamic_lib_tool_is_valid: BOOLEAN is
		do
			Result := (dynamic_lib_tool /= Void) and then
				(not dynamic_lib_tool.destroyed)
		end

feature {NONE} -- Shared tools change

	set_project_tool (tool: EB_PROJECT_TOOL) is
			-- Main and unique control window
		do
			Project_tool_cell.put (tool)
		end

	set_debug_tool (tool: EB_DEBUG_TOOL) is
			-- Main and unique control window
		do
			Debug_tool_cell.put (tool)
		end

	set_select_tool (tool: EB_SELECT_TOOL) is
			-- Main and unique control window
		do
			Select_tool_cell.put (tool)
		end

	set_system_tool (tool: EB_SYSTEM_TOOL) is
			-- Unique assembly tool
		do
			System_tool_cell.put (tool)
		end

	set_preference_tool (tool: EB_PREFERENCE_TOOL) is
			-- makes `tool' the shared preference tool
		do
			Preference_tool_cell.put (tool)
		end

	set_profile_tool (tool: EB_PROFILE_TOOL) is
			-- makes `tool' the shared profile tool
		do
			Profile_tool_cell.put (tool)
		end

	set_dynamic_lib_tool (tool: EB_DYNAMIC_LIB_TOOL) is
			-- Unique assembly tool
		do
			Dynamic_lib_tool_cell.put (tool)
		end


feature

	error_window: OUTPUT_WINDOW is
			-- Error window that displays error message
		once
			if mode.item then
				Result := term_window
			else
				Result := bench_error_window
			end
		end

	Debug_window: EB_FORMATTED_TEXT is
			-- Debug window
		once
			Result := Debug_tool.text_window
		end

	tool_supervisor: EB_TOOL_SUPERVISOR is
			-- Window manager for ebench windows
		do
			Result := Tool_supervisor_cell.item
		end

	set_tool_supervisor (t_s: EB_TOOL_SUPERVISOR) is
			-- Window manager for ebench windows
		do
			Tool_supervisor_cell.put (t_s)
		end

	Argument_window: ARGUMENT_W is
			-- General argument window.
		once
			!! Result.make
		end

	Progress_dialog: DEGREE_OUTPUT is
		do
			Result := Project_tool.progress_dialog
		end

feature {NONE} -- Implementation

	mode: BOOLEAN_REF is
		once
			create Result
			Result.set_item (True)
		end

	bench_error_window: EB_FORMATTED_TEXT is
		do
			Result := debug_tool.text_window
		end

	term_window: TERM_WINDOW is
		once
			create Result
		end

	Project_tool_cell: CELL [EB_PROJECT_TOOL] is
			-- Cell for the profile tool
		once
			create Result.put (Void)
		end

	Debug_tool_cell: CELL [EB_DEBUG_TOOL] is
			-- Cell for the profile tool
		once
			create Result.put (Void)
		end

	Select_tool_cell: CELL [EB_SELECT_TOOL] is
			-- Cell for the profile tool
		once
			create Result.put (Void)
		end

	System_tool_cell: CELL [EB_SYSTEM_TOOL] is
			-- Cell for the profile tool
		once
			create Result.put (Void)
		end

	Preference_tool_cell: CELL [EB_PREFERENCE_TOOL] is
			-- Cell for the preference tool
		once
			create Result.put (Void)
		end

	Profile_tool_cell: CELL [EB_PROFILE_TOOL] is
			-- Cell for the profile tool
		once
			create Result.put (Void)
		end

	Dynamic_lib_tool_cell: CELL [EB_DYNAMIC_LIB_TOOL] is
			-- Cell for the profile tool
		once
			create Result.put (Void)
		end

	Tool_supervisor_cell: CELL [EB_TOOL_SUPERVISOR] is
			-- Window manager for ebench windows
		once
			create Result.put (Void)
		end

feature {NONE} -- Implementation

--	init_windowing is
--			-- Initialize the windowing environment.
--		local
--			new_resources: EB_RESOURCES_INITIALIZER
--			display_name: STRING
--			exc: EXCEPTIONS
--			exec_env: EXECUTION_ENVIRONMENT
--			g_degree_output: GRAPHICAL_DEGREE_OUTPUT
--			launched_project_tool: EB_PROJECT_TOOL
--		do
--			if not ewb_display.is_valid then
--				io.error.putstring ("Cannot open display %"")
--				create exec_env
--				display_name := exec_env.get ("DISPLAY")
--				if display_name /= Void then
--					io.error.putstring (display_name)
--				end
--				io.error.putstring ("%"%N%
--					%Check that $DISPLAY is properly set and that you are%N%
--					%authorized to connect to the corresponding server%N")
--				create exc
--				exc.raise ("Invalid display")
--			end
--				--| If we don't put bench mode here,
--				--| `error_window' will assume batch
--				--| mode and thus it will initialize
--				--| `error_window' as a TERM_WINDOW.
--				--| Also note that `error_window' is a
--				--| once-function!!
--			mode.set_item (False)
--			create new_resources.initialize
--			launched_project_tool := Project_tool
--		end

end -- class EB_SHARED_INTERFACE_TOOLS
