note
	description: "[
		The Cell is similar to EV_GRID_LABEL_ITEM, except it has extra ellipsis on the right
		See description of EV_GRID_LABEL_ITEM for more details
	 	Implementation Interface.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_LABEL_ELLIPSIS_ITEM_I

inherit
	EV_GRID_LABEL_ITEM_I
		redefine
			interface,
			recompute_text_dimensions,
			required_width,
			draw_additional
		end

create
	make

feature {EV_GRID_LABEL_ITEM} -- Status Report

	required_width: INTEGER
			-- Width in pixels required to fully display contents, based
			-- on current settings.
		do
			Result := Precursor + ellipsis_width
		end

	ellipsis_width: INTEGER

	ellipsis_height: INTEGER

	ellipsis_bullet_size: INTEGER

feature {EV_GRID_DRAWER_I} -- Implementation

	recompute_text_dimensions
		local
			ft: EV_FONT
			l_spacing: INTEGER
		do
			Precursor
			if attached interface as l_interface then
				ft := l_interface.font
				l_spacing := l_interface.spacing
				ellipsis_height := ft.height_in_points
				ellipsis_bullet_size := ft.string_width (".")
			else
				ellipsis_height := 8
				ellipsis_bullet_size := 2
				l_spacing := 2
			end
			ellipsis_width := 3 * ellipsis_bullet_size + 3 * l_spacing -- [# # # ]
		end

feature {EV_GRID_LABEL_ELLIPSIS_ITEM} -- Internal events

	on_pointer_button_pressed (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
		do
			if
				attached interface as l_interface and then
				attached l_interface.computed_initial_grid_label_item_layout (width, height) as lay
			then
				if a_x > lay.text_x + lay.available_text_width then
					l_interface.ellipsis_actions.call (Void)
				end
			end
		end

feature {NONE} -- Implementation

	call_ellipsis_actions
			-- Call ellipsis_actions
		do
			if attached interface as interf then
				interf.ellipsis_actions.call (Void)
			end
		end

	draw_additional (a_drawable: EV_DRAWABLE; a_layout: EV_GRID_LABEL_ITEM_LAYOUT; an_indent: INTEGER_32)
			-- Draw additional pixmaps on the right of label.
		local
			l_start_x, l_start_y: INTEGER
			l_spacing: INTEGER
		do
			if
				attached interface as l_interface
			then
				l_spacing := l_interface.spacing
					-- By default we start displaying pixmaps after the end of the
					-- space allotted for `text'.
				l_start_x := a_layout.text_x + a_layout.available_text_width + l_spacing + an_indent
					-- We calculate the position of the ellipsis.
				l_start_y := a_layout.text_y + internal_text_height
				draw_ellipsis (a_drawable, l_start_x, l_start_y, ellipsis_width, ellipsis_height)
			end
		end

	draw_ellipsis (a_drawable: EV_DRAWABLE; a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER)
		local
			l_bullet_size: INTEGER
			l_step: INTEGER
			l_y: INTEGER
			fg: EV_COLOR
		do
			l_bullet_size := ellipsis_bullet_size

			fg := a_drawable.foreground_color.twin

			a_drawable.set_line_width (1)
			l_step := (a_width - 3 * l_bullet_size) // 3 --  [# # # ] (3 spaces)
			l_y := a_y - a_height-- // 3

				-- Draw an ellipsis.
			a_drawable.fill_rectangle (a_x + 0, l_y, l_bullet_size, l_bullet_size)
			a_drawable.fill_rectangle (a_x + (l_step + l_bullet_size), l_y, l_bullet_size, l_bullet_size)
			a_drawable.fill_rectangle (a_x + 2 * (l_step + l_bullet_size), l_y, l_bullet_size, l_bullet_size)

			a_drawable.set_foreground_color (fg)
		end

	colors: EV_STOCK_COLORS
		once
			create Result
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_GRID_LABEL_ELLIPSIS_ITEM note option: stable attribute end
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
