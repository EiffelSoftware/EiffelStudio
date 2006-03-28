indexing
	description: "Drawer that draw tool bar item base on theme on different platform."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_DRAWER

create
	make

feature{NONE} -- Initlization

	make (a_tool_bar: SD_TOOL_BAR) is
			-- Creation method
		do
			create {SD_TOOL_BAR_DRAWER_IMP} implementation.make (a_tool_bar)
		end

feature -- Command

	start_draw (a_rectangle: EV_RECTANGLE) is
			-- Called when start drawing, after draw should call `end_draw'.
			-- This function is used for double buffer
			-- `a_rectangle' is rectangle area to be double buffered.			
		require
			not_void: a_rectangle /= Void
		do
			implementation.start_draw (a_rectangle)
		end

	end_draw is
			-- After called `start_draw', when end drawing should call this.
		do
			implementation.end_draw
		end

	draw_item (a_arguments: SD_TOOL_BAR_DRAWER_ARGUMENTS) is
			-- Draw `a_item' on `a_tool_bar' at `a_position'.
		require
			not_void: a_arguments /= Void
			valid: a_arguments.is_valid
		do
			implementation.draw_item (a_arguments)
		end

feature {NONE} -- Implementation

	implementation: SD_TOOL_BAR_DRAWER_I
			-- Implementation

end
