indexing
	description: "Objects that demonstrate `string_size' of EV_FONT on an EV_PIXMAP."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	Usage: "[
		Select desired font, and enter text for testing. Selecting
		the `Show Bounds' button causes bounding rectangles and corresponding
		information to be displayed, retrieved from calls to `string_size'.
		The sample text may be moved by dragging it.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	PIXMAP_FIGURE_STRING_SIZE_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			vertical_box: EV_VERTICAL_BOX
			horizontal_box: EV_HORIZONTAL_BOX
		do
			create vertical_box
			vertical_box.set_minimum_size (300, 300)
			widget := vertical_box
			create pixmap
			pixmap.set_size (300, 300)
			vertical_box.extend (pixmap)
			create world
			create projector.make (world, pixmap)
			create horizontal_box
			vertical_box.extend (horizontal_box)
			vertical_box.disable_item_expand (horizontal_box)
			create text_input
			text_input.set_text ("Default text")
			text_input.change_actions.extend (agent text_changed)
			horizontal_box.extend (text_input)
			create vertical_box
			horizontal_box.extend (vertical_box)
			horizontal_box.disable_item_expand (vertical_box)
			create font_button.make_with_text ("Select Font")
			font_button.select_actions.extend (agent select_font)
			vertical_box.extend (font_button)
			create bounds_button.make_with_text ("Show Bounds")
			bounds_button.select_actions.extend (agent update_bounds_display)
			vertical_box.extend (bounds_button)
			
			create figure_text.make_with_text (text_input.text)
			create move_handle
			figure_text.set_point (create {EV_RELATIVE_POINT}.make_with_position (100, 100))
			world.extend (move_handle)
			move_handle.extend (figure_text)
			
			create font.make_with_values ({EV_FONT_CONSTANTS}.family_roman, {EV_FONT_CONSTANTS}.weight_regular, {EV_FONT_CONSTANTS}.shape_regular, 24)
			figure_text.set_font (font)
			
			create string_right_offset
			create string_left_offset
			create string_width
			create string_height			

			projector.project			
		end
		
feature {NONE} -- Implementation

	select_font is
			-- Display a font dialog for font selection, and update the displayed font
			-- to that selected.
		local
			font_dialog: EV_FONT_DIALOG
		do
			create font_dialog
			font_dialog.show_modal_to_window (parent_window (pixmap))
			if font_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_ok) then
				font := font_dialog.font
				figure_text.set_font (font_dialog.font)
				clear_bounds_figures
				update_bounds_display
				projector.project
			end
		end
		
	update_bounds_display is
			-- Update displayed bounds.
		local
			string_info: TUPLE [INTEGER, INTEGER, INTEGER, INTEGER]
			width, height, left_offset, right_offset: INTEGER
		do
			string_info := font.string_size (text_input.text)
			width := string_info.integer_item (1)
			height := string_info.integer_item (2)
			left_offset := string_info.integer_item (3)
			right_offset := string_info.integer_item (4)
			
			if bounds_button.is_selected then
				
				create bounding_rectangle.make_with_points (create {EV_RELATIVE_POINT}.make_with_position (figure_offset, figure_offset),
					create {EV_RELATIVE_POINT}.make_with_position (figure_offset + width, figure_offset + height))
				move_handle.extend (bounding_rectangle)
				create left_offset_line.make_with_points (create {EV_RELATIVE_POINT}.make_with_position (figure_offset + left_offset, figure_offset),
					create {EV_RELATIVE_POINT}.make_with_position (figure_offset + left_offset, figure_offset + height))
				left_offset_line.set_foreground_color ((create {EV_STOCK_COLORS}).red)
				move_handle.extend (left_offset_line)
				create right_offset_line.make_with_points (create {EV_RELATIVE_POINT}.make_with_position (figure_offset + width + right_offset, figure_offset),
					create {EV_RELATIVE_POINT}.make_with_position (figure_offset + width + right_offset, figure_offset + height))
				right_offset_line.set_foreground_color ((create {EV_STOCK_COLORS}).red)
				move_handle.extend (right_offset_line)
				
				string_right_offset.set_text ("Right Offset: " + right_offset.out)
				string_right_offset.set_point (create {EV_RELATIVE_POINT}.make_with_position (10, 260 - string_right_offset.height))
				string_left_offset.set_text ("Left Offset: " + left_offset.out)
				string_left_offset.set_point (create {EV_RELATIVE_POINT}.make_with_position (10, string_right_offset.point.y - string_left_offset.height))
				string_height.set_text ("Height: " + height.out)
				string_height.set_point (create {EV_RELATIVE_POINT}.make_with_position (10, string_left_offset.point.y - string_height.height))
				string_width.set_text ("Width: " + width.out)
				string_width.set_point (create {EV_RELATIVE_POINT}.make_with_position (10, string_height.point.y - string_width.height))
				world.extend (string_right_offset)
				world.extend (string_left_offset)
				world.extend (string_width)
				world.extend (string_height)

				figure_text.set_font (font)	
			else
				clear_bounds_figures				
			end
			
			projector.project
		end
		
	clear_bounds_figures is
			-- Clear all figures displaying bounds from `move_handle'.
		do
			pixmap.clear
			move_handle.prune_all (bounding_rectangle)
			move_handle.prune_all (left_offset_line)
			move_handle.prune_all (right_offset_line)
			world.prune_all (string_width)
			world.prune_all (string_height)
			world.prune_all (string_left_offset)
			world.prune_all (string_right_offset)
		ensure
			move_handle_only_contains_text: move_handle.count = 1
		end
	
	text_changed is
			-- Text to be displayed has been changed.
		do
			figure_text.set_text (text_input.text)
			clear_bounds_figures
			update_bounds_display
			projector.project
		end
		
		
	font: EV_FONT
		-- Current font used to display figure.

	pixmap: EV_PIXMAP
		-- Widget that test is to be performed on.
		
	projector: EV_PIXMAP_PROJECTOR
		-- Projector to project figure world on `pixmap'.
		
	world: EV_FIGURE_WORLD
		-- Figure world for test.
		
	figure_text: EV_FIGURE_TEXT
		-- Figure text for testing.
		
	text_input: EV_TEXT
		-- Input field for current text to be tested.
		
	font_button: EV_BUTTON
		-- Button to trigger font selection.
		
	bounds_button: EV_TOGGLE_BUTTON
		-- Button to trigger bounds display.
		
	bounding_rectangle: EV_FIGURE_RECTANGLE
		-- Rectangle to display bounds of text.
		
	move_handle: EV_MOVE_HANDLE
		-- Move handle, permitting moving of sample text
		
	left_offset_line, right_offset_line: EV_FIGURE_LINE
		-- Lines to display offset information for text bounds.
		
	string_width, string_height, string_left_offset, string_right_offset: EV_FIGURE_TEXT
		-- Figures to display textual representations of bounding offsets.
	
	figure_offset: INTEGER is 100;
		-- Offset of figure text from move handle.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class PIXMAP_FIGURE_STRING_SIZE_TEST
