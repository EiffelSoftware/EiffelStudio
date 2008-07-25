indexing
	description	: "All shared attributes specific to the development window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_DEVELOPMENT_WINDOW_DATA

feature {EB_DEVELOPMENT_WINDOW_DATA, EB_SHARED_PREFERENCES, EB_DEVELOPMENT_WINDOW_BUILDER, EB_DEVELOPMENT_WINDOW_DIRECTOR} -- Value

	maximized_width, width: INTEGER is
			-- Width for the development window
		deferred
		end

	maximized_height, height: INTEGER is
			-- Height for the development window
		deferred
		end

	maximized_x_position, x_position: INTEGER is
			-- X position for development windows
		deferred
		end

	maximized_y_position, y_position: INTEGER is
			-- Y position for development windows
		deferred
		end

	is_maximized: BOOLEAN is
			-- Is the development window maximized?
		deferred
		end

	is_minimized: BOOLEAN is
			-- Is the development window minimized?
		deferred
		end

	is_force_debug_mode: BOOLEAN is
			-- Is the development window force debug mode?
		deferred
		end

	context_unified_stone: BOOLEAN is
			-- Is the context tool linked?
		deferred
		end

	general_toolbar_layout: ARRAY [STRING] is
			-- Toolbar organization
		deferred
		end

	refactoring_toolbar_layout: ARRAY [STRING] is
			-- Toolbar organization
		deferred
		end

feature -- Element change

	save_size (a_width, a_height: INTEGER) is
			-- Save width and height of window.
		deferred
		ensure
			width_set: width = a_width
			height_set: height = a_height
		end

	save_position (a_x, a_y: INTEGER) is
			-- Save position of window.
		deferred
		ensure
			x_position_set: x_position = a_x
			y_position_set: y_position = a_y
		end

	save_maximized_size (a_width, a_height: INTEGER) is
			-- Save width and height of window when maximized.
		deferred
		ensure
			maximized_width_set: maximized_width = a_width
			maximized_height_set: maximized_height = a_height
		end

	save_maximized_position (a_x, a_y: INTEGER) is
			-- Save position of window when maximized.
		deferred
		ensure
			maximized_x_position_set: maximized_x_position = a_x
			maximized_y_position_set: maximized_y_position = a_y
		end

	save_window_state (a_minimized, a_maximized: BOOLEAN) is
			-- Save the window state of the window.
		require
			states_valid: (a_minimized or a_maximized) implies a_maximized /= a_minimized
		deferred
		ensure
			states_set: is_maximized = a_maximized and is_minimized = a_minimized
		end

	save_force_debug_mode (a_bool: BOOLEAN) is
			-- Save if `is_force_debug_mode'
		deferred
		ensure
			mode_set: is_force_debug_mode = a_bool
		end

feature -- Basic operations

	retrieve_general_toolbar (command_pool: LIST [EB_TOOLBARABLE_COMMAND]): ARRAYED_SET [SD_TOOL_BAR_ITEM] is
			-- Retreive the general toolbar using the available commands in `command_pool'
		deferred
		end

	retrieve_refactoring_toolbar (command_pool: LIST [EB_TOOLBARABLE_COMMAND]): ARRAYED_SET [SD_TOOL_BAR_ITEM] is
			-- Retreive the refactoring toolbar using the available commands in `command_pool'
		deferred
		end

feature -- Data Ids for SESSION_MANAGER

	development_window_data_id: STRING_8 is "com.eiffel.develop_window_data"
			-- Session data id for {EB_DEVELOPMENT_WINDOW_SESSION_DATA}.

	development_window_project_data_id: STRING_8 is "com.eiffel.develop_window_project_data"
			-- Session data id for {EB_DEVELOPMENT_WINDOW_SESSION_DATA} for one project.		

	development_window_count_id: STRING_8 is "com_eiffel.develop_window_count"
			-- Session data id for how many {EB_DEVELOPMENT_WINDOW} exists in the session.

;indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EB_DEVELOPMENT_WINDOW_DATA
