indexing
	description: "Objects that represent two state commands%
		%for display/hiding restorable windows."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
					
				iconable_tool ?= window
				if components.system_status.tools_always_on_top then
					window.show_relative_to_window (components.tools.main_window)
				else
					window.show
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class GB_RESTORABLE_WINDOW_COMMAND
