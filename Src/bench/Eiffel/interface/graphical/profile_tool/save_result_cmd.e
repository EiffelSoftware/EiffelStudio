indexing

	description:
		"Command to save the query and options %
		%currently displayed in a PROFILE_QUERY_WINDOW";
	date: "$Date$";
	revision: "$Revision$"

class SAVE_RESULT_CMD

inherit
	COMMAND_W

create
	make

feature {NONE} -- Initialization

	make (a_tool: PROFILE_QUERY_WINDOW) is
			-- Create Current and set `tool' to `a_tool'.
		require
			a_tool_not_void: a_tool /= Void
		do
			tool := a_tool
		ensure
			tool_set: tool.is_equal (a_tool)
		end

feature {NONE} -- Command Execution

	work (arg: ANY) is
			-- Execute Current
		local
			nc: NAME_CHOOSER_W
			file_name: STRING
		do
			if arg = Void then
				nc := name_chooser (tool);
				nc.set_save_file;
				nc.call (Current)
			else
				file_name := clone (last_name_chooser.selected_file)
				tool.save_in (file_name)
			end
		end

feature {NONE} -- Attributes

	tool: PROFILE_QUERY_WINDOW;

end -- class SAVE_RESULT_CMD
