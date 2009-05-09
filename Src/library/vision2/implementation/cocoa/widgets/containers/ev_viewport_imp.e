note
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
			interface
		end

	EV_CELL_IMP
		redefine
			interface,
			make,
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
--		do
--			Result := scroll_view.bounds.origin.x
--		end

	y_offset: INTEGER
			-- Vertical position of viewport relative to `item'.
--		do
--			Result := scroll_view.bounds.origin.y
--		end

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
			ev_apply_new_size (x_position, y_position, width, height, False)
		end

	set_x_offset (a_x: INTEGER)
			-- Set `x_offset' to `a_x'.
		do
			scroll_view.content_view.scroll_to_point (create {NS_POINT}.make_point (a_x, y_offset))
			x_offset := a_x
		end

	set_y_offset (a_y: INTEGER)
			-- Set `y_offset' to `a_y'.
		do
			scroll_view.content_view.scroll_to_point (create {NS_POINT}.make_point (x_offset, a_y))
			y_offset := a_y
		end

	set_item_size (a_width, a_height: INTEGER)
			-- Set `a_widget.width' to `a_width'.
			-- Set `a_widget.height' to `a_height'.
		do
			item_imp.parent_ask_resize (a_width, a_height)
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

feature {EV_ANY_I} -- Implementation

	interface: EV_VIEWPORT;

	document_view: NS_VIEW

	scroll_view: NS_SCROLL_VIEW
		do
			Result ?= cocoa_item
		end

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_VIEWPORT_IMP

