indexing
	description: "All shared access windows."
	date: "$Date$"
	revision: "$Revision $"

class
	EB_SHARED_INTERFACE_TOOLS

inherit
	EB_SHARED_OUTPUT_TOOLS
		redefine
			init_error_window
		end

feature {NONE} -- Shared tools access

	project_tool: EB_PROJECT_TOOL is
			-- Main and unique control window
		do
			Result := Project_tool_cell.item
		end

	project_tool_is_valid: BOOLEAN is
			-- Is the project tool avalible?
		do
			Result := (project_tool /= Void) and then
				(not project_tool.destroyed)
		end

	debug_tool: EB_DEBUG_TOOL is
			-- Shared debugger
		do
			Result := Debug_tool_cell.item
		end

	debug_tool_is_valid: BOOLEAN is
		do
			Result := (debug_tool /= Void) and then
				(not debug_tool.destroyed)
		end

	select_tool: EB_SELECT_TOOL is
			-- Tool selector
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
			-- Makes `tool' the shared project tool
		do
			Project_tool_cell.put (tool)
		end

	set_debug_tool (tool: EB_DEBUG_TOOL) is
			-- Makes `tool' the shared debugger.
		do
			Debug_tool_cell.put (tool)
		end

	set_select_tool (tool: EB_SELECT_TOOL) is
			-- Makes `tool' the shared selector.
		do
			Select_tool_cell.put (tool)
		end

	set_system_tool (tool: EB_SYSTEM_TOOL) is
			-- Makes `tool' the shared system tool.
		do
			System_tool_cell.put (tool)
		end

	set_preference_tool (tool: EB_PREFERENCE_TOOL) is
			-- makes `tool' the shared preference tool.
		do
			Preference_tool_cell.put (tool)
		end

	set_profile_tool (tool: EB_PROFILE_TOOL) is
			-- makes `tool' the shared profiler.
		do
			Profile_tool_cell.put (tool)
		end

	set_dynamic_lib_tool (tool: EB_DYNAMIC_LIB_TOOL) is
			-- makes `tool' the shared dynamic library tool.
		do
			Dynamic_lib_tool_cell.put (tool)
		end


feature

	Debug_window: EB_FORMATTED_TEXT is
			-- Debug window
		once
			Result := Debug_tool.text_window
		end

	window_manager, tool_supervisor: EB_TOOL_SUPERVISOR is
			-- Window manager for ebench windows
		do
			Result := Tool_supervisor_cell.item
		end

	set_tool_supervisor (t_s: EB_TOOL_SUPERVISOR) is
			-- Window manager for ebench windows
		do
			Tool_supervisor_cell.put (t_s)
		end

	Argument_list: STRING is
			-- arguments used while debugging.
		once
			create Result.make (0)
		end

	Progress_dialog: DEGREE_OUTPUT is
			-- Compilation advance dialog.
		do
			Result := Project_tool.progress_dialog
		end

feature {NONE} -- Implementation

	mode: BOOLEAN_REF is
		once
			create Result
			Result.set_item (True)
		end

	init_error_window: OUTPUT_WINDOW is
			-- Error window that displays error message
		do
			if mode.item then
				Result := term_window
			else
				Result := bench_error_window
			end
		end

	bench_error_window: EB_FORMATTED_TEXT is
		require
			debug_tool_exists: debug_tool_is_valid
		do
			Result := debug_tool.text_window
		end

	Project_tool_cell: CELL [EB_PROJECT_TOOL] is
			-- Cell for the project tool
		once
			create Result.put (Void)
		end

	Debug_tool_cell: CELL [EB_DEBUG_TOOL] is
			-- Cell for the debugger
		once
			create Result.put (Void)
		end

	Select_tool_cell: CELL [EB_SELECT_TOOL] is
			-- Cell for the selector
		once
			create Result.put (Void)
		end

	System_tool_cell: CELL [EB_SYSTEM_TOOL] is
			-- Cell for the system tool
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
			-- Cell for the dynamic library tool
		once
			create Result.put (Void)
		end

	Tool_supervisor_cell: CELL [EB_TOOL_SUPERVISOR] is
			-- Window manager for ebench windows
		once
			create Result.put (Void)
		end

end -- class EB_SHARED_INTERFACE_TOOLS
