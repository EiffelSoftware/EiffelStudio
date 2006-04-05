indexing
	description	: "All shared attributes specific to the development window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_DEVELOPMENT_WINDOW_DATA


feature {EB_DEVELOPMENT_WINDOW_DATA, EB_SHARED_PREFERENCES} -- Value

	width: INTEGER is
			-- Width for the development window
		deferred
		end

	height: INTEGER is
			-- Height for the development window
		deferred
		end

	x_position: INTEGER is
			-- X position for development windows
		deferred
		end

	y_position: INTEGER is
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

	left_panel_use_explorer_style: BOOLEAN is
			-- Should there be only one tool in the left panel?
		deferred
		end

	left_panel_width: INTEGER is
			-- Width for the left panel.
		deferred
		end

	left_panel_layout: ARRAY [STRING] is
			-- Layout of the left panel of the window.
		deferred
		end

	right_panel_layout: ARRAY [STRING] is
			-- Layout of the left panel of the window.
		deferred
		end

	show_general_toolbar: BOOLEAN is
			-- Show the general toolbar (New, Save, Cut, ...)?
		deferred
		end

	show_text_in_general_toolbar: BOOLEAN is
			-- Show only selected text in the general toolbar?
		deferred
		end

	show_all_text_in_general_toolbar: BOOLEAN is
			-- Show all text in the general toolbar?
		deferred
		end

	show_text_in_refactoring_toolbar: BOOLEAN is
			-- Show only selected text in refactoring toolbar?
		deferred
		end

	show_all_text_in_refactoring_toolbar: BOOLEAN is
			-- Show all text in the refactoring toolbar?
		deferred
		end

	show_address_toolbar: BOOLEAN is
			-- Show the address toolbar (Back, Forward, Class, Feature, ...)?
		deferred
		end

	show_project_toolbar: BOOLEAN is
			-- Show the project toolbar (Breakpoints, ...)?
		deferred
		end

	show_refactoring_toolbar: BOOLEAN is
			-- Show the refactoring toolbar.
		deferred
		end

	show_search_options: BOOLEAN is
			-- Are search tool options displayed ?
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
			-- Save the width and the height of the window.
			-- Call `commit_save' to have the changes actually saved.
		deferred
		ensure
			width_set: a_width = width
			height_set: a_height = height
		end

	save_window_state (a_minimized, a_maximized: BOOLEAN) is
			-- Save the window state of the window.
		require
			states_valid: (a_minimized or a_maximized) implies a_maximized /= a_minimized
		deferred
		ensure
			states_set: is_maximized = a_maximized and is_minimized = a_minimized
		end

	save_position (a_x, a_y: INTEGER) is
			-- Save the position of the window.
			-- Call `commit_save' to have the changes actually saved.
		deferred
		ensure
			x_set: a_x = x_position
			y_set: a_y = y_position
		end

	save_left_panel_width (a_width: INTEGER) is
			-- Save the width of the left panel of the window.
			-- Call `commit_save' to have the changes actually saved.
		deferred
		ensure
			width_set: a_width = left_panel_width
		end

	save_left_panel_layout (a_layout: ARRAY [STRING]) is
			-- Save the layout of the left panel of the window.
			-- Call `commit_save' to have the changes actually saved.
		deferred
		end

	save_right_panel_layout (a_layout: ARRAY [STRING]) is
			-- Save the layout of the left panel of the window.
			-- Call `commit_save' to have the changes actually saved.
		deferred
		end

	save_show_search_options (a_show: BOOLEAN) is
			--
		deferred
		end

feature -- Basic operations

	retrieve_general_toolbar (command_pool: LIST [EB_TOOLBARABLE_COMMAND]): EB_TOOLBAR is
			-- Retreive the general toolbar using the available commands in `command_pool'
		deferred
		end

	retrieve_refactoring_toolbar (command_pool: LIST [EB_TOOLBARABLE_COMMAND]): EB_TOOLBAR is
			-- Retreive the refactoring toolbar using the available commands in `command_pool'
		deferred
		end

indexing
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
