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
		local
			iconable_tool: GB_ICONABLE_TOOL
		do
			reverse_is_selected
			if is_selected then
					-- If we are in wizard mode from Visual Studio,
					-- then we must show the window relative to the
					-- main window. This is because we are shown modally
					-- to Visual Studio, and otherwise, the windows
					-- become very annoying.
					
					-- Note that we must also update the icons on the windows,
					-- dependent on whether they are relative of not.
					-- This is because on Windows, if we have multiple windows
					-- show relative, they all share the same icon. Therefore,
					-- we need to set it to an appropriate one.
				iconable_tool ?= window
				if system_status.is_wizard_system then
					window.show_relative_to_window (first_window)
					iconable_tool.set_default_icon
				elseif system_status.tools_always_on_top then
					window.show_relative_to_window (main_window)
					iconable_tool.set_default_icon
				else
					window.show
					iconable_tool.restore_icon
				end
			else
					-- Ensure that the current position is really
					-- taken into account. This is required, as on Windows,
					-- it is sometimes lost.
				window.set_x_position (window.x_position)
				window.set_y_position (window.y_position)
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

end -- class GB_RESTORABLE_WINDOW_COMMAND
