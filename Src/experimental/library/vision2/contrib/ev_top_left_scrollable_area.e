note
	description: "[
		An EV_SCROLLABLE_AREA were `item' always expand to use the whole available
		space and also were the wheel is hooked to scroll vertically if possible, and
		horizontally otherwise.
		]"
	legal: "See notice at end of class."
	appearance:
		"[
			---------------
			|           |^|
			|   `item'  | |
			|___________|v|
			|<_________>|_|
		]"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOP_LEFT_SCROLLABLE_AREA

inherit
	EV_SCROLLABLE_AREA
		rename
			extend as scrollable_area_extend,
			put as scrollable_area_put,
			replace as scrollable_area_replace,
			item as scrollable_area_item,
			extendible as scrollable_area_extendible
		redefine
			create_interface_objects,
			initialize
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		undefine
			copy, is_equal, default_create
		end

	EV_BUILDER

create
	default_create

feature {NONE} -- Initialization

	create_interface_objects
			-- Current
		do
			Precursor
			create cell
			previous_size := [0, 0]
			scroll_step := default_scroll_step
			scroll_percentage := default_scroll_percentage
		end

	initialize
			-- Initialize Current.
		do
			Precursor
			scrollable_area_extend (cell)
			resize_actions.extend (agent on_resize)
			mouse_wheel_actions.extend (agent on_mouse_wheel)
			ev_application.add_idle_action (agent on_refresh)
		end

feature -- Access

	item: detachable EV_WIDGET
		do
			if not cell.is_destroyed and then cell.readable then
				Result := cell.item
			end
		end

	default_scroll_step: INTEGER = 0
			-- Default (initial) value for `scroll_step'.

	default_scroll_percentage: INTEGER = 33
			-- Default (initial) value of `scroll_percentage'.

	scroll_step: INTEGER
			-- Number of pixels scrolled up or down when user scrolls with wheel.
			-- If not positive, `scroll_percentage' is used.

	scroll_percentage: INTEGER
			-- Percentage of the content that will scroll up or down when user scrolls with wheel.

feature -- Element Change

	set_scroll_step (a_scroll_step: INTEGER)
			-- Assign `a_scroll_step' to `scroll_step'.
		require
			positive_step: a_scroll_step >= 0
		do
			scroll_step := a_scroll_step
		ensure
			assigned: scroll_step = a_scroll_step
		end

	set_scroll_percentage (a_scroll_percentage: INTEGER)
			-- Assign `a_scroll_percentage' to `scroll_percentage'.
		require
			positive_step: a_scroll_percentage > 0
		do
			scroll_percentage := a_scroll_percentage
		ensure
			assigned: scroll_percentage = a_scroll_percentage
		end

feature -- Status report

	extendible: BOOLEAN
			-- Is Current extendible?
		do
			Result := cell.extendible
		end

feature -- Updates

	extend (v: attached like item)
		require
			not_destroyed: not is_destroyed
			extendible: extendible
			v_not_void: v /= Void
			v_same_processor_as_current: attached {like item} v as l_v
			v_parent_void: l_v.parent = Void
			v_not_current: v /= Current
			v_not_parent_of_current: not is_parent_recursive (l_v)
			v_containable: may_contain (l_v)
		do
			cell.extend (v)
		end

	put, replace (v: attached like item)
		require
			not_destroyed: not is_destroyed
			writable: writable
			v_not_void: v /= Void
			v_parent_void: v.parent = Void
			v_not_current: v /= Current
			v_not_parent_of_current: not is_parent_recursive (v)
			v_containable: may_contain (v)
		do
			cell.put (v)
		end

feature {NONE} -- Implementation

	cell: EV_CELL
			-- Cell holding the widget. This enables us
			-- to grow and shrink the real item.

	previous_size: TUPLE [width, height: INTEGER]
			-- Previsous minimum size of `item'.

	scrollbar_width: INTEGER
		once
			Result := (create {EV_VERTICAL_SCROLL_BAR}).width
		end

	on_mouse_wheel (a_delta: INTEGER)
			-- Perform scrolling of item when receiving mouse wheel events. By default
			-- vertically first, and then horizontally.
		local
			l_additional_height: INTEGER
			l_offset: INTEGER
		do
			if attached item as l_item then
					-- Vertical scrollbar always take priority
				if is_vertical_scroll_bar_visible then
						-- We have to take into account when the horizontal scrollbar is visible as it forces us
						-- to scroll further down.
					if is_horizontal_scroll_bar_visible then
						l_additional_height := scrollbar_width
					end
						-- Let's compute by how many pixel we are going to scroll at each step
						-- by using a fixed amount or a percentage amount depending on settings.
					if scroll_step > 0 then
						l_offset := scroll_step
					else
						l_offset := height - (height * scroll_percentage) // 100
					end
					set_y_offset ((y_offset - a_delta * l_offset).max (0).min (l_item.minimum_height + l_additional_height + 1 - height))

				elseif is_horizontal_scroll_bar_visible then
						-- As above, let's compute by how many pixel we are going to scroll
						-- at each step by using a fixed amount or a percentage amount
						-- depending on settings.
					if scroll_step > 0 then
						l_offset := scroll_step
					else
						l_offset := width - (width * scroll_percentage) // 100
					end
					set_x_offset ((x_offset - a_delta * l_offset).max (0).min (l_item.minimum_width + 1 - width))
				else
						-- Nothing to be done since scrollbars are hidden.
				end
			end
		end

	on_refresh
			-- Perform a lazy refresh so that when `item' content is changed and its minimum size
			-- is changed, we actually perform an update on the scrollable area.
		local
			l_size: like previous_size
		do
			if attached item as l_item then
				l_size := previous_size
				if l_size.width /= l_item.minimum_width or l_size.height /= l_item.minimum_height then
					previous_size.width := l_item.minimum_width
					previous_size.height := l_item.minimum_height
					on_resize (x_position, y_position, width, height)
				end
			end
		end

	update_scrollbar_visibility (a_horizontal_shown, a_vertical_shown: BOOLEAN)
			-- If `a_horizontal_shown' or `a_vertical_shown' then show the respective scrollbar if not already
			-- else hide if not already.
		local
			l_x_offset, l_y_offset: INTEGER
		do
			if a_horizontal_shown then
				show_horizontal_scroll_bar
				l_x_offset := x_offset
			elseif is_horizontal_scroll_bar_visible then
				hide_horizontal_scroll_bar
			end

			if a_vertical_shown then
				show_vertical_scroll_bar
				l_y_offset := y_offset
			elseif is_vertical_scroll_bar_visible then
				hide_vertical_scroll_bar
			end

				-- Clamp offsets in case item has shrank.
			if attached item as l_item then
				l_x_offset := l_item.minimum_width.min (l_x_offset)
				l_y_offset := l_item.minimum_height.min (l_y_offset)
			end
			set_offset (l_x_offset, l_y_offset)
		end

	on_resize (a_x, a_y, a_width, a_height: INTEGER)
			-- Action to be performed when resizing the scrollable area.
			-- We ensure that the item is always at the top left and that it grows and shrinks
			-- based on the size of the scrollable areas. When the scrollable areas is smaller than
			-- the minimum size of `item' scrollbars will appear.
		local
			l_item_min_width, l_item_min_height: INTEGER
			l_width, l_height: INTEGER
		do
			if attached item as l_item then
				l_item_min_width := l_item.minimum_width
				l_item_min_height := l_item.minimum_height

				if l_item_min_width <= a_width then
					if l_item_min_height <= a_height then
							-- Item is smaller than the available area, we simply resize
							-- it so that we do not see anymore the scrollbars
						update_scrollbar_visibility (False, False)
						cell.set_minimum_size (a_width, a_height)
						set_item_size (a_width, a_height)
					else
							-- Item width fits, but not the height. This mean that
							-- a vertical scrollbar is going to appear and this we need to take that into account.
						l_width := a_width - scrollbar_width
						if l_item_min_width > l_width then
								-- The apparition of the vertical scrollbar forced us to show the horizontal scrollbar as well.
							update_scrollbar_visibility (True, True)
							cell.set_minimum_size (l_item_min_width, l_item_min_height)
							set_item_size (l_item_min_width, l_item_min_height)
						else
							update_scrollbar_visibility (False, True)
							cell.set_minimum_size (l_width, l_item_min_height)
							set_item_size (l_width, l_item_min_height)
						end
					end
				else
					if l_item_min_height <= a_height then
							-- Item height fits, but not the width. This mean that
							-- a horizontal scrollbar is going to appear and thus we need to take that into account.
						l_height := a_height - scrollbar_width
						if l_item_min_height > l_height then
								-- The apparition of the horizontal scrollbar forced us to show the vertical scrollbar as well.
							update_scrollbar_visibility (True, True)
							cell.set_minimum_size (l_item_min_width, l_item_min_height)
							set_item_size (l_item_min_width, l_item_min_height)
						else
							update_scrollbar_visibility (True, False)
							cell.set_minimum_size (l_item_min_width, a_height)
							set_item_size (l_item_min_width, a_height)
						end
					else
							-- Both scrollbars are present
						update_scrollbar_visibility (True, True)
						cell.set_minimum_size (l_item_min_width, l_item_min_height)
						set_item_size (l_item_min_width, l_item_min_height)
					end
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
