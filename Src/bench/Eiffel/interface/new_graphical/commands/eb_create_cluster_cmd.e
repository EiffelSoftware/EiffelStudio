indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CREATE_CLUSTER_CMD

inherit
	EV_COMMAND

	EB_SHARED_INTERFACE_TOOLS

creation
	default_create

feature {NONE} -- Implementation

	create_cluster_tool (a_stone: STONE) is
			-- Create a class tool and process `a_stone'.
		require
--			valid_a_stone: a_stone /= Void and then a_stone.is_valid
		local
			new_tool: EB_CLUSTER_TOOL
		do
			new_tool := tool_supervisor.new_cluster_tool
			new_tool.show
			new_tool.force_stone (a_stone)
		end

end -- class EB_CREATE_CLUSTER_CMD
