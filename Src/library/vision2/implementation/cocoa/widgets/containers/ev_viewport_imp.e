indexing
	description: "Eiffel Vision viewport. Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VIEWPORT_IMP

inherit
	EV_VIEWPORT_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface,
			set_item_width,
			set_item_height
		end

	EV_CELL_IMP
		redefine
			interface,
			make,
			on_removed_item,
			replace,
			compute_minimum_width,
			compute_minimum_height,
			compute_minimum_size,
			ev_apply_new_size
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Initialize.
		do
			base_make (an_interface)
			create {NS_SCROLL_VIEW}cocoa_item.new
			create document_view.new
			scroll_view.set_has_horizontal_scroller (False)
			scroll_view.set_has_vertical_scroller (False)
			scroll_view.set_draws_background (False)
			scroll_view.set_document_view (document_view)
		end

feature -- Access

	x_offset: INTEGER
			-- Horizontal position of viewport relative to `item'.
		do
		end

	y_offset: INTEGER
			-- Vertical position of viewport relative to `item'.
		do
		end

feature -- Element change

	replace (v: like item)
			-- Replace `item' with `v'.
		local
			v_imp: like item_imp
		do
			if item_imp /= void then
				on_removed_item (item_imp)
			end
			if v /= Void then
				v_imp ?= v.implementation
				document_view.add_subview (v_imp.cocoa_view)
				on_new_item (v_imp)
			end
			item := v
		end

	block_resize_actions
			-- Block any resize actions that may occur.
		do
		end

	unblock_resize_actions
			-- Unblock all resize actions.
		do
		end

	set_x_offset (a_x: INTEGER)
			-- Set `x_offset' to `a_x'.
		do
			internal_set_offset (a_x, -1)
		end

	set_y_offset (a_y: INTEGER)
			-- Set `y_offset' to `a_y'.
		do
		 internal_set_offset (-1, a_y)
		end

	set_item_size (a_width, a_height: INTEGER)
			-- Set `a_widget.width' to `a_width'.
			-- Set `a_widget.height' to `a_height'.
		do
			internal_set_item_size (a_width, a_height)
		end

	set_item_width (a_width: INTEGER)
			-- Set `a_widget.width' to `a_width'.
		do
			internal_set_item_size (a_width, -1)
		end

	set_item_height (a_height: INTEGER)
			-- Set `a_widget.height' to `a_height'.
		do
			internal_set_item_size (-1, a_height)
		end

feature -- Layout

	compute_minimum_width, compute_minimum_height, compute_minimum_size
			-- Recompute both minimum_width and minimum_height of `Current'.
			-- Does nothing since it does not have a sense to compute it,
			-- it is only what the user set it to.
		do
			internal_set_minimum_size (minimum_width, minimum_height)
		end

	ev_apply_new_size (a_x_position, a_y_position, a_width, a_height: INTEGER; repaint: BOOLEAN)
		local
			l_x_position, l_y_position: INTEGER
			l_width, l_height: INTEGER
			l_dv_width, l_dv_height: INTEGER
		do
			ev_move_and_resize (a_x_position, a_y_position, a_width, a_height, repaint)
			if item /= Void then
				l_width := item_imp.minimum_width
				l_height := item_imp.minimum_height
				if l_width < a_width then
					l_x_position := (a_width - l_width) // 2
				end
				if l_height < a_height then
					l_y_position := (a_height - l_height) // 2
				end
				-- The document view is needed to position the item widget properly because NSScrollView ignores the offset, so it would always be at the bottom (instead of centered)
				-- TODO has_vertical/horizontal scroller actually returns the old value... better to calculate manually
				if scroll_view.has_vertical_scroller then
					l_dv_width := l_width.max (a_width - {NS_SCROLLER}.scroller_width)
				else
					l_dv_width := l_width.max (a_width)
				end
				if scroll_view.has_horizontal_scroller then
					l_dv_height := l_height.max (a_height - {NS_SCROLLER}.scroller_width)
				else
					l_dv_height := l_height.max (a_height)
				end
				document_view.set_frame (create {NS_RECT}.make_rect(0, 0, l_dv_width, l_dv_height))
				item_imp.ev_apply_new_size (l_x_position, l_y_position, l_width, l_height, True)
			end
		end

feature {NONE} -- Implementation

	internal_set_offset (a_x, a_y: INTEGER)
		do
		end

	internal_set_container_size (a_height, a_width: INTEGER_32)
		do
		end

	internal_set_item_size (a_width, a_height: INTEGER)
			-- Set `a_widget.width' to `a_width'.
			-- Set `a_widget.height' to `a_height'.
		do
		end

	on_removed_item (an_item_imp: EV_WIDGET_IMP)
			-- Reset minimum size.
		do
			an_item_imp.set_parent_imp (Void)
		end

	internal_x_offset, internal_y_offset: INTEGER

	internal_set_value_from_adjustment (l_adj: POINTER; a_value: INTEGER)
			-- Set `value' of adjustment `l_adj' to `a_value'.
		require
			l_adj_not_null: l_adj /= default_pointer
		do

  		end

feature {EV_ANY_I} -- Implementation

	interface: EV_VIEWPORT;

	document_view: NS_VIEW

	scroll_view: NS_SCROLL_VIEW
		do
			Result ?= cocoa_item
		end

indexing
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_VIEWPORT_IMP

