indexing
	description: "Implementation interface for SD_TOOL_BAR_DRAWER_IMP"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_TOOL_BAR_DRAWER_I

feature -- Commands

	start_draw (a_rectangle: EV_RECTANGLE) is
			-- Called when start drawing, after draw should call `end_draw'.
			-- This function is used for double buffer
			-- `a_rectangle' is rectangle area to be double buffered.
		require
			not_called: not is_start_draw_called
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
		deferred
		end

	to_sepcial_state (a_state: INTEGER): INTEGER is
			-- Convert SD_TOOL_BAR_ITEM_STATE to system specific state.
		require
			valid: (create {SD_TOOL_BAR_ITEM_STATE}).is_valid (a_state)
		deferred
		end
	
	desatuation (a_pixmap: EV_PIXMAP; a_k: REAL) is
			-- Desatuation `a_pixmap' with `a_k'.
		require
			valid: 0 < a_k  and a_k < 1
			not_void: a_pixmap /= Void
		deferred
		end

feature -- Query

	is_start_draw_called: BOOLEAN is
			-- If `start_draw' called?
		deferred
		end

end
