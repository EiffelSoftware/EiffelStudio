indexing
	description: "A menu container that is a row when at top/bottom or column at left/right menu area. It contain SD_MENU_ZONE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_MENU_ROW

inherit
	EV_FIXED
		rename
			extend as extend_fixed,
			set_item_position as set_item_position_fixed
		end

create
	make

feature {NONE} -- Initialization

	make (a_vertical: BOOLEAN) is
			-- Creation method
		do
			default_create
			is_vertical := a_vertical
		ensure
			set: is_vertical = a_vertical
		end

feature -- Basic operation

	extend (a_menu: SD_MENU_ZONE) is
			-- Extend `a_menu'.
		require
			a_menu_not_void: a_menu /= Void
		do
			if a_menu.is_vertical /= is_vertical then
				a_menu.change_direction
			end
			extend_fixed (a_menu)

			if is_vertical then
				if a_menu.minimum_width > {SD_SHARED}.menu_size then
					a_menu.set_minimum_width ({SD_SHARED}.menu_size)
				end
				set_item_width (a_menu, {SD_SHARED}.menu_size)
			else
				if a_menu.minimum_height > {SD_SHARED}.menu_size then
					a_menu.set_minimum_height ({SD_SHARED}.menu_size)
				end
				set_item_height (a_menu, {SD_SHARED}.menu_size)
			end

			set_item_position_fixed (a_menu, 0, 0)
			a_menu.set_row (Current)
		ensure
			extended: has (a_menu)
			direction_changed: a_menu.is_vertical = is_vertical
			menu_row_set: a_menu.row = Current
		end

	set_item_position (a_widget: EV_WIDGET; a_screen_x_y: INTEGER) is
			-- Set `a_widget' position with screen position.
		require
			a_widget_not_void: a_widget /= Void
		local
			l_x_y: INTEGER
		do
			if not is_vertical then
				l_x_y := a_screen_x_y - screen_x
			else
				l_x_y := a_screen_x_y - screen_y
			end
			set_item_position_relative (a_widget, l_x_y)
		ensure
			set: is_vertical implies a_widget.y_position =  a_screen_x_y - screen_y
			set: not is_vertical implies a_widget.x_position =  a_screen_x_y - screen_x
		end

	set_item_position_relative (a_widget: EV_WIDGET; a_relative_x_y: INTEGER) is
			-- Set `a_widget' position with relative position.
		require
			a_widget_not_void: a_widget /= Void
		do
			if not is_vertical then
				set_item_x_position (a_widget, a_relative_x_y)
			else
				set_item_y_position (a_widget, a_relative_x_y)
			end
		ensure
			set: is_vertical implies a_widget.y_position = a_relative_x_y
			set: not is_vertical implies a_widget.x_position = a_relative_x_y
		end

	apply_change is
			-- Handle user stopped dragging.
		do
			internal_item_positions_except_current := Void
		end

	start_drag (a_dragged_item: EV_WIDGET) is
			-- Handle user start dragging.
		require
			a_dragged_item_not_void: a_dragged_item /= Void
		do
			debug ("docking")
				io.put_string ("%N SD_MENU_ROW start_drag")
			end
			create internal_item_positions_except_current.make (0)
			from
				start
			until
				after
			loop
				if item /= a_dragged_item then
					if not is_vertical then
						internal_item_positions_except_current.extend (item.x_position)
					else
						internal_item_positions_except_current.extend (item.y_position)
					end
				end
				forth
			end
		end

feature -- States report

	has_screen_y (a_screen_y: INTEGER): BOOLEAN is
			-- If a_screen_y in `Current' area?
		do
			Result := a_screen_y >= screen_y and a_screen_y <= (screen_y + height)
		end

	is_vertical: BOOLEAN
			-- If `Current' is_vertical?

feature {NONE} -- Implementation

	set_item_position_horizontal (a_widget: EV_WIDGET; an_x_y: INTEGER) is
			-- Set item position when `Current' is horizontal.
		do
			set_item_x_position (a_widget, an_x_y)
			from
				start
				internal_item_positions_except_current.start
			until
				after
			loop

				if item /= a_widget then
					if internal_item_positions_except_current.item <= a_widget.x_position and internal_item_positions_except_current.item + item.width >= a_widget.x_position then

						if a_widget.x_position > internal_item_positions_except_current.item then
							set_item_x_position (item, a_widget.x_position - item.width)
						end
					elseif internal_item_positions_except_current.item <= a_widget.x_position + a_widget.width and internal_item_positions_except_current.item + item.width >= a_widget.x_position + a_widget.width then
							set_item_x_position (item, a_widget.x_position + a_widget.width)
					else
						if item.x_position /= internal_item_positions_except_current.item then
							set_item_x_position (item, internal_item_positions_except_current.item)
						end
					end
					--#################### Test
					debug ("docking")
						io.put_string ("%N SD_MENU_ROW test " + internal_item_positions_except_current.item.out)
					end
					--#################### Test	
					internal_item_positions_except_current.forth
				end
				forth
			end
		end

	internal_item_positions_except_current: ARRAYED_LIST [INTEGER];
			-- Before drag a meun bar, we should remember all positions of the menu bar.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end
