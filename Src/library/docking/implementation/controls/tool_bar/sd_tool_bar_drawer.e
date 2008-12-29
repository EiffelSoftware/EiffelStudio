note
	description: "Drawer that draw tool bar item base on theme on different platform."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_DRAWER

create
	make

feature{NONE} -- Initlization

	make
			-- Creation method
		do
			create {SD_TOOL_BAR_DRAWER_IMP} implementation.make
		end

feature -- Command

	set_tool_bar (a_tool_bar: SD_TOOL_BAR)
			-- Set `a_tool_bar' where is Current to draw on.
		require
			not_void: a_tool_bar /= Void
		do
			implementation.set_tool_bar (a_tool_bar)
		end

	start_draw (a_rectangle: EV_RECTANGLE)
			-- Called when start drawing, after draw should call `end_draw'.
			-- This function is used for double buffer
			-- `a_rectangle' is rectangle area to be double buffered.			
		require
			not_void: a_rectangle /= Void
		do
			implementation.start_draw (a_rectangle)
		end

	end_draw
			-- After called `start_draw', when end drawing should call this.
		do
			implementation.end_draw
		end

	draw_item (a_arguments: SD_TOOL_BAR_DRAWER_ARGUMENTS)
			-- Draw `a_item' on `a_tool_bar' at `a_position'.
		require
			not_void: a_arguments /= Void
			valid: a_arguments.is_valid
		do
			implementation.draw_item (a_arguments)
		end

feature {SD_NOTEBOOK_TAB_DRAWER_IMP} -- Implementation

	implementation: SD_TOOL_BAR_DRAWER_I;
			-- Implementation

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end
