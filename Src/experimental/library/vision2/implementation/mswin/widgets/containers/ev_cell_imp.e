note
	description: "Eiffel Vision cell. MS Windows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CELL_IMP

inherit
	EV_CELL_I
		redefine
			interface
		end

	EV_DOCKABLE_TARGET_IMP
		redefine
			interface
		end

	EV_SINGLE_CHILD_CONTAINER_IMP
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface,
			make
		end

	EV_WEL_CONTROL_CONTAINER_IMP
		rename
			make as ev_wel_control_container_make
		undefine
			on_wm_dropfiles,
			background_brush_gdip
		redefine
			top_level_window_imp,
			on_erase_background,
			default_style
		end

create
	make

feature -- initialization

	old_make (an_interface: attached like interface)
			-- Create `Current'.
		do
			assign_interface (an_interface)
		end

	make
		do
			ev_wel_control_container_make
			Precursor
		end

feature -- Element change

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

feature {EV_ANY_I} -- Implementation

	compute_minimum_width (a_is_size_forced: BOOLEAN)
			-- Recompute the `minimum_width' of `Current'.
		local
			mw: INTEGER
		do
			if attached item_imp as l_item_imp and then l_item_imp.is_show_requested then
				mw := l_item_imp.minimum_width
			end
			ev_set_minimum_width (mw, a_is_size_forced)
		end

	compute_minimum_height (a_is_size_forced: BOOLEAN)
			-- Recompute the `minimum_height' of `Current'.
		local
			mh: INTEGER
		do
			if attached item_imp as l_item_imp and then l_item_imp.is_show_requested then
				mh := l_item_imp.minimum_height
			end
			ev_set_minimum_height (mh, a_is_size_forced)
		end

	compute_minimum_size (a_is_size_forced: BOOLEAN)
			-- Recompute both the `minimum_width' and the
			-- `minimum_height' of `Current'.
		local
			mw, mh: INTEGER
		do
			if attached item_imp as l_item_imp and then l_item_imp.is_show_requested then
				mw := l_item_imp.minimum_width
				mh := l_item_imp.minimum_height
			end
			ev_set_minimum_size (mw, mh, a_is_size_forced)
		end

feature {NONE} -- WEL implementation

	default_style: INTEGER
			-- <Precursor>
		do
				-- We do not use `Ws_clipchildren' because we can do the job ourself.
			Result := ws_child | ws_visible | ws_clipsiblings
		end

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT)
			-- <Precursor>
		do
				-- Nothing to erase if there is an item.
			if item = Void or is_theme_background_requested then
				clear_background (paint_dc, invalid_rect)
			else
					-- We let the item handle this.
				disable_default_processing
				set_message_return_value (to_lresult (1))
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_CELL note option: stable attribute end;
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
