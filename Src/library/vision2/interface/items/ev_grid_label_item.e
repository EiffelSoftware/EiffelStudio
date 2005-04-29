indexing
	description: "Cell consisting of a text label with optional pixmap"
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
			initialize
		end

create
	default_create,
	make_with_text

feature {NONE} -- Initialization

	make_with_text (a_text: STRING) is
			-- Create `Current' and assign `a_text' to `text'
		require
			a_text_not_void: a_text /= Void
		do
			default_create
			set_text (a_text)
		ensure
			text_assigned: text = a_text
		end

	initialize is
			-- Mark `Current' as initialized.
		do
			set_text ("")
			set_left_border (2)
			set_spacing (2)
			align_text_left
			Precursor {EV_GRID_ITEM}
		end

feature -- Status Setting
	
	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		require
			not_destroyed: not is_destroyed
			a_text_not_void: a_text /= Void
			no_carriage_returns: not a_text.has ('%R')
		do
			text := a_text
			if parent /= Void then
				parent.implementation.redraw_item (implementation)
			end
		ensure
			text_set: text = a_text
		end

	remove_text is
			-- Make `text' `is_empty'.
		require
			not_destroyed: not is_destroyed
		do
			set_text ("")
		ensure
			text_empty: text.is_empty
		end
		
	set_font (a_font: EV_FONT) is
			-- Assign `a_font' to `font'.
		require
			not_destroyed: not is_destroyed
			a_font_not_void: a_font /= Void
		do
			font := a_font
			if parent /= Void then
				parent.implementation.redraw_item (implementation)
			end
		ensure
			font_assigned: font = a_font
		end
		
	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Display image of `a_pixmap' on `Current'.
		require
			not_destroyed: not is_destroyed
			pixmap_not_void: a_pixmap /= Void
		do
			pixmap := a_pixmap
			if parent /= Void then
				parent.implementation.redraw_item (implementation)
			end
		ensure
			pixmap_set: pixmap = a_pixmap
		end

	remove_pixmap is
			-- Remove image displayed on `Current'.
		require
			not_destroyed: not is_destroyed
		do
			pixmap := Void
			if parent /= Void then
				parent.implementation.redraw_item (implementation)
			end
		ensure
			pixmap_removed: pixmap = Void
		end

	set_left_border (a_left_border: INTEGER) is
			-- Assign `a_left_border' to `left_border'.
		require
			not_destroyed: not is_destroyed
			a_left_border_non_negative: a_left_border >= 0
		do
			left_border := a_left_border
			if parent /= Void then
				parent.implementation.redraw_item (implementation)
			end
		ensure
			left_border_set: left_border = a_left_border
		end

	set_right_border (a_right_border: INTEGER) is
			-- Assign `a_right_border' to `right_border'.
		require
			not_destroyed: not is_destroyed
			a_right_border_non_negative: a_right_border >= 0
		do
			right_border := a_right_border
			if parent /= Void then
				parent.implementation.redraw_item (implementation)
			end
		ensure
			right_border_set: right_border = a_right_border
		end

	set_top_border (a_top_border: INTEGER) is
			-- Assign `a_top_border' to `top_border'.
		require
			not_destroyed: not is_destroyed
			a_top_border_non_negative: a_top_border >= 0
		do
			top_border := a_top_border
			if parent /= Void then
				parent.implementation.redraw_item (implementation)
			end
		ensure
			top_border_set: top_border = a_top_border
		end

	set_bottom_border (a_bottom_border: INTEGER) is
			-- Assign `a_bottom_border' to `bottom_border'.
		require
			not_destroyed: not is_destroyed
			a_bottom_border_non_negative: a_bottom_border >= 0
		do
			bottom_border := a_bottom_border
			if parent /= Void then
				parent.implementation.redraw_item (implementation)
			end
		ensure
			bottom_border_set: bottom_border = a_bottom_border
		end

	set_spacing (a_spacing: INTEGER) is
			-- Assign `a_spacing' to `spacing'.
		require
			not_destroyed: not is_destroyed
			a_spacing_non_negative: a_spacing >= 0
		do
			spacing := a_spacing
			if parent /= Void then
				parent.implementation.redraw_item (implementation)
			end
		ensure
			spacing_set: spacing = a_spacing
		end

	align_text_center is
			-- Display `text' centered.
		require
			not_destroyed: not is_destroyed
		do
			text_alignment := {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_center
			if parent /= Void then
				parent.implementation.redraw_item (implementation)
			end
		ensure
			alignment_set: is_center_aligned
		end

	align_text_right is
			-- Display `text' right aligned.
		require
			not_destroyed: not is_destroyed
		do
			text_alignment := {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_right
			if parent /= Void then
				parent.implementation.redraw_item (implementation)
			end
		ensure
			alignment_set: is_right_aligned
		end
        
	align_text_left is
			-- Display `text' left aligned.
		require
			not_destroyed: not is_destroyed
		do
			text_alignment := {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_left
			if parent /= Void then
				parent.implementation.redraw_item (implementation)
			end
		ensure
			alignment_set: is_left_aligned
		end

	set_layout_procedure (a_layout_procedure: PROCEDURE [ANY, TUPLE [EV_GRID_LABEL_ITEM, EV_GRID_LABEL_ITEM_LAYOUT]]) is
			-- Assign `a_layout_procedure' to `layout_procedure'.
		do
			layout_procedure := a_layout_procedure
		ensure	
			layout_procedure_set: layout_procedure = a_layout_procedure
		end
			
feature -- Measurement

	left_border: INTEGER
			-- Spacing between the contents of `Current' and the left edge of `Current' in pixels.

	right_border: INTEGER
			-- Spacing between the contents of `Current' and the right edge of `Current' in pixels.

	top_border: INTEGER
			-- Spacing between the contents of `Current' and the top edge of `Current' in pixels.

	bottom_border: INTEGER
			-- Spacing between the contents of `Current' and the bottom edge of `Current' in pixels.

	spacing: INTEGER
			-- Spacing between `text' and `pixmap' in pixels.
			-- If both are not visible, this value does not affect appearance of `Current'.

	text_width: INTEGER is
			-- `Result' is width required to fully display `text' in `pixels'.
			-- This function is optimized internally by `Current' and is therefore
			-- faster than querying `font.string_size' directly.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.text_width
		ensure		
			result_non_negative: result >= 0
		end

	text_height: INTEGER is
			-- `Result' is height required to fully display `text' in `pixels'.
			-- This function is optimized internally by `Current' and is therefore
			-- faster than querying `font.string_size' directly.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.text_width
		ensure		
			result_non_negative: result >= 0
		end
		
feature -- Status report

	text: STRING
		-- Text displayed in `Current'.
		
	font: EV_FONT
		-- Typeface appearance for `Current'.
			
	pixmap: EV_PIXMAP
		-- Image displayed to left of `text'.

	text_alignment: INTEGER
			-- Current alignment.
			-- See class EV_TEXT_ALIGNABLE_CONSTANTS for
			-- possible values.

	is_left_aligned: BOOLEAN is
			-- Is `Current' left aligned?
		require
			not_destroyed: not is_destroyed
		do
			Result := text_alignment = {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_left
		end
		
	is_center_aligned: BOOLEAN is
			-- Is `Current' center aligned?
		require
			not_destroyed: not is_destroyed
		do
			Result := text_alignment = {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_center
		end

	is_right_aligned: BOOLEAN is
			-- Is `Current' right aligned?
		require
			not_destroyed: not is_destroyed
		do
			Result := text_alignment = {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_right
		end

	layout_procedure: PROCEDURE [ANY, TUPLE [EV_GRID_LABEL_ITEM, EV_GRID_LABEL_ITEM_LAYOUT]]
			-- Procedure which may be used to calculate the position of `text' and `pixmap' relative to `Current',
			-- ready for the drawing implementation.
			-- This procedure is fired each time that `Current' must be re-drawn and by filling the passed EV_GRID_LABEL_ITEM_LAYOUT object, the
			-- position relative to the top left of `Current' at which `text' and `pixmap' is to be drawn may be set explicitly.
			-- The properties set into EV_GRID_LABEL_ITEM override any other positional settings such as `alignment' within `Current'.
			-- Be sure to query the width and height of `text' from the label item directly via `text_width' and `text_height' as
			-- this is optimized and quicker than `font.string_size' for repeated calls.

			-- Arguments (from left to right):
			-- label_item: EV_GRID_LABEL_ITEM - `Current' to which the settings apply.
			-- label_item_layout: EV_GRID_LABEL_ITEM_LAYOUT - Object into which desired positioning information must be set.

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_GRID_ITEM} and text.is_empty and pixmap = Void and
				left_border = 2 and right_border = 0 and top_border = 0 and bottom_border = 0
				and spacing = 2 and is_left_aligned
		end

feature {EV_ANY, EV_ANY_I, EV_GRID_DRAWER_I} -- Implementation

	implementation: EV_GRID_LABEL_ITEM_I
			-- Responsible for interaction with native graphics toolkit.
			
feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_GRID_LABEL_ITEM_I} implementation.make (Current)
		end

end

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------
