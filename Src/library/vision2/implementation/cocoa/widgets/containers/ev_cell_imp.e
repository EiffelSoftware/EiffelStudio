indexing
	description:
		"Eiffel Vision cell, Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CELL_IMP

inherit
	EV_CELL_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_CONTAINER_IMP
		redefine
			interface,
			replace,
			set_background_color,
			client_height,
			client_width,
			ev_apply_new_size
		end

	EV_DOCKABLE_TARGET_IMP
		redefine
			interface
		end

create
	make

feature -- initialization

	make (an_interface: like interface)
			-- Connect interface and initialize `c_object'.
		do
			base_make (an_interface)
			create {NS_BOX}cocoa_item.new
			box.set_box_type ({NS_BOX}.box_custom)
			box.set_border_type ({NS_BOX}.no_border)
		end

feature -- Access

	item: EV_WIDGET
			-- Current item.

feature -- Element change

	replace (v: like item)
			-- Replace `item' with `v'.
		local
			v_imp: like item_imp
		do
			if item_imp /= void then
				item_imp.cocoa_view.remove_from_superview
				on_removed_item (item_imp)
			end
			if v /= Void then
				v_imp ?= v.implementation
				cocoa_view.add_subview (v_imp.cocoa_view)
				on_new_item (v_imp)
			end
			item := v
		end

	set_background_color (a_color: EV_COLOR)
			-- Assign `a_color' to `background_color'
		local
			color: NS_COLOR
		do
			Precursor {EV_CONTAINER_IMP} (a_color)
			if box /= void then -- TODO: get rid of this when redefining in children
				create color.color_with_calibrated_red_green_blue_alpha (a_color.red, a_color.green, a_color.blue, 1.0)
				--create color.white_color
				box.set_fill_color (color);
			end
		end

	top_level_window_imp: EV_WINDOW_IMP
			-- Top level window that contains `Current'.

	set_top_level_window_imp (a_window: EV_WINDOW_IMP)
			-- Make `a_window' the new `top_level_window_imp'
			-- of `Current'.
		do
			top_level_window_imp := a_window
			if item_imp /= Void then
				item_imp.set_top_level_window_imp (a_window)
			end
		end

feature -- Layout

	ev_apply_new_size (a_x_position, a_y_position, a_width, a_height: INTEGER; repaint: BOOLEAN)
		do
			ev_move_and_resize (a_x_position, a_y_position, a_width, a_height, repaint)
			if item /= Void then
				item_imp.ev_apply_new_size (0, 0, client_width, client_height, True)
			end
		end

	client_height: INTEGER
			-- Height of the client area of `Current'
		local
			cv: NS_VIEW
		do
			if box /= void then
				create cv.new_shared (box.content_view)
				Result := cv.frame.size.height.max (0)
			else
				Result := height
			end
		end

	client_width: INTEGER
			-- Height of the client area of `Current'.
		local
			cv: NS_VIEW
		do
			if box /= void then
				create cv.new_shared (box.content_view)
				Result := cv.frame.size.width.max (0)
			else
				Result := width
			end
		end

	compute_minimum_width
			-- Recompute the minimum_width of `Current'.
		local
			mw: INTEGER
		do
			if item_imp /= Void and item_imp.is_show_requested then
				mw := item_imp.minimum_width
			end
			internal_set_minimum_width (mw)
		end

	compute_minimum_height
			-- Recompute the minimum_width of `Current'.
		local
			mh: INTEGER
		do
			if item_imp /= Void and item_imp.is_show_requested then
				mh := item_imp.minimum_height
			end
			internal_set_minimum_height (mh)
		end

	compute_minimum_size
			-- Recompute both the minimum_width the
			-- minimum_height of `Current'.
		local
			mw, mh: INTEGER
		do
			if item_imp /= Void and item_imp.is_show_requested then
				mw := item_imp.minimum_width
				mh := item_imp.minimum_height
			end
			internal_set_minimum_size (mw, mh)
		end

feature {NONE}

	box: NS_BOX
		do
			Result ?= cocoa_item
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_CELL;
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

indexing
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_CELL_IMP

