indexing
	description: "[
						Widget item on SD_TOOL_BAR.
						Actually it's a place holder for a EV_WIDGET object.
																			]"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_WIDGET_ITEM

inherit
	SD_TOOL_BAR_ITEM

create
	make

feature {NONE} -- Initlization

	make (a_widget: EV_WIDGET) is
			-- Creation method.
		require
			not_void: a_widget /= Void
			parent_void: a_widget.parent = Void
		local
			l_pixmaps: EV_STOCK_PIXMAPS
		do
			widget := a_widget
			description := "Widget item"
			create l_pixmaps
			pixmap := l_pixmaps.default_window_icon
			is_displayed := True
		ensure
			set: widget = a_widget
		end

feature -- Query

	has_rectangle (a_rect: EV_RECTANGLE): BOOLEAN is
			-- Redefine
		do
			Result := a_rect.intersects (rectangle)
		end

	width: INTEGER is
			-- Redefine
		do
			Result := widget.minimum_width
		end

	widget: EV_WIDGET
			-- Widget which Current represent.

feature -- Agents

	on_pointer_motion (a_relative_x, a_relative_y: INTEGER) is
			-- Do nothing.
		do
		end

	on_pointer_motion_for_tooltip (a_relative_x, a_relative_y: INTEGER) is
			-- Do nothing.
		do
		end

	on_pointer_press (a_relative_x, a_relative_y: INTEGER) is
			-- Do nothing.
		do
		end

	on_pointer_release (a_relative_x, a_relative_y: INTEGER) is
			-- Do nothing.
		do
		end

	on_pointer_leave is
			-- Do nothing.
		do
		end

feature {NONE} -- Implementation

	update_for_pick_and_drop (a_starting: BOOLEAN; a_pebble: ANY) is
			-- Do nothing.
		do
		end

end
