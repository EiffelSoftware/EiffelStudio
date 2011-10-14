note
	description: "Cell consisting of only of a checkbox, a optional pixmap and text label. Implementation Interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_CHECKABLE_LABEL_ITEM_I

inherit
	EV_GRID_LABEL_ITEM_I
		redefine
			make,
			interface,
			required_width,
			draw_additional
		end

create
	make

feature {EV_ANY} -- Initialization

	make
			-- Initialize `Current'.
		do
			Precursor {EV_GRID_LABEL_ITEM_I}
			is_sensitive := True
			create checked_changed_actions
		end

feature {EV_GRID_CHECKABLE_LABEL_ITEM} -- Status

	is_sensitive: BOOLEAN
			-- Is current sensitive ?

feature {EV_GRID_CHECKABLE_LABEL_ITEM} -- Status setting

	enable_sensitive
			-- Make object sensitive to user input
		require
			not_destroyed: not is_destroyed
		do
			is_sensitive := True
		ensure
			is_sensitive: (not attached parent as l_parent or else  l_parent.is_sensitive) implies is_sensitive
		end

	disable_sensitive
			-- Make object non-sensitive to user input
		require
			not_destroyed: not is_destroyed
		do
			is_sensitive := False
		ensure
			is_unsensitive: not is_sensitive
		end

feature {EV_GRID_LABEL_ITEM} -- Status Report

	required_width: INTEGER
			-- Width in pixels required to fully display contents, based
			-- on current settings.
		do
			Result := Precursor + {EV_GRID_CHECKABLE_LABEL_ITEM}.check_figure_size + attached_interface.spacing
		end

feature {EV_GRID_CHECKABLE_LABEL_ITEM} -- Access

	checked_changed_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [like attached_interface]]
			-- Actions when user checked the item.

	is_checked: BOOLEAN
			-- Is current cell checked ?

	set_is_checked (b: BOOLEAN)
			-- Set Current cell checked if `b' is True
		do
			is_checked := b
			if is_parented and not is_destroyed then
				redraw
			end
			checked_changed_actions.call ([attached_interface])
		end

	toggle_is_checked
			-- Toggle selected status
		do
			set_is_checked (not is_checked)
		end

feature {NONE} -- Implementation

	draw_additional (a_drawable: EV_DRAWABLE; a_layout: EV_GRID_LABEL_ITEM_LAYOUT; an_indent: INTEGER)
			-- Draw the associated checkbox.
		local
			l_data: like section_data
			l_coord: EV_COORDINATE
			l_start_x, l_start_y: INTEGER
			lw: INTEGER
		do
				-- Calculate when the checkbox should be drawn.
			l_start_x := a_layout.checkbox_x + an_indent
			l_start_y := a_layout.checkbox_y
			lw := a_drawable.line_width
			a_drawable.set_line_width ({EV_GRID_CHECKABLE_LABEL_ITEM}.check_figure_line_width)
			a_drawable.draw_rectangle (l_start_x, l_start_y, {EV_GRID_CHECKABLE_LABEL_ITEM}.check_figure_size, {EV_GRID_CHECKABLE_LABEL_ITEM}.check_figure_size)
			a_drawable.draw_rectangle (l_start_x + 1, l_start_y + 1, {EV_GRID_CHECKABLE_LABEL_ITEM}.check_figure_size - 2, {EV_GRID_CHECKABLE_LABEL_ITEM}.check_figure_size - 2)
			if attached_interface.is_checked then
				l_start_x := l_start_x + 1
				l_start_y := l_start_y + 1
				from
					l_data := section_data
					l_data.start
				until
					l_data.after
				loop
					l_coord := l_data.item
					a_drawable.draw_segment (
							l_start_x + l_coord.x, l_start_y + l_coord.y,
							l_start_x + l_coord.x, l_start_y + l_coord.y + 2)
					l_data.forth
				end
			end
				-- Restore the line width.
			a_drawable.set_line_width (lw)
		end

	section_data: ARRAYED_LIST [EV_COORDINATE]
			-- Coordinate used to draw a check
		once
			create Result.make (7)
			Result.extend (create{EV_COORDINATE}.make (2, 4))
			Result.extend (create{EV_COORDINATE}.make (3, 5))
			Result.extend (create{EV_COORDINATE}.make (4, 6))
			Result.extend (create{EV_COORDINATE}.make (5, 5))
			Result.extend (create{EV_COORDINATE}.make (6, 4))
			Result.extend (create{EV_COORDINATE}.make (7, 3))
			Result.extend (create{EV_COORDINATE}.make (8, 2))
		ensure
			result_attached: Result /= Void
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_GRID_CHECKABLE_LABEL_ITEM note option: stable attribute end;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

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

end
