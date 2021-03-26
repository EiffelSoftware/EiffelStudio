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
			check_figure_size := 13 -- Default value
			update_check_figure_size
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
			Result := Precursor + attached_interface.check_figure_size + attached_interface.spacing
		end

feature {EV_GRID_CHECKABLE_LABEL_ITEM} -- Access

	check_figure_size: INTEGER
			-- The width/height of the check box.

	update_check_figure_size
			-- Update the `check_figure_size`
		local
			ft: EV_FONT
		do
			if attached interface as l_interface then
				ft := l_interface.font
			end
			if ft = Void then
				ft := internal_default_font
			end
			check_figure_size := ft.string_width (once "__")
		end

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
			l_start_x, l_start_y: INTEGER
			l_old_lw, lw: INTEGER
			l_check_figure_size: INTEGER
		do
				-- Calculate when the checkbox should be drawn.
			l_start_x := a_layout.checkbox_x + an_indent
			l_start_y := a_layout.checkbox_y
			l_check_figure_size := attached_interface.check_figure_size
			l_old_lw := a_drawable.line_width
			lw := {EV_GRID_CHECKABLE_LABEL_ITEM}.check_figure_line_width
			a_drawable.set_line_width (lw)
			a_drawable.draw_rectangle (l_start_x, l_start_y, l_check_figure_size, l_check_figure_size)
			a_drawable.draw_rectangle (l_start_x + 1, l_start_y + 1, l_check_figure_size - 2, l_check_figure_size - 2)
			if attached_interface.is_checked then
				l_start_x := l_start_x + 3 * lw
				l_start_y := l_start_y + 2 * lw
				draw_check_sign_at (a_drawable, l_check_figure_size - 7 * lw, l_start_x, l_start_y)
			end
				-- Restore the line width.
			a_drawable.set_line_width (l_old_lw)
		end

	draw_check_sign_at (a_drawable: EV_DRAWABLE; a_size: INTEGER; a_start_x, a_start_y: INTEGER)
			-- Draw the check sign, with size `a_size` at position (a_start_x, a_start_y) on `a_drawable`.
		local
			l_check_figure: ARRAY [EV_COORDINATE]
			x1,x2,x3,y1,y2,y3,y4: INTEGER
		do
			x1 := 1
			x2 := (a_size * 0.4).rounded
			x3 := a_size
			y1 := 1
			y2 := (a_size * 0.33).rounded
			y3 := (a_size * 0.66).rounded
			y4 := a_size

			create l_check_figure.make_filled (create {EV_COORDINATE}.make (a_start_x + x1, a_start_y + y2), 1, 6)
			l_check_figure[2] := create {EV_COORDINATE}.make (a_start_x + x2, a_start_y + y3)
			l_check_figure[3] := create {EV_COORDINATE}.make (a_start_x + x3, a_start_y + y1)
			l_check_figure[4] := create {EV_COORDINATE}.make (a_start_x + x3, a_start_y + y2)
			l_check_figure[5] := create {EV_COORDINATE}.make (a_start_x + x2, a_start_y + y4)
			l_check_figure[6] := create {EV_COORDINATE}.make (a_start_x + x1, a_start_y + y3)

			a_drawable.fill_polygon (l_check_figure)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_GRID_CHECKABLE_LABEL_ITEM note option: stable attribute end;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
