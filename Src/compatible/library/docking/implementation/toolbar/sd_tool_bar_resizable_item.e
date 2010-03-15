note
	description: "Tool bar item which can resize its width directly at the end."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_RESIZABLE_ITEM

inherit
	SD_TOOL_BAR_WIDGET_ITEM
		redefine
			make,
			width,
			on_pointer_motion,
			on_pointer_press,
			on_pointer_release,
			on_pointer_leave
		end

create
	make

feature {NONE} -- Initlization

	make (a_widget: EV_WIDGET)
			-- Creation method.
		do
			Precursor {SD_TOOL_BAR_WIDGET_ITEM} (a_widget)
		end

feature -- Query

	width: INTEGER
			-- Width
		do
			Result := Precursor + resize_bar_width
		end

feature -- Command

	clear
			-- Clear state flags.
		do
			is_pointer_pressed := False
		end

feature {NONE} -- Implementation

	resize_bar_width: INTEGER = 3
			-- With of the resize bar

	setted: BOOLEAN
			-- If pointer style setted?

	is_pointer_pressed: BOOLEAN
			-- If pointer pressed?

	is_in_main_window: BOOLEAN
			-- If current item in main window?

feature {NONE} -- Agents

	on_pointer_motion (a_relative_x, a_relative_y: INTEGER_32)
			-- Handle pointer motion actions.
		local
			l_stock_pixmaps: EV_STOCK_PIXMAPS
			l_width: INTEGER
			l_widget_tool_bar: SD_WIDGET_TOOL_BAR
			l_max_width: INTEGER
		do
			if not is_pointer_pressed then
				create l_stock_pixmaps
				if rectangle.has_x_y (a_relative_x, a_relative_y) then
					tool_bar.set_pointer_style (l_stock_pixmaps.sizewe_cursor)
					setted := True
				elseif setted then
					tool_bar.set_pointer_style (l_stock_pixmaps.standard_cursor)
					setted := False
				end
			else
				l_width := a_relative_x - tool_bar.item_x (Current)

				if is_in_main_window then
					-- When tool bar item in main window
					l_widget_tool_bar ?= tool_bar
					if l_widget_tool_bar /= Void then
						-- If `l_width' will pass the end of row?
						l_max_width := l_widget_tool_bar.screen_x_end_row + width - tool_bar.screen_x - tool_bar.width
						if  l_width <= l_max_width - resize_bar_width then
						else
							l_width := l_max_width - resize_bar_width
						end
					end
				else
					-- When item in floating zone or customized dialog.
				end

				if l_width < 0 then
					l_width := 0
				end
				widget.set_minimum_width (l_width)

				-- We need to update item width.
				tool_bar.update_size
				tool_bar.update

				if l_widget_tool_bar /= Void then
					l_widget_tool_bar.resize_for_sizeble_item
				end
			end
		end

	on_pointer_leave
			-- Handle pointer leave actions.
		local
			l_stock_pixmaps: EV_STOCK_PIXMAPS
		do
		 	if setted then
				create l_stock_pixmaps
				tool_bar.set_pointer_style (l_stock_pixmaps.standard_cursor)
				setted := False
		 	end
		end

	on_pointer_press (a_relative_x, a_relative_y: INTEGER_32)
			-- Handle pointer press actions.
		local
			l_widget_tool_bar: SD_WIDGET_TOOL_BAR
		do
			if rectangle.has_x_y (a_relative_x, a_relative_y) then
				tool_bar.enable_capture
				is_pointer_pressed := True

				-- When tool bar item in main window
				l_widget_tool_bar ?= tool_bar
				check not_void: l_widget_tool_bar /= Void end
				if l_widget_tool_bar /= Void then
					is_in_main_window := l_widget_tool_bar.in_main_window
				end
			end
		end

	on_pointer_release (a_relative_x, a_relative_y: INTEGER_32)
			-- Handle pointer release actions.
		do
			is_pointer_pressed := False
			-- Tool bar may be already void, such as we popup a new dialog in pointer press actions.
			-- This action cause parent SD_TOOL_BAR destroyed if current stays in tool bar option dialog which
			-- destroyed by focus out actions.			
			-- See bug#13195.
			if tool_bar /= Void then
				tool_bar.disable_capture
			end
		end

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
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
