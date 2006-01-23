indexing
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

create {EV_ANY_I}
	default_create
		
feature -- Access

	grid_label_item: EV_GRID_LABEL_ITEM
		-- Associated EV_GRID_LABEL_ITEM to which the properties of `Current' are applied.

	pixmap_x: INTEGER
		-- Horizontal position to be used for drawing `grid_label_item.pixmap', relative
		-- to the left edge of `grid_label_item'.

	pixmap_y: INTEGER
		-- Vertical position to be used for frawing `grid_label_item.pixmap', relative
		-- to the top edge of `grid_label_item'.

	text_x: INTEGER
		-- Horizontal position to be used for drawing `grid_label_item.text', relative
		-- to the left edge of `grid_label_item'.

	text_y: INTEGER
		-- Vertical position to be used for drawing `grid_label_item.text', relative
		-- to the top edge of `grid_label_item'.

feature -- Status Setting

	set_pixmap_x (a_pixmap_x: INTEGER) is
			-- Assign `a_pixmap_x' to `pixmap_x'.
		do
			pixmap_x := a_pixmap_x
		ensure
			pixmap_x_set: pixmap_x = a_pixmap_x
		end

	set_pixmap_y (a_pixmap_y: INTEGER) is
			-- Assign `a_pixmap_y' to `pixmap_y'.
		do
			pixmap_y := a_pixmap_y
		ensure
			pixmap_y_set: pixmap_y = a_pixmap_y
		end

	set_text_x (a_text_x: INTEGER) is
			-- Assign `a_text_x' to `text_x'.
		do
			text_x := a_text_x
		ensure
			text_x_set: text_x = a_text_x
		end

	set_text_y (a_text_y: INTEGER) is
			-- Assign `a_text_y' to `text_y'.
		do
			text_y := a_text_y
		ensure
			text_y_set: text_y = a_text_y
		end

feature {EV_ANY_I} -- Implementation

	set_grid_label_item (a_grid_label_item: EV_GRID_LABEL_ITEM) is
			-- Assign `a_grid_label_item' to `grid_label_item'.
		do
			grid_label_item := a_grid_label_item
		ensure
			grid_label_item_set: grid_label_item =  a_grid_label_item
		end
		
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




end

