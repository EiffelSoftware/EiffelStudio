indexing
	description	: "All shared attributes specific to a development window during a session"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_DEVELOPMENT_WINDOW_SESSION_DATA

inherit
	EB_DEVELOPMENT_WINDOW_DATA

	ES_TOOLBAR_PREFERENCE

create
	make_from_window_data

feature {NONE} -- Creation

	make_from_window_data (a_window_data: EB_DEVELOPMENT_WINDOW_DATA) is
			-- Make `Current' using window data `a_window_data'.
		require
			a_window_data_not_void: a_window_data /= Void
		do
			save_size (a_window_data.width, a_window_data.height)
			save_window_state (a_window_data.is_minimized, a_window_data.is_maximized)
			save_position (a_window_data.x_position, a_window_data.y_position)
			save_left_panel_layout (a_window_data.left_panel_layout)
			save_left_panel_width (a_window_data.left_panel_width)
			save_right_panel_layout (a_window_data.right_panel_layout)
			save_show_search_options (a_window_data.show_search_options)
			general_toolbar_layout := a_window_data.general_toolbar_layout.twin
			refactoring_toolbar_layout := a_window_data.refactoring_toolbar_layout.twin
			show_general_toolbar := a_window_data.show_general_toolbar
			show_refactoring_toolbar := a_window_data.show_refactoring_toolbar
			show_project_toolbar := a_window_data.show_project_toolbar
			show_all_text_in_general_toolbar := a_window_data.show_all_text_in_general_toolbar
			show_text_in_general_toolbar := a_window_data.show_text_in_general_toolbar
			show_address_toolbar := a_window_data.show_address_toolbar
		end

feature {EB_DEVELOPMENT_WINDOW} -- Access

	file_name: FILE_NAME
			-- Filename that the development window is currently targeted to.

	context_cluster_string: STRING
			-- String representing any targeted cluster in the context pane.

	context_class_string: STRING
			-- String representing any targeted class in the context pane.

	context_feature_string: STRING
			-- String representing any targeted feature in the context pane.

	context_tab_index: INTEGER
			-- Index of the selected tab in the context pane.

	editor_position: INTEGER
			-- Position that editor was set to if any.

	width: INTEGER
			-- Width for the development window.

	height: INTEGER
			-- Height for the development window.

	x_position: INTEGER
			-- X position for development window.

	y_position: INTEGER
			-- Y position for development window.

	is_maximized: BOOLEAN
			-- Is the development window maximized?

	is_minimized: BOOLEAN
			-- Is the development window minimized?

	left_panel_use_explorer_style: BOOLEAN
			-- Should there be only one tool in the left panel?

	left_panel_width: INTEGER
			-- Width for the left panel.

	left_panel_layout: ARRAY [STRING]
			-- Layout of the left panel of the window.

	right_panel_layout: ARRAY [STRING]
			-- Layout of the left panel of the window.

	show_general_toolbar: BOOLEAN
			-- Show the general toolbar (New, Save, Cut, ...)?

	show_text_in_general_toolbar: BOOLEAN
			-- Show only selected text in the general toolbar?

	show_all_text_in_general_toolbar: BOOLEAN
			-- Show all text in the general toolbar?

	show_text_in_refactoring_toolbar: BOOLEAN
			-- Show only selected text in the refactoring toolbar?

	show_all_text_in_refactoring_toolbar: BOOLEAN
			-- Show all text in the refactoring toolbar?

	show_address_toolbar: BOOLEAN
			-- Show the address toolbar (Back, Forward, Class, Feature, ...)?

	show_project_toolbar: BOOLEAN
			-- Show the project toolbar (Breakpoints, ...)?

	show_refactoring_toolbar: BOOLEAN
			-- Show the refactoring toolbar.

	show_search_options: BOOLEAN
			-- Are search tool options displayed ?

	context_unified_stone: BOOLEAN
			-- Is the context tool linked?

	general_toolbar_layout: ARRAY [STRING]
			-- Toolbar organization

	refactoring_toolbar_layout: ARRAY [STRING]
			-- Toolbar organization

feature {EB_DEVELOPMENT_WINDOW} -- Element change

	save_filename (a_filename: like file_name) is
			-- Save the filename that the window is currently targeted to.
		require
			a_filename_not_void: a_filename /= Void
		do
			file_name := a_filename.twin
		ensure
			file_name_cloned: file_name /= a_filename and then file_name.is_equal (a_filename)
		end

	save_context_data (a_cluster_string, a_class_string, a_feature_string: STRING; a_tab_index: INTEGER) is
			-- Save the context information of the window.
		do
			context_cluster_string := a_cluster_string
			context_class_string := a_class_string
			context_feature_string := a_feature_string
			context_tab_index := a_tab_index
		end

	save_editor_position (a_position: INTEGER) is
			-- Save the position that editor cursor is currently on.
		require
			a_position_valid: a_position > 0
		do
			editor_position := a_position
		ensure
			editor_position_set: editor_position = a_position
		end

	save_size (a_width, a_height: INTEGER) is
			-- Save the width and the height of the window.
		do
			width := a_width
			height := a_height
		end

	save_window_state (a_minimized, a_maximized: BOOLEAN) is
			-- Save the window state of the window.
		do
			is_maximized := a_maximized
			is_minimized := a_minimized
		end

	save_position (a_x, a_y: INTEGER) is
			-- Save the position of the window.
		do
			x_position := a_x
			y_position := a_y
		end

	save_left_panel_width (a_width: INTEGER) is
			-- Save the width of the left panel of the window.
		do
			left_panel_width := a_width
		end

	save_left_panel_layout (a_layout: ARRAY [STRING]) is
			-- Save the layout of the left panel of the window.
		do
			left_panel_layout := a_layout.twin
		end

	save_right_panel_layout (a_layout: ARRAY [STRING]) is
			-- Save the layout of the left panel of the window.
		do
			right_panel_layout := a_layout.twin
		end

	save_show_search_options (a_show: BOOLEAN) is
			--
		do
			show_search_options := a_show
		end

feature -- Basic operations

	retrieve_general_toolbar (command_pool: LIST [EB_TOOLBARABLE_COMMAND]): EB_TOOLBAR is
			-- Retreive the general toolbar using the available commands in `command_pool'
		do
			Result := retrieve_toolbar (command_pool, general_toolbar_layout)
		end

	retrieve_refactoring_toolbar (command_pool: LIST [EB_TOOLBARABLE_COMMAND]): EB_TOOLBAR is
			-- Retreive the refactoring toolbar using the available commands in `command_pool'
		do
			Result := retrieve_toolbar (command_pool, refactoring_toolbar_layout)
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

end -- class EB_DEVELOPMENT_WINDOW_DATA
