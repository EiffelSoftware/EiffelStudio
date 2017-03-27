note
	description: "Eiffel Vision viewport. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
		redefine
			interface,
			old_make,
			on_size,
			ev_apply_new_size,
			compute_minimum_width,
			compute_minimum_height,
			compute_minimum_size,
			on_erase_background,
			default_style
		end

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: attached like interface)
			-- Initialize.
		do
			assign_interface (an_interface)
		end

feature -- Access

	x_offset: INTEGER
			-- Horizontal position of viewport relative to `item'.
		do
			if item /= Void then
				Result := - interface_item.x_position
			end
		end

	y_offset: INTEGER
			-- Vertical position of viewport relative to `item'.
		do
			if item /= Void then
				Result := - interface_item.y_position
			end
		end

feature -- Element change

	set_x_offset (an_x: INTEGER)
			-- Set `x_offset' to `an_x'.
		do
			if attached item_imp as l_item_imp then
				l_item_imp.ev_move (- an_x, interface_item.y_position)
			end
		end

	set_y_offset (a_y: INTEGER)
			-- Set `y_offset' to `a_y'.
		do
			if attached item_imp as l_item_imp then
				l_item_imp.ev_move (interface_item.x_position, - a_y)
			end
		end

	set_offset (an_x, a_y: INTEGER)
			-- Assign `an_x' to `x_offset'.
			-- Assign `a_y' to `y_offset'.
		do
			if attached item_imp as l_item_imp then
				l_item_imp.ev_move (- an_x, - a_y)
			end
		end

feature {EV_ANY_I} -- Implementation

	compute_minimum_width, compute_minimum_height, compute_minimum_size (a_is_size_forced: BOOLEAN)
			-- Recompute both minimum_width and minimum_height of `Current'.
			-- Does nothing since it does not have a sense to compute it,
			-- it is only what the user set it to.
		do
			ev_set_minimum_size (child_cell.minimum_width, child_cell.minimum_height, a_is_size_forced)
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

	on_size (size_type, a_width, a_height: INTEGER)
		do
			on_size_requested (True)
			trigger_resize_actions (a_width, a_height)
		end

	ev_apply_new_size (a_x_position, a_y_position,
				a_width, a_height: INTEGER; repaint: BOOLEAN)
		do
			ev_move_and_resize
				(a_x_position, a_y_position, a_width, a_height, repaint)
			on_size_requested (False)
		end

	on_size_requested (originator: BOOLEAN)
			-- Size has changed.
		do
			if attached item_imp as imp then
				if originator then
					imp.set_move_and_size (imp.x_position, imp.y_position,
						imp.width, imp.height)
				else
					imp.ev_apply_new_size (imp.x_position ,imp.y_position,
						imp.width, imp.height, True)
				end
			end
		end

	set_item_size (a_width, a_height: INTEGER)
			-- Set `a_widget.width' to `a_width'.
			-- Set `a_widget.height' to `a_height'.
		local
			wel_win: detachable EV_WIDGET_IMP
			l_item_imp: like item_imp
		do
			wel_win ?= interface_item.implementation
			check
				wel_win_not_void: wel_win /= Void then
			end
			wel_win.parent_ask_resize (a_width, a_height)
			if
				wel_win.x_position + wel_win.width > width or else
				wel_win.y_position + wel_win.height > height
			then
				notify_change (Nc_minsize, wel_win, False)
			end

				-- If we have not been displayed, then we
				-- must update the ranges, as we may then
				-- call `set_*_offset' for which the ranges
				-- must be set. Not sure if this really is
				-- the best solution. Julian 07/17/02
			l_item_imp := item_imp
			check
				has_item: l_item_imp /= Void then
			end
			if scroller /= Void then
				if is_horizontal_scroll_bar_visible then
					set_horizontal_range (0, l_item_imp.width)
				end
				if is_vertical_scroll_bar_visible then
					set_vertical_range (0, l_item_imp.height)
				end
			end
		end

	default_style: INTEGER
		do
				-- We do not use `Ws_clipchildren' because we can do the job ourself.			
			Result := ws_child | ws_visible | ws_clipsiblings
		end

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT)
		local
			l_x_pos, l_y_pos, l_right_pos, l_bottom_pos: INTEGER
			l_width, l_height: INTEGER
			l_brush: like background_brush
			l_erased: BOOLEAN
		do
			if not is_theme_background_requested and attached item_imp as l_item then
					-- If `item' is within the viewport, we need to clear the border surrounding it, otherwise nothing to be done.
				l_x_pos := l_item.x_position
				l_y_pos := l_item.y_position
				l_right_pos := l_item.x_position + l_item.width
				l_bottom_pos := l_item.y_position + l_item.height
				l_width := invalid_rect.right
				l_height := invalid_rect.bottom
				l_brush := background_brush
				if l_brush /= Void then
					if l_y_pos > 0 then
						invalid_rect.set_rect (0, 0, l_width , l_y_pos)
						application_imp.theme_drawer.draw_widget_background (Current, paint_dc, invalid_rect, l_brush)
						l_erased := True
					end
					if l_x_pos > 0 then
						invalid_rect.set_rect (0, l_y_pos.max (0), l_x_pos, l_bottom_pos.min (l_height))
						application_imp.theme_drawer.draw_widget_background (Current, paint_dc, invalid_rect, l_brush)
						l_erased := True
					end
					if l_right_pos < l_width then
						invalid_rect.set_rect (l_right_pos, l_y_pos.max (0), l_width, l_bottom_pos.min (l_height))
						application_imp.theme_drawer.draw_widget_background (Current, paint_dc, invalid_rect, l_brush)
						l_erased := True
					end
					if l_bottom_pos < l_height then
						invalid_rect.set_rect (0, l_bottom_pos, l_width, l_height)
						application_imp.theme_drawer.draw_widget_background (Current, paint_dc, invalid_rect, l_brush)
						l_erased := True
					end
					disable_default_processing
					set_message_return_value (to_lresult (1))
					l_brush.delete
				else
						-- We let Windows handle the message.
				end
			else
					-- No items, we need to clear the background completely.
				clear_background (paint_dc, invalid_rect)
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_VIEWPORT note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
