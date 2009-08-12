note
	description: "Eiffel Vision cell, Cocoa implementation."
	author: "Daniel Furrer"
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

	EV_SINGLE_CHILD_CONTAINER_IMP
		redefine
			interface,
			compute_minimum_width,
			compute_minimum_height,
			compute_minimum_size,
			set_background_color,
			client_height,
			client_width,
			make
		end

	EV_DOCKABLE_TARGET_IMP
		redefine
			interface
		end

create
	make

feature -- initialization

	make
		local
			box: NS_BOX
		do
			create box.make
			box.set_box_type ({NS_BOX}.box_custom)
			box.set_border_type ({NS_BOX}.no_border)
			box.set_content_view_margins (0, 0)
			cocoa_view := box
			set_expandable (True) -- Check: is this correct??
			is_show_requested := True
			initialize -- Precursor {EV_CONTAINER_IMP}
			set_is_initialized (True)
		end

feature -- Access

	has (v: like item): BOOLEAN
			-- Does `Current' include `v'?	
		do
			Result := not is_destroyed and (v /= Void and then item = v)
		end

	count: INTEGER_32
			-- Number of elements in `Current'.	
		do
			if item /= Void then
				Result := 1
			end
		end

feature -- Element change

	set_background_color (a_color: EV_COLOR)
			-- Assign `a_color' to `background_color'
		local
			color: NS_COLOR
		do
			Precursor {EV_SINGLE_CHILD_CONTAINER_IMP} (a_color)
			if attached {NS_BOX} cocoa_view as l_box then -- TODO: get rid of this when redefining in children
				create color.color_with_calibrated_red_green_blue_alpha (a_color.red, a_color.green, a_color.blue, 1.0)
				--create color.white_color
				l_box.set_fill_color (color);
			end
		end

	top_level_window_imp: detachable EV_WINDOW_IMP
			-- Top level window that contains `Current'.

	set_top_level_window_imp (a_window: detachable EV_WINDOW_IMP)
			-- Make `a_window' the new `top_level_window_imp'
			-- of `Current'.
		do
			top_level_window_imp := a_window
			if attached item_imp as l_item_imp then
				l_item_imp.set_top_level_window_imp (a_window)
			end
		end

feature -- Layout

	client_height: INTEGER
			-- Height of the client area of `Current'
		do
			if attached {NS_BOX} cocoa_view as l_box then
				Result := l_box.content_view.frame.size.height.max (0).min (height)
			else
				Result := height
			end
		end

	client_width: INTEGER
			-- Height of the client area of `Current'.
		do
			if attached {NS_BOX} cocoa_view as l_box then
				Result := l_box.content_view.frame.size.width.max (0).min (width)
			else
				Result := width
			end
		end

	compute_minimum_width
			-- Recompute the minimum_width of `Current'.
		local
			mw: INTEGER
		do
			if attached item_imp as l_item_imp and then l_item_imp.is_show_requested then
				mw := l_item_imp.minimum_width
			end
			internal_set_minimum_width (mw)
		end

	compute_minimum_height
			-- Recompute the minimum_width of `Current'.
		local
			mh: INTEGER
		do
			if attached item_imp as l_item_imp and then l_item_imp.is_show_requested then
				mh := l_item_imp.minimum_height
			end
			internal_set_minimum_height (mh)
		end

	compute_minimum_size
			-- Recompute both the minimum_width the
			-- minimum_height of `Current'.
		local
			mw, mh: INTEGER
		do
			if attached item_imp as l_item_imp and then l_item_imp.is_show_requested then
				mw := l_item_imp.minimum_width
				mh := l_item_imp.minimum_height
			end
			internal_set_minimum_size (mw, mh)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_CELL note option: stable attribute end;
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

end -- class EV_CELL_IMP
