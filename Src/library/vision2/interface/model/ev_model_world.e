note
	description: "Figure groups that are the root of a world of figures.%N%
		%May be interpreted by any kind of projection.%N%
		%Examples: may be output to a printer, saved to an XML file,%N%
		%drawn on a drawing area, etc."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MODEL_WORLD

inherit
	EV_MODEL_GROUP
		redefine
			create_interface_objects,
			default_create,
			world,
			full_redraw
		end

create
	default_create

create {EV_MODEL_WORLD}
	list_make,
	make_filled

feature {NONE} -- Initialization

	create_interface_objects
			-- <Precursor>
		do
			background_color := default_colors.White
			Precursor {EV_MODEL_GROUP}
		end

	default_create
			-- Create with a white background.
		do
			Precursor {EV_MODEL_GROUP}
			grid_x := default_grid_x
			grid_y := default_grid_x
			grid_visible := False
			is_anti_aliasing_enabled := True
			full_redraw
		end

feature -- Access

	background_color: EV_COLOR
			-- Color used to clear drawing device.
			-- Default: White.

	points_visible: BOOLEAN
			-- Are all points in world visible?
			-- Used for debugging purposes.
			-- Default: False.

	capture_figure: detachable EV_MODEL
			-- Figure that has mouse capture.

	grid_enabled: BOOLEAN
			-- Should all move handles in world snap to grid?
			-- Default: False.

	grid_visible: BOOLEAN
			-- Display visual representation of  grid?
			-- Default: True.

	default_grid_x: INTEGER = 10
			-- Default horizontal step of grid.

	default_grid_y: INTEGER = 10
			-- Default vertical step of grid.

	grid_x: INTEGER
			-- Horizontal step of grid.
			-- Default: `Default_grid_x'.

	grid_y: INTEGER
			-- Vertical step of grid.
			-- Default: `Default_grid_x'.

	world: EV_MODEL_WORLD
			-- `Current' object.
		do
			Result := Current
		end

	x_to_grid (a_x: INTEGER): INTEGER
			-- Nearest point on grid to `a_x'.
		local
			half_grid, grid: INTEGER
		do
			grid := grid_x
			half_grid := grid // 2
			Result := ((a_x + half_grid) // grid) * grid
		end

	y_to_grid (a_y: INTEGER): INTEGER
			-- Nearest point on grid to absolute `a_y'.
		local
			half_grid, grid: INTEGER
		do
			grid := grid_y
			half_grid := grid // 2
			Result := ((a_y + half_grid) // grid) * grid
		end

	is_anti_aliasing_enabled: BOOLEAN
			-- Should anti-aliasing be used when drawing pictures?

feature -- Status report

	is_redraw_needed: BOOLEAN
			-- Does entire area need to be redrawn?
			-- This is the case when a figure is added or removed.

feature -- Status setting

	show_points
			-- Set `points_visible' to `True'.
		do
			points_visible := True
		ensure
			points_visible: points_visible
		end

	hide_points
			-- Set `points_visible' to `False'.
		do
			points_visible := False
		ensure
			not_points_visible: not points_visible
		end

	show_grid
			-- Set `grid_visible' to `True'.
		do
			grid_visible := True
		ensure
			grid_visible: grid_visible
		end

	hide_grid
			-- Set `grid_visible' to `False'.
		do
			grid_visible := False
		ensure
			not_grid_visible: not grid_visible
		end

	enable_grid
			-- Set `grid_enabled' `True'.
		do
			grid_enabled := True
		ensure
			grid_enabled: grid_enabled
		end

	disable_grid
			-- Set `grid_enabled' `False'.
		do
			grid_enabled := False
		ensure
			grid_disabled: not grid_enabled
		end

	enable_anti_aliasing
			-- Set `is_anti_aliasing_enabled` to `True`.
		do
			is_anti_aliasing_enabled := True
		ensure
			anti_aliasing_enabled: is_anti_aliasing_enabled
		end

	disable_anti_aliasing
			-- Set `is_anti_aliasing_enabled` to `False`.
		do
			is_anti_aliasing_enabled := False
		ensure
			anti_aliasing_disabled: not is_anti_aliasing_enabled
		end

	full_redraw
			-- On next projection, mark entire area as invalid.
		do
			is_redraw_needed := True
		end

feature -- Element change

	set_background_color (a_color: EV_COLOR)
			-- Assign `a_color' to `background_color'.
		require
			a_color_not_void: a_color /= Void
		do
			background_color := a_color
		ensure
			assigned: background_color = a_color
		end

	set_capture_figure (a_figure: EV_MODEL)
			-- Set `capture_figure' to `a_figure'.
		require
			a_figure_not_void: a_figure /= Void
		do
			capture_figure := a_figure
		ensure
			assigned: capture_figure = a_figure
		end

	remove_capture_figure
			-- Set `capture_figure' to `Void'.
		require
			capture_figure_not_void: capture_figure /= Void
		do
			capture_figure := Void
		ensure
			removed: capture_figure = Void
		end

	set_grid_x (new_grid_x: INTEGER)
			-- Assign `new_grid_x' to `grid_x'.
		require
			new_grid_x_positive: new_grid_x > 0
		do
			grid_x := new_grid_x
		ensure
			assigned: grid_x = new_grid_x
		end

	set_grid_y (new_grid_y: INTEGER)
			-- Assign `new_grid_y' to `grid_y'.
		require
			new_grid_y_positive: new_grid_y > 0
		do
			grid_y := new_grid_y
		ensure
			assigned: grid_y = new_grid_y
		end

feature {EV_MODEL_PROJECTOR, EV_MODEL} -- Access

	full_redraw_performed
			-- Redraw is not needed anymore.
		do
			is_redraw_needed := False
		end

invariant
	background_color_exists: background_color /= Void

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
