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
		undefine
			default_style,
			default_ex_style
		redefine
			interface,
			old_make,
			on_size,
			ev_apply_new_size,
			compute_minimum_width,
			compute_minimum_height,
			compute_minimum_size
		end

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: like interface)
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
		local
			l_item_imp: like item_imp
		do
			if item /= Void then
				l_item_imp := item_imp
				check l_item_imp /= Void end
				l_item_imp.ev_move (- an_x, interface_item.y_position)
			end
		end

	set_y_offset (a_y: INTEGER)
			-- Set `y_offset' to `a_y'.
		local
			l_item_imp: like item_imp
		do
			if item /= Void then
				l_item_imp := item_imp
				check l_item_imp /= Void end
				l_item_imp.ev_move (interface_item.x_position, - a_y)
			end
		end

	set_offset (an_x, a_y: INTEGER)
			-- Assign `an_x' to `x_offset'.
			-- Assign `a_y' to `y_offset'.
		local
			l_item_imp: like item_imp
		do
			if item /= Void then
				l_item_imp := item_imp
				check l_item_imp /= Void end
				l_item_imp.ev_move (- an_x, - a_y)
			end
		end

feature {EV_ANY_I} -- Implementation

	compute_minimum_width, compute_minimum_height, compute_minimum_size
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


	default_style: INTEGER
		do
			Result := Ws_child | Ws_clipchildren | Ws_clipsiblings | Ws_visible
		end

	default_ex_style: INTEGER
			-- The default ex-style of the window.
		do
			Result := Ws_ex_controlparent
		end

	on_size (size_type, a_width, a_height: INTEGER)
		local
			t: like resize_actions_internal
		do
			if size_type /= Wel_window_constants.Size_minimized then
				t := resize_actions_internal
				if t /= Void then
					t.call ([screen_x, screen_y, a_width, a_height])
				end
				if item /= Void then
					on_size_requested (True)
				end
			end
		end

	ev_apply_new_size (a_x_position, a_y_position,
				a_width, a_height: INTEGER; repaint: BOOLEAN)
		do
			ev_move_and_resize
				(a_x_position, a_y_position, a_width, a_height, repaint)
			if item_imp /= Void then
				on_size_requested (False)
			end
		end

	on_size_requested (originator: BOOLEAN)
			-- Size has changed.
		require
			item_not_void: item /= Void
		local
			imp: like item_imp
		do
			imp := item_imp
			check imp /= Void end
			if originator then
				imp.set_move_and_size (imp.x_position, imp.y_position,
					imp.width, imp.height)
			else
				imp.ev_apply_new_size (imp.x_position ,imp.y_position,
					imp.width, imp.height, True)
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
				-- the best solution. Julian 07/17/02
			l_item_imp := item_imp
			check
				has_item: l_item_imp /= Void
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

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_VIEWPORT note option: stable attribute end;

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




end -- class EV_VIEWPORT_IMP








