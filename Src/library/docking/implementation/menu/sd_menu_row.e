indexing
	description: "Objects that is a row when at top/bottom or column at left/right."
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
			internal_vertical := a_vertical
		end

feature -- Basic operation

	extend (a_menu: SD_MENU_ZONE) is
			--
		require
			a_menu_not_void: a_menu /= Void
		do

			if a_menu.is_vertical /= internal_vertical then
				a_menu.change_direction

			end
			extend_fixed (a_menu)

			if internal_vertical then
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
		end

	has_screen_y (a_screen_y: INTEGER): BOOLEAN is
			-- If a_screen_y in `Current' area?
		do
			Result := a_screen_y >= screen_y and a_screen_y <= (screen_y + height)
		end

	set_item_position (a_widget: EV_WIDGET; a_screen_x_y: INTEGER) is
			--
		local
			l_x_y: INTEGER
		do
			if not internal_vertical then
				l_x_y := a_screen_x_y - screen_x
			else
				l_x_y := a_screen_x_y - screen_y
			end

			if not internal_vertical then
				set_item_position_horizontal (a_widget, l_x_y)
			else
				set_item_y_position (a_widget, l_x_y)
			end
		end

	set_item_position_relative (a_widget: EV_WIDGET; a_releative_x_y: INTEGER) is
			--
		do
			if not internal_vertical then
				set_item_x_position (a_widget, a_releative_x_y)
			else
				set_item_y_position (a_widget, a_releative_x_y)
			end
		end


	apply_change is
			-- Call when user stopped dragging.
		do
			internal_item_positions_except_current := Void
		end

	start_drag (a_dragged_item: EV_WIDGET) is
			--
		do
			debug ("larry")
				io.put_string ("%N SD_MENU_ROW start_drag")
			end
			create internal_item_positions_except_current.make (0)
			from
				start
			until
				after
			loop
				if item /= a_dragged_item then
					if not internal_vertical then
						internal_item_positions_except_current.extend (item.x_position)
					else
						internal_item_positions_except_current.extend (item.y_position)
					end

				end
				forth
			end
		end

feature -- States report

	is_vertical: BOOLEAN is
			-- If `Current' vertical?
		do
			Result := internal_vertical
		end

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
					debug ("larry")
						io.put_string ("%N SD_MENU_ROW test " + internal_item_positions_except_current.item.out)
					end
					--#################### Test	

					internal_item_positions_except_current.forth


				end

				forth
			end
		end

	internal_item_positions_except_current: ARRAYED_LIST [INTEGER]
			-- Before drag a meun bar, we should remember all positions of the menu bar.

	internal_vertical: BOOLEAN
			-- If `Current' vertical style?

end
