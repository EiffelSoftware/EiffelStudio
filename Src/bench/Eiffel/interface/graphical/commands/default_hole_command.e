class DEFAULT_HOLE_COMMAND

inherit
	HOLE_COMMAND
		redefine
			work
		end

feature -- Execution

	work (argument: ANY) is
		local
			ts: STONE;
			new_tool: TOOL_W
		do
			if holder.associated_button.tool = Project_tool then
				inspect 
					holder.associated_button.stone_type
				when Class_type then
					new_tool := window_manager.class_window
				when Routine_type then
					new_tool := window_manager.routine_window
				when Object_type then
					new_tool := window_manager.object_window
				when Explain_type then
					new_tool := window_manager.explain_window
				when System_type then
					new_tool := system_tool;
				end;
				if new_tool /= Void then
					new_tool.display
				end
			else
				ts ?= holder.associated_button.transported_stone;
				if ts /= Void then
					holder.associated_button.tool.receive (holder.associated_button.transported_stone)
				end
			end
		end;

end -- class DEFAULT_HOLE_COMMAND
