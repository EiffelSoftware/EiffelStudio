indexing
	description: "[
		Objects that represent an externally docked tools window.
		Used for tracking of external windows.
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_TOOL_WINDOW
	
create
	make_with_info
	
feature {NONE} -- Initialization

	make_with_info (a_window: EV_WINDOW; a_tool: EV_WIDGET; a_development_window: EB_DEVELOPMENT_WINDOW; an_x_position, a_y_position: INTEGER) is
			-- Create `Current' representing `a_window' as window of tool `a_tool', relative to `a_development_window', and a position
			-- of `an_x_position', `a_y_position' relative to `a_development_window'.
		require
			window_not_void: a_window /= Void
			tool_not_void: a_tool /= Void
			development_window_not_void: a_development_window /= Void
		do
			window := a_window
			development_window := a_development_window
			tool := a_tool
			x_position := an_x_position
			y_position := a_y_position
			development_window.add_tool_window (Current)
		end

feature -- Access

	tool: EV_WIDGET
		-- Tool contained in `window'.

	window: EV_WINDOW
		-- Window represented by `Current', an externally docked tool that must be tracked
		-- by `development_window'.
	
	x_position: INTEGER
		-- X position of `window', relative to `development_window'.
	
	y_position: INTEGER
		-- Y position of `window', relative to `development_window'.
	
	development_window: EB_DEVELOPMENT_WINDOW
		-- A development window to which `window' is displayed to.

feature -- Status setting

	set_x_position (an_x_position: INTEGER) is
			-- Assign `an_x_position' to `x_position'.
		do
			x_position := an_x_position
		end
		
	set_y_position (a_y_position: INTEGER) is
			-- Assign `a_y_position' to `y_position'.
		do
			y_position := a_y_position
		end

invariant
	window_not_void: window /= Void
	development_window_not_void: development_window /= Void
	tool_not_void: tool /= Void

end -- class EB_TOOL_WINDOW
