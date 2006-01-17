indexing
	description: "[
		Objects that represent an externally docked tools window.
		Used for tracking of external windows.
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

end -- class EB_TOOL_WINDOW
