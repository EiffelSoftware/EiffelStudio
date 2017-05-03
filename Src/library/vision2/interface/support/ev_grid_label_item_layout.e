note
	description: "[
		Objects that permit custom positioning of a `text' and `pixmap' within an EV_GRID_LABEL_ITEM.
		You may not create these objects. To use, connect an agent to `layout_procedure' of EV_GRID_LABEL_ITEM
		and an instance of this class is passed as an argument when the action sequence is fired. Fill in the
		attributes as required and the `text' and `pixmap' of the EV_GRID_LABEL_ITEM are positioned accordingly.
		All coordinates are 0 based.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_LABEL_ITEM_LAYOUT

create
	default_create

feature -- Access

	grid_label_item: detachable EV_GRID_LABEL_ITEM
			-- Associated EV_GRID_LABEL_ITEM to which the properties of `Current' are applied.
		obsolete
			"Use the argument given during the call back to your layout procedure instead. [2017-05-31]"
		do
		end

	pixmap_x: INTEGER
			-- Horizontal position to be used for drawing `{EV_GRID_LABEL_ITEM}.pixmap', relative
			-- to the left edge of an EV_GRID_LABEL_ITEM.

	pixmap_y: INTEGER
			-- Vertical position to be used for frawing `{EV_GRID_LABEL_ITEM}.pixmap', relative
			-- to the top edge of an EV_GRID_LABEL_ITEM.

	checkbox_x: INTEGER
			-- Horizontal position to be used for drawing the check box if any, relative
			-- to the left edge of an EV_GRID_LABEL_ITEM.

	checkbox_y: INTEGER
			-- Vertical position to be used for drawing the check box if any, relative
			-- to the top edge of an EV_GRID_LABEL_ITEM.

	text_x: INTEGER
			-- Horizontal position to be used for drawing `{EV_GRID_LABEL_ITEM}.text', relative
			-- to the left edge of an EV_GRID_LABEL_ITEM.

	text_y: INTEGER
			-- Vertical position to be used for drawing `{EV_GRID_LABEL_ITEM}.text', relative
			-- to the top edge of an EV_GRID_LABEL_ITEM.

	available_text_width: INTEGER
			-- Available width to display `{EV_GRID_LABEL_ITEM}.text'.

	has_text_pixmap_overlapping: BOOLEAN
			-- Can text and pixmap overlap? If not, text will be truncated to the smallest of `pixmap_x'
			-- and `{an EV_GRID_LABEL_ITEM.}.width' when `text_x' is smaller than `pixmap_x'.

feature -- Status Setting

	set_pixmap_x (a_x: INTEGER)
			-- Assign `a_x' to `pixmap_x'.
		do
			pixmap_x := a_x
		ensure
			pixmap_x_set: pixmap_x = a_x
		end

	set_pixmap_y (a_y: INTEGER)
			-- Assign `a_y' to `pixmap_y'.
		do
			pixmap_y := a_y
		ensure
			pixmap_y_set: pixmap_y = a_y
		end

	set_text_x (a_x: INTEGER)
			-- Assign `a_x' to `text_x'.
		do
			text_x := a_x
		ensure
			text_x_set: text_x = a_x
		end

	set_text_y (a_y: INTEGER)
			-- Assign `a_y' to `text_y'.
		do
			text_y := a_y
		ensure
			text_y_set: text_y = a_y
		end

	set_available_text_width (a_width: INTEGER)
			-- Assign `a_width' to `available_text_width'.
		require
			a_width_non_negative: a_width >= 0
		do
			available_text_width := a_width
		ensure
			available_text_width_set: available_text_width = a_width
		end

	set_checkbox_x (a_x: INTEGER)
			-- Assign `a_x' to `checkbox_x'.
		do
			checkbox_x := a_x
		ensure
			checkbox_x_set: checkbox_x = a_x
		end

	set_checkbox_y (a_y: INTEGER)
			-- Assign `a_y' to `checkbox_y'.
		do
			checkbox_y := a_y
		ensure
			checkbox_y_set: checkbox_y = a_y
		end

	set_has_text_pixmap_overlapping (v: like has_text_pixmap_overlapping)
			-- Assign `v' to `has_text_pixmap_overlapping'.
		do
			has_text_pixmap_overlapping := v
		ensure
			has_text_pixmap_overlapping_set: has_text_pixmap_overlapping = v
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end












