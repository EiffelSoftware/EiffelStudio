indexing
	description: "EiffelVision slice figure."
	status: "See notice at end of class"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SLICE

inherit
	EV_ELLIPSE
		redefine
			make,
			draw,
			is_superimposable
		end

	MATH_CONST
		export
			{ANY} Pi
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Create a slice.
		do
			Precursor
			create angle1.make (0)
			create angle2.make (Pi * 2)
		end

feature -- Access

	angle1: EV_ANGLE
			-- Angle which specifies start position of
			-- current arc relative to the orientation

	angle2: EV_ANGLE
			-- Angle which specifies end position of
			-- current arc relative to the start of
			-- current arc

feature -- Element change

	set_angle1 (an_angle: like angle1) is
			-- Set angle1 to `an_angle'._
		do
			angle1 := an_angle
			set_modified
		ensure
			angle1 = an_angle
		end

	set_angle2 (an_angle: like angle2) is
			-- Set angle2 to `an_angle'.
		require
			valid_angle: an_angle.radians <= Pi * 2
		do
			angle2 := an_angle
			set_modified
		ensure
			angle2 = an_angle
		end


feature -- Output

	draw is
			-- Draw the slice.
		local
			lint: EV_INTERIOR
			lpath: EV_PATH
		do
			if drawing.is_drawable then
				if interior /= Void then
					create lint.make
					lint.get_drawing_attributes (drawing)
					interior.set_drawing_attributes (drawing)
					drawing.fill_arc (center, radius1, radius2, angle1, angle2, orientation, arc_style)
					lint.set_drawing_attributes (drawing)
				end
				if path /= Void then
					create lpath.make
					lpath.get_drawing_attributes (drawing)
					path.set_drawing_attributes (drawing)
					drawing.draw_arc (center, radius1, radius2, angle1, angle2, orientation, arc_style)
					lpath.set_drawing_attributes (drawing)
				end
			end
		end

feature -- Status setting

	set_chord_arc is
			-- Specifies that the arc and the single line segment joining the
			-- endpoints of the arc create a closed figure.
		do
			arc_style := ArcChord
		end

	set_pieslice_arc is
			-- Specifies that the arc and the two line segments joining the
			-- endpoints of the arc with the center point create a closed
			-- figure.
		do
			arc_style := ArcPieSlice
		end

feature -- Status report

	is_chord_arc: BOOLEAN is
			-- Do the arc and the single line segment joining the endpoints
			-- of the arc create a closed figure ?
		do
			Result := arc_style = ArcChord
		end

	is_pieslice_arc: BOOLEAN is
			-- Do the arc and the two line segments joining the endpoints of
			-- the arc with the center point create a closed figure ?
		do
			Result := arc_style = ArcPieSlice
		end

	is_superimposable (other: like Current): BOOLEAN is
			-- Is the current slice superimposable to `other' ?
			--! not finished
		require else
			other_exists: other /= Void
		do
			Result := center.is_superimposable (other.center) and 
				(radius1 = other.radius1) and (radius2 = other.radius2) and
				(orientation = other.orientation) and (angle1 = other.angle1)
				and (angle2 = other.angle2)
		end

feature {NONE} -- Access

	arc_style: INTEGER
			-- How to fill an arc ?

	ArcChord: INTEGER is 0
			-- Code to define join endpoints of arc

	ArcPieSlice: INTEGER is 1
			-- Code to define join endpoints to center of arc

invariant
	angles_not_equal: angle2 /= angle1

end -- class EV_SLICE

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--!----------------------------------------------------------------

