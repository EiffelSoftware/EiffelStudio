indexing
	description: "Implementation interface for SD_TOOL_BAR_DRAWER_IMP"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_TOOL_BAR_DRAWER_I

feature -- Commands

	set_tool_bar (a_tool_bar: SD_TOOL_BAR) is
			-- Set `a_tool_bar'
		require
			not_void: a_tool_bar /= Void
		deferred
		end

	start_draw (a_rectangle: EV_RECTANGLE) is
			-- Called when start drawing, after draw should call `end_draw'.
			-- This function is used for double buffer
			-- `a_rectangle' is rectangle area to be double buffered.
		require
			not_called: not is_start_draw_called
			not_void: a_rectangle /= Void
			not_void: tool_bar /= Void
		deferred
		ensure
			called: is_start_draw_called
		end

	end_draw is
			-- After called `start_draw', when end drawing should call this.
		require
			called: is_start_draw_called
		deferred
		ensure
			not_called: not is_start_draw_called
		end

	draw_item (a_arguments: SD_TOOL_BAR_DRAWER_ARGUMENTS) is
			-- Draw `a_item' on `a_tool_bar' at `a_position'.
		require
			not_void: a_arguments /= Void
			not_void: tool_bar /= Void
		deferred
		end

	to_sepcial_state (a_state: INTEGER): INTEGER is
			-- Convert SD_TOOL_BAR_ITEM_STATE to system specific state.
		require
			valid: (create {SD_TOOL_BAR_ITEM_STATE}).is_valid (a_state)
		deferred
		end

feature -- Query

	is_start_draw_called: BOOLEAN is
			-- If `start_draw' called?
		deferred
		end

	tool_bar: SD_TOOL_BAR;
			-- Tool bar which to draw.

indexing
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
