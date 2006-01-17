indexing
	description: "Window which displays a state which is neither final nor initial."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_WIZARD_INTERMEDIARY_STATE_WINDOW

inherit
	EB_WIZARD_STATE_WINDOW

feature {NONE} -- Basic Operations

	display is
			-- Display Current state.
		do 
			build_frame
			first_window.set_intermediary_state
			build
		end

	build_frame is
			-- Build widgets
		require
			main_box_empty: main_box.count = 0
		local
			title_white_box: EV_HORIZONTAL_BOX	-- Box where is displayed the state title and an icon (white bkgroud).
			actions_box: EV_HORIZONTAL_BOX		-- Box where are displayed the choices for the user.
			interior_box: EV_VERTICAL_BOX		-- Message Box + Actions Box.
			horizontal_separator: EV_HORIZONTAL_SEPARATOR
			empty_space: EV_CELL
			cell: EV_CELL
			icon_pixmap: EV_PIXMAP
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
		do
				-----------------------------------------------------------
				-- Create the box that will receive the title and the icon.
				-----------------------------------------------------------
			create title_white_box
			title_white_box.set_border_width (dialog_unit_to_pixels(5))
			title_white_box.set_background_color (white_color)
			title_white_box.set_minimum_height (dialog_unit_to_pixels(58))

				-- Empty space on the left of the title
			create cell
			cell.set_background_color (white_color)
			cell.set_minimum_width (Title_border_width)
			title_white_box.extend (cell)
			title_white_box.disable_item_expand (cell)

				-- Title
			create title
			title.set_background_color (white_color)
			title.align_text_left
			title.set_font (interior_title_font)
			create hb
			create cell
			cell.set_minimum_width(Subtitle_border_width)
			cell.set_background_color (white_color)
			hb.extend (cell)
			hb.disable_item_expand (cell)
			create subtitle
			subtitle.align_text_left
			subtitle.set_background_color (white_color)
			subtitle.set_font (interior_font)
			hb.extend (subtitle)

			create vb
			vb.set_background_color (white_color)
			vb.set_padding (dialog_unit_to_pixels(3))
			vb.extend (title)
			vb.disable_item_expand (title)
			vb.extend (hb)
			vb.disable_item_expand (hb)
			create cell
			cell.set_background_color (white_color)
			vb.extend (cell)
			title_white_box.extend (vb)

				-- Space between the title and the pixmap.
			create cell
			cell.set_minimum_width (Title_right_border_width)
			cell.set_background_color (white_color)
			title_white_box.extend (cell)

				-- Icon Pixmap
			icon_pixmap := pixmap_icon.twin
			icon_pixmap.set_minimum_width (dialog_unit_to_pixels(48))
			icon_pixmap.set_minimum_height (dialog_unit_to_pixels(48))
			title_white_box.extend (icon_pixmap)
			title_white_box.disable_item_expand (icon_pixmap)

				-----------------------------------------------------------
				-- Separator
				-----------------------------------------------------------
			create horizontal_separator

				-----------------------------------------------------------
				-- Interior box
				-----------------------------------------------------------

				-- Message box --------------------------------------------
			create message_box
			create cell
			cell.set_minimum_width (Interior_border_width)
			message_box.extend (cell)
			message_box.disable_item_expand (cell)
			create message
			message.align_text_left
			message_box.extend (message)
			create cell			
			cell.set_minimum_width (Interior_border_width)
			message_box.extend (cell)
			message_box.disable_item_expand (cell)

				-- Empty space between message box and actions box --------
			create empty_space
			empty_space.set_minimum_height (dialog_unit_to_pixels(2))

				-- Actions box --------------------------------------------
			create actions_box
			create cell
			cell.set_minimum_width (Interior_border_width)
			actions_box.extend (cell)
			actions_box.disable_item_expand (cell)
			create choice_box
			actions_box.extend (choice_box)
			create cell
			cell.set_minimum_width (Interior_border_width)
			actions_box.extend (cell)
			actions_box.disable_item_expand (cell)
			display_state_text

			create interior_box
			interior_box.set_border_width (Default_border_size)
			interior_box.set_padding (Default_padding_size)
			interior_box.extend (message_box)
			interior_box.disable_item_expand (message_box)
			interior_box.extend (actions_box)
			interior_box.disable_item_expand (actions_box)
			interior_box.extend (create {EV_CELL}) -- Expandable item.
	
			--------------------------------------------
			-- Create the main box from the other box.
			--------------------------------------------
			main_box.extend (title_white_box)
			main_box.disable_item_expand (title_white_box)
			main_box.extend (horizontal_separator)
			main_box.disable_item_expand (horizontal_separator)
			main_box.extend (interior_box) -- Expandable item.
		ensure
			main_box_has_at_least_one_element: main_box.count > 0
		end

feature {EB_WIZARD_INTERMEDIARY_STATE_WINDOW} -- Implementation

	choice_box: EV_VERTICAL_BOX

	message_box: EV_HORIZONTAL_BOX;		-- Box where is displayed the description of current state (gray bkground).
	
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

end -- class INTERMEDIARY_STATE_WINDOW
