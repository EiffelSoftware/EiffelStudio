indexing

	description:
		"Command to close all open tools.";
	date: "$Date$";
	revision: "$Revision$"

class CLOSE_ALL_CMD

inherit
	TOOL_COMMAND
		rename
			init as make
		end

creation
	make

feature -- Properties

	name: STRING is 
			-- Current's name
		do
			Result := Interface_names.f_close_all_tools
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_close_all_tools
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
			Result := Interface_names.a_close_all_tools
		end;

feature {NONE} -- Execution

	work (arg: ANY) is
		do
			window_manager.close_all_editors;
			System_tool.close;
			if Profile_tool /= Void then
				Profile_tool.close
			end;
			if Preference_tool /= Void then
				Preference_tool.close
			end
		end

end -- class CLOSE_ALL_CMD
