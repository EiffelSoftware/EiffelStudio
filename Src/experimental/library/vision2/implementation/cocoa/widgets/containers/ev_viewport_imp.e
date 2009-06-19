note
	description: "Eiffel Vision viewport. Cocoa implementation."
	author:	"Daniel Furrer"
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

	make
		do
			create scroll_view.make
			scroll_view.set_has_horizontal_scroller (False)
			scroll_view.set_has_vertical_scroller (False)
			scroll_view.set_draws_background (False)

			cocoa_item := scroll_view
			set_is_initialized (True)
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
				v_imp.set_parent_imp (Void)
				notify_change (Nc_minsize, Current)
			end
			if v /= Void then
				v_imp ?= v.implementation
				v_imp.set_parent_imp (current)
				scroll_view.set_document_view (v_imp.cocoa_view)
				v_imp.ev_apply_new_size (0, 0, v_imp.width, v_imp.height, True)
				v_imp.set_parent_imp (Current)
				notify_change (Nc_minsize, Current)
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
		do
			ev_move_and_resize (a_x_position, a_y_position, a_width, a_height, repaint)
			if attached item_imp then
				scroll_view.set_document_view (item_imp.cocoa_view)
				item_imp.ev_apply_new_size (0, 0, item_imp.width, item_imp.height, True)
			end
--			if a_width > 0 then -- Hack because I want to get EV_GAUGE working. TODO How/where/when should the resize actions be called?
--				on_size (a_width, a_height)
--			end
		end

--	on_size (a_width, a_height: INTEGER)
--		do
--			if resize_actions_internal /= Void then
--				resize_actions_internal.call ([screen_x, screen_y, a_width, a_height])
--			end
--		end

feature {EV_ANY_I} -- Implementation

	interface: detachable EV_VIEWPORT note option: stable attribute end;

	scroll_view: NS_SCROLL_VIEW;

end -- class EV_VIEWPORT_IMP
