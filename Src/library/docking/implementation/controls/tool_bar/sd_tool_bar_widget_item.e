indexing
	description: "[
						Widget item on SD_TOOL_BAR.
						Actually it's a place holder for a EV_WIDGET object.
																			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			l_shared: SD_SHARED
		do
			widget := a_widget
			description := "Widget item"
			name := generating_type
			create l_shared
			pixmap := l_shared.icons.tool_bar_widget_item_icon
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

feature -- Command

	update_parent_tool_bar_size is
			-- If `widget' size changed, client programmers should call this feature
			-- to update parent tool bar's size.
		local
			l_tool_bar: like tool_bar
		do
			l_tool_bar := tool_bar
			if l_tool_bar /= Void then
				l_tool_bar.compute_minimum_size
			end
		end

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

	on_pointer_press_forwarding (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Do nothing.
		do
		end

feature {NONE} -- Implementation

	update_for_pick_and_drop (a_starting: BOOLEAN; a_pebble: ANY) is
			-- Do nothing.
		do
		end

invariant

	widget_not_void: widget /= Void

indexing
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
