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

feature -- Initialization

	Close_all: EV_ARGUMENT1 [ANY] is
			-- Command to close all tools.
		once
			create Result.make (Void)
		end

	Raise_all: EV_ARGUMENT1 [ANY] is
			-- Command to raise all tools.
		once
			create Result.make (Void)
		end

feature -- Properties


--	name: STRING is 
--			-- Current's name
--		do
--			inspect 
--				tool_action
--			when Close_all_tools_action then
--				Result := Interface_names.f_Close_all_tools
--			when Raise_all_tools_action then
--				Result := Interface_names.f_Raise_all_tools
--			end
--		end

--	menu_name: STRING is
--			-- Name used in menu entry
--		do
--			inspect 
--				tool_action
--			when Close_all_tools_action then
--				Result := Interface_names.m_Close_all_tools
--			when Raise_all_tools_action then
--				Result := Interface_names.m_Raise_all_tools
--			end
--		end

--	accelerator: STRING is
--			-- Accelerator action for menu entry
--		do
--		end

feature {NONE} -- Execution

	execute (arg: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
		do
			if arg = Close_all then
				tool_supervisor.close_all_editors
--				if is_system_tool_is_valid then 
--					System_tool.destroy
--				end
				if  profile_tool_is_valid then
					profile_tool.destroy
				end
				if preference_tool_is_valid then
					preference_tool.destroy
				end
--				if dynamic_lib_tool_is_valid then
--					Dynamic_lib_tool.destroy
--				end
			elseif arg = Raise_all then
				tool_supervisor.raise_all_editors
--				if system_tool_is_valid then 
--					System_tool.force_raise
--				end
				if profile_tool_is_valid then
					profile_tool.raise
				end
				if preference_tool_is_valid then
					preference_tool.raise
				end
--				if dynamic_lib_tool_is_valid then
--					Dynamic_lib_tool.force_raise
--				end
			end
		end

end -- class EB_TOOL_BROADCASTER
