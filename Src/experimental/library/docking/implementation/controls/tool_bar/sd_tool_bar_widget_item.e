note
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

	make (a_widget: EV_WIDGET)
			-- Creation method
		require
			not_void: a_widget /= Void
			parent_void: a_widget.parent = Void
		do
			widget := a_widget
			description := "Widget item"
			name := generating_type.name_32
			pixmap := (create {SD_SHARED}).icons.tool_bar_widget_item_icon
			is_displayed := True
		ensure
			set: widget = a_widget
		end

feature -- Query

	has_rectangle (a_rect: EV_RECTANGLE): BOOLEAN
			-- <Precursor>
		do
			Result := a_rect.intersects (rectangle)
		end

	has_position (a_relative_x, a_relative_y: INTEGER): BOOLEAN
			-- If `a_relative_x' and `a_relative_y' in Current?
			-- FIXME: same as {SD_TOOL_BAR_BUTTON}.has_position, merge?
		require
			setted: tool_bar /= Void
		local
			l_rect: EV_RECTANGLE
		do
			l_rect := rectangle
			l_rect.grow_right (-1)
			l_rect.grow_bottom (-1)
			Result := l_rect.has_x_y (a_relative_x, a_relative_y)
		end

	tooltip: detachable STRING_32
			-- Tooltip of inner widget
			-- Maybe void
		do
			if attached {EV_TOOLTIPABLE} widget as l_tooltipable then
				Result := l_tooltipable.tooltip
			end
		end

	width: INTEGER
			-- <Precursor>
		do
			Result := widget.minimum_width
		end

	widget: EV_WIDGET
			-- Widget which Current represent.

feature -- Command

	replace_widget (a_widget: EV_WIDGET)
			-- Replace `widget' with `a_widget'.
			-- Updated parent container if possible
			-- In this way, we can fix mini tool bar resize problem.
			-- The problem happens usually after `widget' actual size changed,
			-- but in the UI, `widget' size not updated.			
		require
			not_void: a_widget /= Void
			not_destroyed: not a_widget.is_destroyed
		local
			l_old_widget: like a_widget
		do
			l_old_widget := widget
			widget := a_widget

			if attached {EV_FIXED} l_old_widget.parent as l_fixed then
				check must_has: l_fixed.has (l_old_widget) end
				l_fixed.prune (l_old_widget)
				l_fixed.extend (a_widget)
			else
				check parent_must_be_ev_fixed: False end
			end
		ensure
			set: widget = a_widget
		end

	update_parent_tool_bar_size
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

	on_pointer_motion (a_relative_x, a_relative_y: INTEGER)
			-- Do nothing
		do
		end

	on_pointer_motion_for_tooltip (a_relative_x, a_relative_y: INTEGER)
			-- <Precursor>
			-- FIXME: same as {SD_TOOL_BAR_BUTTON}, merge ?
		local
			l_tool_bar: like tool_bar
			l_tooltip: like tooltip
		do
			-- Tool bar maybe void when CPU is busy on GTK.
			-- See bug#13102.
			l_tool_bar := tool_bar
			if l_tool_bar /= Void then
				if has_position (a_relative_x, a_relative_y) then
					l_tooltip := tooltip
					if l_tooltip /= Void and then (not (l_tooltip.same_string (l_tool_bar.tooltip))) then
						l_tool_bar.set_tooltip (l_tooltip)
					elseif l_tooltip = Void then
						l_tool_bar.remove_tooltip
					end
				end
			end
		end

	on_pointer_press (a_relative_x, a_relative_y: INTEGER)
			-- Do nothing
		do
		end

	on_pointer_release (a_relative_x, a_relative_y: INTEGER)
			-- Do nothing
		do
		end

	on_pointer_leave
			-- Do nothing
		do
		end

	on_pointer_press_forwarding (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Do nothing
		do
		end

feature {NONE} -- Implementation

	update_for_pick_and_drop (a_starting: BOOLEAN; a_pebble: detachable ANY)
			-- Do nothing
		do
		end

invariant

	widget_not_void: widget /= Void

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
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
