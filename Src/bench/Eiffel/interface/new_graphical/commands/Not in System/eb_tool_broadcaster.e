indexing

	description:
		"Command to close manage tools (raise, close, tile)."
	date: "$Date$"
	revision: "$Revision$"

class EB_TOOL_BROADCASTER

inherit
	EV_COMMAND
	NEW_EB_CONSTANTS
	EB_SHARED_INTERFACE_TOOLS

feature {NONE} -- Execution

	close_all is
			-- Close all tools.
		do
			tool_supervisor.close_all_editors
			if system_tool_is_valid then 
				System_tool.destroy
			end
			if  profiler_is_valid then
				profiler_window.destroy
			end
--			if preference_tool_is_valid then
--				preference_tool.destroy
--			end
			if dynamic_lib_tool_is_valid then
				Dynamic_lib_tool.destroy
			end
		end

	raise_all is
			-- Raise all tools.
		do
			tool_supervisor.raise_all_editors
			if system_tool_is_valid then 
				System_tool.raise
			end
			if profiler_is_valid then
				profiler_window.raise
			end
--			if preference_window_is_valid then
--				preference_window.raise
--			end
			if dynamic_lib_tool_is_valid then
				Dynamic_lib_tool.raise
			end
		end

	raise_non_saved is
			-- Raise non saved tools
		do
			tool_supervisor.raise_all_unsaved_editors
		end

end -- class EB_TOOL_BROADCASTER
