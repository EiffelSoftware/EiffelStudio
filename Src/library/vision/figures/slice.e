
-- SLICE: Description of slice.

indexing
	status: "See notice at end of class"

class SLICE 

inherit

	ELLIPSE
		rename 	
			make as ell_make
		redefine
			draw, is_surimposable
		end;

	ANGLE_ROUT
		export
			{NONE} all
		end;

	ARC_FILLABLE

creation

	make

feature -- Initialization

	make is
			-- Create a slice.
		do
			ell_make ;
			angle1 := 0;
			angle2 := 360;
		end;

feature -- Access 

	angle1: REAL;
			-- Angle which specifies start position of
			-- current arc relative to the orientation

	angle2: REAL;
			-- Angle which specifies end position of
			-- current arc relative to the start of
			-- current arc

feature -- Modification & Insertion

	set_angle1 (an_angle: like angle1) is
			-- Set angle1 to `an_angle'._
		require
			angle1_smaller_than_360: an_angle < 360;
			angle1_positive: an_angle >= 0
		do
			angle1 := an_angle;
			set_conf_modified
		ensure
			angle1 = an_angle
		end;

	set_angle2 (an_angle: like angle2) is
			-- Set angle2 to `an_angle'.
		require
			angle2_smaller_than_360: an_angle <= 360;
			angle2_positive: an_angle >= 0
		do
			angle2 := an_angle;
			set_conf_modified
		ensure
			angle2 = an_angle
		end;


feature -- Output

		draw is
			-- Draw the slice.
		do
			if drawing.is_drawable then
				if not (interior = Void) then
					interior.set_drawing_attributes (drawing);
					drawing.fill_arc (center, radius1, radius2, angle1, angle2, orientation, arc_style)
				end;
				if not (path = Void) then
					path.set_drawing_attributes (drawing);
					drawing.draw_arc (center, radius1, radius2, angle1, angle2, orientation, arc_style)
				end
			end
		end;

feature -- Status report

	is_surimposable (other: like Current): BOOLEAN is
			-- Is the current slice surimposable to `other' ?
			--| not finished
		require else
			other_exists: not (other = Void)
		do
			Result := center.is_surimposable (other.center) and (radius1 = other.radius1) and (radius2 = other.radius2) and (orientation = other.orientation) and (angle1 = other.angle1) and (angle2 = other.angle2)
		end;


invariant

	angle1 < 360;
	angle1 >= 0;
	angle2 <= 360;
	angle2 >= 0;
	angle2 /= angle1

end -- class SLICE


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
