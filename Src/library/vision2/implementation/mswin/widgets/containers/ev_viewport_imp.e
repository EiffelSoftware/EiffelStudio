indexing
	description: "Eiffel Vision viewport. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_VIEWPORT_IMP
	
inherit
	EV_VIEWPORT_I
		redefine
			interface,
			set_offset
		end
		
	EV_CELL_IMP
		undefine
			default_style,
			default_ex_style
		redefine
			interface,
			make,
			on_size,
			ev_apply_new_size,
			compute_minimum_width,
			compute_minimum_height,
			compute_minimum_size
		end

create
	make

feature {NONE} -- Initialization
	
	make (an_interface: like interface) is
			-- Initialize. 
		do
			base_make (an_interface)
			wel_make (Default_parent, "")
		end	

feature -- Access

	x_offset: INTEGER is
			-- Horizontal position of viewport relative to `item'.
		do
			if item /= Void then
				Result := - item.x_position
			end
		end

	y_offset: INTEGER is
			-- Vertical position of viewport relative to `item'.
		do
			if item /= Void then
				Result := - item.y_position
			end
		end

feature -- Element change

	set_x_offset (an_x: INTEGER) is
			-- Set `x_offset' to `an_x'.
		do
			if item /= Void then
				item_imp.ev_move (- an_x, item.y_position)
			end
		end

	set_y_offset (a_y: INTEGER) is
			-- Set `y_offset' to `a_y'.
		do
			if item /= Void then
				item_imp.ev_move (item.x_position, - a_y)
			end
		end

	set_offset (an_x, a_y: INTEGER) is
			-- Assign `an_x' to `x_offset'.
			-- Assign `a_y' to `y_offset'.
		do
			if item /= Void then
				item_imp.ev_move (- an_x, - a_y)
			end
		end

feature {EV_ANY_I} -- Implementation

	compute_minimum_width, compute_minimum_height, compute_minimum_size is
			-- Recompute both minimum_width and minimum_height of `Current'.
			-- Does nothing since it does not have a sense to compute it,
			-- it is only what the user set it to.
		do
			ev_set_minimum_size (child_cell.minimum_width, child_cell.minimum_height)
		end

feature {NONE} -- Implementation

	is_horizontal_scroll_bar_visible: BOOLEAN
		-- Should horizontal scroll bar be displayed?
		-- Always False in VIEWPORT, but declared here,
		-- so that we do not have to redefine `set_item_size'
		-- for scrollable areas. Applies also to
		-- `is_vertical_scroll_bar_visible'.

	is_vertical_scroll_bar_visible: BOOLEAN
		-- Should vertical scrollbar be displayed?


	default_style: INTEGER is
		do
			Result := Ws_child + Ws_clipchildren + Ws_clipsiblings + Ws_visible
		end

	default_ex_style: INTEGER is
			-- The default ex-style of the window.
		do
			Result := Ws_ex_controlparent
		end

	on_size (size_type, a_width, a_height: INTEGER) is
		do
			if size_type /= Wel_window_constants.Size_minimized then
				interface.resize_actions.call (
					[screen_x, screen_y, a_width, a_height]
				)
				if item /= Void then
					on_size_requested (True)
				end
			end
		end

	ev_apply_new_size (a_x_position, a_y_position,
				a_width, a_height: INTEGER; repaint: BOOLEAN) is
		do
			ev_move_and_resize
				(a_x_position, a_y_position, a_width, a_height, repaint)
			if item_imp /= Void then
				on_size_requested (False)
			end
		end

	on_size_requested (originator: BOOLEAN) is
			-- Size has changed.
		require
			item_not_void: item /= Void
		local
			imp: like item_imp
		do
			imp := item_imp
			if originator then
				imp.set_move_and_size (imp.x_position, imp.y_position, 
					imp.width, imp.height)
			else
				imp.ev_apply_new_size (imp.x_position ,imp.y_position,
					imp.width, imp.height, True)			
			end
		end
		
	set_item_size (a_width, a_height: INTEGER) is
			-- Set `a_widget.width' to `a_width'.
			-- Set `a_widget.height' to `a_height'.
		local
			wel_win: EV_WIDGET_IMP
		do
			wel_win ?= item.implementation
			check
				wel_win_not_void: wel_win /= Void
			end
			wel_win.parent_ask_resize (a_width, a_height)
			if
				wel_win.x_position + wel_win.width > width or else
				wel_win.y_position + wel_win.height > height
			then
				notify_change (Nc_minsize, wel_win)
			end
			
				-- If we have not been displayed, then we
				-- must update the ranges, as we may then
				-- call `set_*_offset' for which the ranges
				-- must be set. Not sure if this really is
				-- the best solution. Julian 07/17/02.
			check
				has_item: item_imp /= Void
			end
			if scroller /= Void then
				if is_horizontal_scroll_bar_visible then
					set_horizontal_range (0, item_imp.width)
				end
				if is_vertical_scroll_bar_visible then
					set_vertical_range (0, item_imp.height)
				end
			end
		end

	interface: EV_VIEWPORT

end -- class EV_VIEWPORT_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

