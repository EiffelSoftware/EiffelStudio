indexing

	description:
		"Command to close manage tools (raise, close, tile)."
	date: "$Date$"
	revision: "$Revision$"

class TOOLS_MANAGEMENT

inherit
	ISE_COMMAND
	EB_CONSTANTS
	WINDOWS

creation
	make_close_all,
	make_raise_all

feature {NONE} -- Initialization

	make_close_all is
			-- Create command to close all tools.
		do
			tool_action := Close_all_tools_action
		end

	make_raise_all is
			-- Create command to raise all tools.
		do
			tool_action := Raise_all_tools_action
		end

feature -- Properties

	Close_all_tools_action, Raise_all_tools_action: INTEGER is unique
			-- Action values

	tool_action: INTEGER
			-- Action value to be performed on tool

	name: STRING is 
			-- Current's name
		do
			inspect 
				tool_action
			when Close_all_tools_action then
				Result := Interface_names.f_Close_all_tools
			when Raise_all_tools_action then
				Result := Interface_names.f_Raise_all_tools
			end
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			inspect 
				tool_action
			when Close_all_tools_action then
				Result := Interface_names.m_Close_all_tools
			when Raise_all_tools_action then
				Result := Interface_names.m_Raise_all_tools
			end
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

feature {NONE} -- Execution

	work (arg: ANY) is
		do
			inspect 
				tool_action
			when Close_all_tools_action then
				window_manager.close_all_editors
				if is_system_tool_created then 
					System_tool.close
				end
				if Profile_tool /= Void then
--					Profile_tool.close
				end
				if Preference_tool /= Void then
--					Preference_tool.close
				end
				if is_dynamic_lib_tool_created then
					Dynamic_lib_tool.close
				end
			when Raise_all_tools_action then
				window_manager.raise_all_editors
				if is_system_tool_created then 
					System_tool.force_raise
				end
				if Profile_tool /= Void then
--					Profile_tool.raise
				end
				if Preference_tool /= Void then
--					Preference_tool.raise
				end
				if is_dynamic_lib_tool_created then
					Dynamic_lib_tool.force_raise
				end
			end
		end

end -- class TOOLS_MANAGEMENT
