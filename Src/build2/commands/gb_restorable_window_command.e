indexing
	description: "Objects that represent two state commands%
		%for display/hiding restorable windows."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_RESTORABLE_WINDOW_COMMAND
	
inherit
	GB_TWO_STATE_COMMAND
	
	GB_CONSTANTS
		export
			{NONE} all
		end
	
	GB_SHARED_SYSTEM_STATUS
		export
			{NONE} all
		end
		
	GB_SHARED_TOOLS

feature -- Access

	window: EV_DIALOG is
			-- Result is window referenced by
			-- `Current' command.
		deferred
		end

feature -- Status setting

	execute is
			-- Execute command (toggle between show and hide).
		do
			reverse_is_selected
			if is_selected then
				
				if not already_displayed then
					already_displayed := True
						-- If the window is empty, then we give a default size.
					if window.is_empty then
						window.set_size (default_window_dimension, default_window_dimension)
						--| FIXME builder window and display window will now show in exactly the same position.
--							-- Ensure that the windows are not displayed directly on top of each other.
--							-- This only seems to happen when they are shown relative.
--						if display_window.x_position = window.x_position and
--							display_window.y_position = window.y_position then
--							window.set_position (window.x_position + 5, window.y_position + 5)
--						end
					end
				else
						-- Restore previous positions.
					window.set_position (previous_x, previous_y)
					window.set_size (previous_width, previous_height)
				end
				
					-- If we are in wizard mode from Visual Studio,
					-- then we must show the window relative to the
					-- main window. This is because we are shown modally
					-- to Visual Studio, and otherwise, the windows
					-- become very annoying.				
				if system_status.is_wizard_system then
					window.show_relative_to_window (first_window)
				elseif system_status.tools_always_on_top then
					window.show_relative_to_window (main_window)
				else
					window.show
				end
			else
					-- Store previous dimensions so we can restore
					-- them when the window is displayed again.
				previous_x := window.x_position
				previous_y := window.y_position
				previous_width := window.width
				previous_height := window.height
					-- Hide the window.		
				window.hide
			end
			update_controls (is_selected)
		end

feature {NONE} -- Implementation
		
	first_window: WIZARD_WINDOW is
			-- `Result' is window reference
			-- by `Current'.
		deferred
		end
		
	previous_x, previous_y: INTEGER
		-- Coordinates displayed previously
		
	previous_width, previous_height: INTEGER
		-- Dimensions of previous display.
		
	already_displayed: BOOLEAN

end -- class GB_RESTORABLE_WINDOW_COMMAND
