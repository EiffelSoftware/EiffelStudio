indexing
	description: "Objects that represent a horizontal split area which holds%
		%objects of type GB_TOOL_HOLDER."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_HORIZONTAL_SPLIT_AREA_TOOL_HOLDER

inherit
	GB_HORIZONTAL_SPLIT_AREA
	
	GB_TOOL_HOLDER_PARENT
		undefine
			default_create, is_equal, copy
		end
		
create
	make_with_tools
	
feature {NONE} -- Initialization

	make_with_tools (tool1, tool2: EV_WIDGET; title2: STRING) is
			-- Create `Current', add `tool1' to left side and add
			-- tool2 to a GB_TOOL_HOLDER with title `title2' and add
			-- this to right side.
		do
			default_create
			extend (tool1)
			create tool_holder.make_with_tool (tool2, title2)
			extend (tool_holder)
		end
		
feature -- Access

	tool_holder: GB_TOOL_HOLDER
		-- Tool holder containing right hand tool.
		
feature -- Basic operation

	minimize_tool (a_tool_holder: GB_TOOL_HOLDER) is
			-- Minimize `tool_holder'.
		do
			if a_tool_holder.maximized then
				a_tool_holder.disable_maximized
				a_tool_holder.reset_maximize_button
			end
			if a_tool_holder.minimized then
				resize_actions.wipe_out
				set_split_position (restore_position.min (maximum_split_position))
			else
				resize_actions.force_extend (agent keep_minimized_on_resize)
				restore_position := split_position
				set_split_position (maximum_split_position)
			end
		end
		
		
	maximize_tool (a_tool_holder: GB_TOOL_HOLDER) is
			-- Maximize `tool_holder'.
		do
			if a_tool_holder.minimized then
				resize_actions.wipe_out
				a_tool_holder.disable_minimized
				a_tool_holder.reset_minimize_button
			end
			if a_tool_holder.maximized then
				set_split_position (restore_position.min (maximum_split_position))
			else
				restore_position := split_position
				set_split_position (minimum_split_position)
			end
		end
		
feature {NONE} -- Implementation

	restore_position: INTEGER
		-- Position to restore to.
		
	keep_minimized_on_resize is
			-- Adjust splitter to keep tool minimized.
		do
			set_split_position (maximum_split_position)
		end

end -- class GB_HORIZONTAL_SPLIT_AREA_TOOL_HOLDER
