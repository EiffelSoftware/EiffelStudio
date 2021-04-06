note
	description: "[
		Cell consisting of a text label with optional pixmap.
		The rules governing the position of `text' and `pixmap' in relation to `Current' are as follows:

		Both `text' and `pixmap' are always drawn completely within the area goverened by `left_border', `right_border',
		`top_border' and `bottom_border', which will be referred to as the `redraw_client_area' in this description.
		Note that `text' may be automatically ellipsized (clipped with three dots) to ensure this.

		`pixmap' is always displayed to the very left edge of `redraw_client_area' and centered vertically. The only method
		of overriding this behavior is to set a custom `layout_procedure'.

		`text' may be aligned within `redraw_client_area' via the following features: 'align_text_left', `align_text_center',
		`align_text_right', `align_text_top', `align_text_vertically_center' and `align_text_bottom'. Note that the text
		alignment has no effect on the position of the pixmap which follows the rules listed above.

		A `layout_procedure' may be set which permits you to override the position of `text' and `pixmap' by computing the redraw
		positions manually. The drawing is clipped to `redraw_client_area' although there is no restriction on the positions that
		may be set for `text' and `pixmap'.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_LABEL_ITEM

inherit
	EV_GRID_ITEM
		redefine
			is_in_default_state,
			implementation,
			create_implementation,
			create_interface_objects,
			initialize
		end

create
	default_create,
	make_with_text

feature {NONE} -- Initialization

	make_with_text (a_text: READABLE_STRING_GENERAL)
			-- Create `Current' and assign `a_text' to `text'
		require
			a_text_not_void: a_text /= Void
		do
			default_create
			set_text (a_text)
		ensure
			text_set: text.same_string_general (a_text)
		end

	initialize
			-- Mark `Current' as initialized.
		do
			set_text ({STRING_32} "")
			internal_left_border := -1
			set_spacing (2)
			align_text_left
			align_text_vertically_center
			enable_full_select
			Precursor {EV_GRID_ITEM}
		end

feature -- Status Setting

	set_text (a_text: READABLE_STRING_GENERAL)
			-- Assign `a_text' to `text'.
		require
			not_destroyed: not is_destroyed
			a_text_not_void: a_text /= Void
			no_carriage_returns: not a_text.has_code (('%R').natural_32_code)
		local
			l_parent: like parent
		do
			text := a_text.as_string_32
			implementation.string_size_changed
			l_parent := parent
			if l_parent /= Void and then not l_parent.is_destroyed then
				l_parent.implementation.redraw_item (implementation)
			end
		ensure
			text_set: text.same_string_general (a_text)
		end

	remove_text
			-- Make `text' `is_empty'.
		require
			not_destroyed: not is_destroyed
		do
			set_text ("")
		ensure
			text_empty: text.is_empty
		end

	set_font (a_font: EV_FONT)
			-- Assign `a_font' to `font'.
		require
			not_destroyed: not is_destroyed
			a_font_not_void: a_font /= Void
		do
			font := a_font
			implementation.string_size_changed
			if attached parent as l_parent then
				l_parent.implementation.redraw_item (implementation)
			end
		ensure
			font_assigned: font = a_font
		end

	set_pixmap (a_pixmap: EV_PIXMAP)
			-- Display image of `a_pixmap' on `Current'.
		require
			not_destroyed: not is_destroyed
			pixmap_not_void: a_pixmap /= Void
		do
			pixmap := a_pixmap
			if attached parent as l_parent then
				l_parent.implementation.redraw_item (implementation)
			end
		ensure
			pixmap_set: pixmap = a_pixmap
		end

	remove_pixmap
			-- Remove image displayed on `Current'.
		require
			not_destroyed: not is_destroyed
		do
			pixmap := Void
			if attached parent as l_parent then
				l_parent.implementation.redraw_item (implementation)
			end
		ensure
			pixmap_removed: pixmap = Void
		end

	set_left_border (a_left_border: INTEGER)
			-- Assign `a_left_border' to `left_border'.
		require
			not_destroyed: not is_destroyed
			a_left_border_non_negative: a_left_border >= 0
		do
			internal_left_border := a_left_border
			if attached parent as l_parent then
				l_parent.implementation.redraw_item (implementation)
			end
		ensure
			left_border_set: left_border = a_left_border
		end

	set_right_border (a_right_border: INTEGER)
			-- Assign `a_right_border' to `right_border'.
		require
			not_destroyed: not is_destroyed
			a_right_border_non_negative: a_right_border >= 0
		do
			right_border := a_right_border
			if attached parent as l_parent then
				l_parent.implementation.redraw_item (implementation)
			end
		ensure
			right_border_set: right_border = a_right_border
		end

	set_top_border (a_top_border: INTEGER)
			-- Assign `a_top_border' to `top_border'.
		require
			not_destroyed: not is_destroyed
			a_top_border_non_negative: a_top_border >= 0
		do
			top_border := a_top_border
			if attached parent as l_parent then
				l_parent.implementation.redraw_item (implementation)
			end
		ensure
			top_border_set: top_border = a_top_border
		end

	set_bottom_border (a_bottom_border: INTEGER)
			-- Assign `a_bottom_border' to `bottom_border'.
		require
			not_destroyed: not is_destroyed
			a_bottom_border_non_negative: a_bottom_border >= 0
		do
			bottom_border := a_bottom_border
			if attached parent as l_parent then
				l_parent.implementation.redraw_item (implementation)
			end
		ensure
			bottom_border_set: bottom_border = a_bottom_border
		end

	set_spacing (a_spacing: INTEGER)
			-- Assign `a_spacing' to `spacing'.
		require
			not_destroyed: not is_destroyed
			a_spacing_non_negative: a_spacing >= 0
		do
			spacing := a_spacing
			if attached parent as l_parent then
				l_parent.implementation.redraw_item (implementation)
			end
		ensure
			spacing_set: spacing = a_spacing
		end

	align_text_center
			-- Display `text' centered.
		require
			not_destroyed: not is_destroyed
		do
			boolean_flags := boolean_flags.set_bit (False, 1)
			boolean_flags := boolean_flags.set_bit (True, 2)
			boolean_flags := boolean_flags.set_bit (False, 3)
			if attached parent as l_parent then
				l_parent.implementation.redraw_item (implementation)
			end
		ensure
			alignment_set: is_center_aligned
		end

	align_text_right
			-- Display `text' right aligned.
		require
			not_destroyed: not is_destroyed
		do
			boolean_flags := boolean_flags.set_bit (False, 1)
			boolean_flags := boolean_flags.set_bit (False, 2)
			boolean_flags := boolean_flags.set_bit (True, 3)
			if attached parent as l_parent then
				l_parent.implementation.redraw_item (implementation)
			end
		ensure
			alignment_set: is_right_aligned
		end

	align_text_left
			-- Display `text' left aligned.
		require
			not_destroyed: not is_destroyed
		do
			boolean_flags := boolean_flags.set_bit (True, 1)
			boolean_flags := boolean_flags.set_bit (False, 2)
			boolean_flags := boolean_flags.set_bit (False, 3)
			if attached parent as l_parent then
				l_parent.implementation.redraw_item (implementation)
			end
		ensure
			alignment_set: is_left_aligned
		end

	align_text_vertically_center
			-- Display `text' centered vertically.
		require
			not_destroyed: not is_destroyed
		do
			boolean_flags := boolean_flags.set_bit (False, 4)
			boolean_flags := boolean_flags.set_bit (True, 5)
			boolean_flags := boolean_flags.set_bit (False, 6)
			if attached parent as l_parent then
				l_parent.implementation.redraw_item (implementation)
			end
		ensure
			alignment_set: is_vertically_center_aligned
		end

	align_text_top
			-- Display `text' top aligned.
		require
			not_destroyed: not is_destroyed
		do
			boolean_flags := boolean_flags.set_bit (True, 4)
			boolean_flags := boolean_flags.set_bit (False, 5)
			boolean_flags := boolean_flags.set_bit (False, 6)
			if attached parent as l_parent then
				l_parent.implementation.redraw_item (implementation)
			end
		ensure
			alignment_set: is_top_aligned
		end

	align_text_bottom
			-- Display `text' bottom aligned.
		require
			not_destroyed: not is_destroyed
		do
			boolean_flags := boolean_flags.set_bit (False, 4)
			boolean_flags := boolean_flags.set_bit (False, 5)
			boolean_flags := boolean_flags.set_bit (True, 6)
			if attached parent as l_parent then
				l_parent.implementation.redraw_item (implementation)
			end
		ensure
			alignment_set: is_bottom_aligned
		end

	set_layout_procedure (a_layout_procedure: PROCEDURE [EV_GRID_LABEL_ITEM, EV_GRID_LABEL_ITEM_LAYOUT])
			-- Assign `a_layout_procedure' to `layout_procedure'.
		do
			layout_procedure := a_layout_procedure
		ensure
			layout_procedure_set: layout_procedure = a_layout_procedure
		end

	enable_full_select
			-- Ensure `is_full_select_enabled' is `True'.
		require
			not_destroyed: not is_destroyed
		do
			boolean_flags := boolean_flags.set_bit (True, 7)
			if attached parent as l_parent then
				l_parent.implementation.redraw_item (implementation)
			end
		ensure
			full_select_enabled: is_full_select_enabled
		end

	disable_full_select
			-- Ensure `is_full_select_enabled' is `False'.
		require
			not_destroyed: not is_destroyed
		do
			boolean_flags := boolean_flags.set_bit (False, 7)
			if attached parent as l_parent then
				l_parent.implementation.redraw_item (implementation)
			end
		ensure
			full_select_disabled: not is_full_select_enabled
		end

feature -- Measurement

	left_border: INTEGER
			-- Spacing between the contents of `Current' and the left edge of `Current' in pixels.
		do
			Result := internal_left_border
			if Result = -1 then
				Result := default_left_border
			end
		end

	right_border: INTEGER
			-- Spacing between the contents of `Current' and the right edge of `Current' in pixels.

	top_border: INTEGER
			-- Spacing between the contents of `Current' and the top edge of `Current' in pixels.

	bottom_border: INTEGER
			-- Spacing between the contents of `Current' and the bottom edge of `Current' in pixels.

	spacing: INTEGER
			-- Spacing between `text' and `pixmap' in pixels.
			-- If both are not visible, this value does not affect appearance of `Current'.

	text_width: INTEGER
			-- `Result' is width required to fully display `text' in `pixels'.
			-- This function is optimized internally by `Current' and is therefore
			-- faster than querying `font.string_size' directly.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.text_width
		ensure
			result_non_negative: Result >= 0
		end

	text_height: INTEGER
			-- `Result' is height required to fully display `text' in `pixels'.
			-- This function is optimized internally by `Current' and is therefore
			-- faster than querying `font.string_size' directly.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.text_height
		ensure
			result_non_negative: Result >= 0
		end

feature -- Status report

	text: STRING_32
		-- Text displayed in `Current'.

	font: detachable EV_FONT
		-- Typeface appearance for `Current'.

	pixmap: detachable EV_PIXMAP
		-- Image displayed to left of `text'.

	is_left_aligned: BOOLEAN
			-- Is `text' of `Current' left aligned?
			-- Ignored during re-draw if `layout_procedure' /= Void.
		require
			not_destroyed: not is_destroyed
		do
			Result := boolean_flags.bit_test (1)
		end

	is_center_aligned: BOOLEAN
			-- Is `text' of `Current' center aligned?
			-- Ignored during re-draw if `layout_procedure' /= Void.
		require
			not_destroyed: not is_destroyed
		do
			Result := boolean_flags.bit_test (2)
		end

	is_right_aligned: BOOLEAN
			-- Is `text' of `Current' right aligned?
			-- Ignored during re-draw if `layout_procedure' /= Void.
		require
			not_destroyed: not is_destroyed
		do
			Result := boolean_flags.bit_test (3)
		end

	is_top_aligned: BOOLEAN
			-- Is `text' of `Current' top aligned?
			-- Ignored during re-draw if `layout_procedure' /= Void.
		require
			not_destroyed: not is_destroyed
		do
			Result := boolean_flags.bit_test (4)
		end

	is_vertically_center_aligned: BOOLEAN
			-- Is `text' of `Current' vertically center aligned?
			-- Ignored during re-draw if `layout_procedure' /= Void.
		require
			not_destroyed: not is_destroyed
		do
			Result := boolean_flags.bit_test (5)
		end

	is_bottom_aligned: BOOLEAN
			-- Is `text' of `Current' bottom aligned?
			-- Ignored during re-draw if `layout_procedure' /= Void.
		require
			not_destroyed: not is_destroyed
		do
			Result := boolean_flags.bit_test (6)
		end

	layout_procedure: detachable PROCEDURE [EV_GRID_LABEL_ITEM, EV_GRID_LABEL_ITEM_LAYOUT]
			-- Procedure which may be used to calculate the position of `text' and `pixmap' relative to `Current',
			-- ready for the drawing implementation.
			-- This procedure is fired each time that `Current' must be re-drawn and by filling the passed EV_GRID_LABEL_ITEM_LAYOUT object, the
			-- position relative to the top left of `Current' at which `text' and `pixmap' is to be drawn may be set explicitly.
			-- The properties set into EV_GRID_LABEL_ITEM override any other positional settings such as the text alignment within `Current'.
			-- Be sure to query the width and height of `text' from the label item directly via `text_width' and `text_height' as
			-- this is optimized and quicker than `font.string_size' for repeated calls.

			-- Arguments (from left to right):
			-- label_item: EV_GRID_LABEL_ITEM - `Current' to which the settings apply.
			-- label_item_layout: EV_GRID_LABEL_ITEM_LAYOUT - Object into which desired positioning information must be set.

	is_full_select_enabled: BOOLEAN
			-- Does selection highlighting fill complete area of `Current'?
			-- If `False', highlighting is only applied to area of `text'.
		require
			not_destroyed: not is_destroyed
		do
			Result := boolean_flags.bit_test (7)
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_GRID_ITEM} and text.is_empty and pixmap = Void and
				left_border = 2 and right_border = 0 and top_border = 0 and bottom_border = 0
				and spacing = 2 and is_left_aligned and is_vertically_center_aligned and is_full_select_enabled
		end

feature {EV_ANY, EV_ANY_I, EV_GRID_DRAWER_I} -- Implementation

	implementation: EV_GRID_LABEL_ITEM_I
			-- Responsible for interaction with native graphics toolkit.

	boolean_flags: INTEGER_8
			-- Current boolean flags for internal use only.
			-- Bit 1 set to 1 if left aligned
			-- Bit 2 set to 1 if center aligned
			-- Bit 3 set to 1 if right aligned
			-- Bit 4 set to 1 if top aligned
			-- Bit 5 set to 1 if vertically center aligned
			-- Bit 6 set to 1 if bottom aligned
			-- Bit 7 set to 1 if `is_full_select_enabled'.

feature {NONE} -- Implementation

	create_implementation
			-- <Precursor>
		do
			create {EV_GRID_LABEL_ITEM_I} implementation.make
		end

	create_interface_objects
			-- <Precursor>
		do
			create text.make_empty
		end

	internal_left_border: INTEGER
			-- Storage for `left_border'.

	grid_label_item_layout: EV_GRID_LABEL_ITEM_LAYOUT
			-- Once access to a layout structure used by `layout_procedure'.
		once
			create Result
		end

feature {EV_GRID_LABEL_ITEM_I} -- Implementation

	computed_initial_grid_label_item_layout (a_width, a_height: INTEGER): like grid_label_item_layout
			-- Calculate the positions of the text and pixmap for drawing the content of the item.
		local
			l_pixmap: detachable EV_PIXMAP
			pixmap_width, pixmap_height: INTEGER
			spacing_used: INTEGER
			space_remaining_for_text: INTEGER
			text_offset_into_available_space, vertical_text_offset_into_available_space: INTEGER
			client_width, client_height: INTEGER
			text_x, text_y: INTEGER
			pixmap_x, pixmap_y: INTEGER
		do
				-- Retrieve properties from interface.
			l_pixmap := pixmap

				-- Now calculate the area to be used for displaying the text and pixmap
				-- by subtracting the borders from the complete area.
			client_width := a_width - left_border - right_border
			client_height := a_height - top_border - bottom_border

			if l_pixmap /= Void then
				pixmap_width := l_pixmap.width
				pixmap_height := l_pixmap.height
				spacing_used := spacing
			end

			space_remaining_for_text := client_width - pixmap_width - spacing_used

			if space_remaining_for_text > 0 then
				if is_left_aligned then
				elseif is_right_aligned then
					text_offset_into_available_space := space_remaining_for_text - text_width
				else
					text_offset_into_available_space := (space_remaining_for_text - text_width) // 2
				end
			end
				-- Ensure that the text always respect the edge of the pixmap + the spacing in all
				-- alignment modes when the width of the column is not enough to display all of the
				-- contents
			text_offset_into_available_space := text_offset_into_available_space.max (1)

			if is_top_aligned then
			elseif is_bottom_aligned then
				vertical_text_offset_into_available_space := client_height - text_height
			else
				vertical_text_offset_into_available_space := (client_height - text_height) // 2
			end
				-- Ensure that the text always respects the top edge of the row in all alignment modes
				-- when the height of the row is not enough to display the text fully.
			vertical_text_offset_into_available_space := vertical_text_offset_into_available_space.max (0)

			pixmap_x := left_border
			text_x := pixmap_x + pixmap_width + spacing_used + text_offset_into_available_space
			text_y := top_border + vertical_text_offset_into_available_space
				-- Pixmap is always aligned to the center of the text
			pixmap_y := text_y + text_height // 2 - pixmap_height // 2
				-- If bottom of pixmap is truncated, we move the pixmap to the top
			if pixmap_y + pixmap_height > a_height - bottom_border then
				pixmap_y := a_height - bottom_border - pixmap_height
			end
				-- If top of image is truncated, we move pixmap to the bottom and
				-- in the event the bottom gets also truncated, then that's too bad
				-- but this is the chosen behavior.
			pixmap_y := pixmap_y.max (top_border)

			Result := grid_label_item_layout
			Result.set_pixmap_x (pixmap_x)
			Result.set_pixmap_y (pixmap_y)
			Result.set_text_x (text_x)
			Result.set_text_y (text_y)
			Result.set_available_text_width (space_remaining_for_text.max (0))
			Result.set_has_text_pixmap_overlapping (True)
		end

feature {EV_GRID_LABEL_ITEM_I}

	default_left_border: INTEGER = 2
			-- Default left border used for drawing the text.

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
