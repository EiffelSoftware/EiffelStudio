indexing
	description: "[
		User interface contant values.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	ES_UI_CONSTANTS

feature -- Access

	horizontal_padding: INTEGER = 4
	vertical_padding: INTEGER = 4
	cell_vertical_separator_width: INTEGER = 6
	cell_horizontal_separator_height: INTEGER = 6

feature -- Button

	button_height: INTEGER = 23

feature -- Frames

	frame_border: INTEGER = 6

feature -- Notebook

	notebook_border: INTEGER = 4

feature -- Dialog

	dialog_border: INTEGER = 6
	dialog_button_border: INTEGER = 10
	dialog_button_vertical_padding: INTEGER = 8
	dialog_button_horizontal_padding: INTEGER = 10
	dialog_button_width: INTEGER = 75
	dialog_button_height: INTEGER = 23

	prompt_border: INTEGER = 15
	prompt_vertical_padding: INTEGER = 8
	prompt_horizontal_icon_spacing: INTEGER = 10

feature -- Pop up windows

	popup_window_border_width: INTEGER = 1

feature -- Grid

	grid_row_height: INTEGER = 14
	grid_item_spacing: INTEGER = 3
	grid_editor_item_spacing: INTEGER = 8

feature -- Timing intervals

	popup_idle_interval: INTEGER = 300
			-- Standard popup window show interval for idle action.

	popup_widget_show_interval: INTEGER = 800
			-- Popup window widget show interval for idle action.

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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

end
