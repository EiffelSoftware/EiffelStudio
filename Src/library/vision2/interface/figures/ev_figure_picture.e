indexing
	description:
		"Pixmaps drawn on `point'."
	status: "See notice at end of class"
	keywords: "figure, picture, pixmap"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_PICTURE

inherit
	EV_ATOMIC_FIGURE
		redefine
			default_create
		end

	EV_SINGLE_POINTED_FIGURE
		undefine
			default_create
		end

create
	default_create,
	make_with_point,
	make_with_pixmap

feature {NONE} -- Initialization

	default_create is
			-- Create in (0, 0)
		do
			Precursor {EV_ATOMIC_FIGURE}
			pixmap := default_pixmap
			is_default_pixmap_used := True
		end

	make_with_pixmap (a_pixmap: EV_PIXMAP) is
			-- Create with `a_pixmap'.
		require
			a_pixmap_not_void: a_pixmap /= Void
		do
			default_create
			set_pixmap (a_pixmap)
		end

feature -- Access

	pixmap: EV_PIXMAP
			-- Ppixmap that is displayed.

feature -- Status report

	width: INTEGER is
			-- Width of pixmap.
		do
			Result := pixmap.width
		ensure
			assigned: Result = pixmap.width
		end

	height: INTEGER is
			-- Height of Pixmap.
		do
			Result := pixmap.height
		ensure
			assigned: Result = pixmap.height
		end


	is_default_pixmap_used: BOOLEAN
			-- Is `Current' using a default pixmap?

feature -- Status setting

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Set `pixmap' to `a_pixmap'.
		require
			a_pixmap_not_void: a_pixmap /= Void
		do
			pixmap := a_pixmap
			is_default_pixmap_used := False
			invalidate
		ensure
			pixmap_assigned: pixmap = a_pixmap
		end

feature -- Events

	position_on_figure (x, y: INTEGER): BOOLEAN is
			-- Is (`x', `y') on this figure?
		local
			ax, ay: INTEGER
		do
			ax := point.x_abs
			ay := point.y_abs
			Result := point_on_rectangle (x, y, ax, ay, ax + width, ay + height)
		end

	Default_pixmap: EV_PIXMAP is
			-- Pixmap set by `default_create'.
		once
			create Result
		end

invariant
	pixmap_exists: pixmap /= Void

end -- class EV_FIGURE_PICTURE

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------
