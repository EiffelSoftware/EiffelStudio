indexing

	description:
		"Command to quit from the profile tool.";
	date: "$Date$";
	revision: "$Revision$"

class QUIT_PROFILE_TOOL

inherit
	TOOL_COMMAND
		rename
			tool as old_tool
		end

creation
	make

feature {NONE} -- Initialization

	make (a_tool: PROFILE_TOOL) is
			-- Create Current
		require
			a_tool_not_void: a_tool /= Void
		do
			tool := a_tool
		ensure
			tool_set: tool.is_equal (a_tool)
		end

feature -- Access

	name: STRING is
			-- Name for Current
		once
			!! Result.make (0);
			Result.append ("Exit");
		end;

	tool: PROFILE_TOOL
			-- Tool which Current relates to.

feature {NONE} -- Command execution

	work (arg: ANY) is
			-- Execute Current
		do
			tool.close
		end

end -- class QUIT_PROFILE_TOOL
