indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CREATE_EXPLAIN_CMD

inherit
	EB_TOOL_COMMAND
		redefine
			tool
		end

	EB_SHARED_INTERFACE_TOOLS

creation
	make

feature {NONE} -- Implementation

	tool: EB_PROJECT_TOOL

	create_explain_tool (a_stone: STONE) is
			-- Create a class tool and process `a_stone'.
		require
--			valid_a_stone: a_stone /= Void and then a_stone.is_valid
		local
			new_tool: EB_EXPLAIN_TOOL
		do
			new_tool := tool_supervisor.new_explain_tool
			new_tool.show
--			new_tool.receive (a_stone)
		end

	execute (arg: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
		do
			create_explain_tool (Void)
		end

end -- class EB_CREATE_EXPLAIN_CMD
