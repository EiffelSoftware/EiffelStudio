indexing

	description: "Description of slice";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	SLICE 

inherit

	ELLIPSE
		rename 	
			make as ell_make
		redefine
			draw, is_superimposable
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

feature -- Element change

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
				if interior /= Void then
					interior.set_drawing_attributes (drawing);
					drawing.fill_arc (center, radius1, radius2, angle1, angle2, orientation, arc_style)
				end;
				if path /= Void then
					path.set_drawing_attributes (drawing);
					drawing.draw_arc (center, radius1, radius2, angle1, angle2, orientation, arc_style)
				end
			end
		end;

feature -- Status report

	is_superimposable (other: like Current): BOOLEAN is
			-- Is the current slice superimposable to `other' ?
			--| not finished
		require else
			other_exists: other /= Void
		do
			Result := center.is_superimposable (other.center) and 
				(radius1 = other.radius1) and (radius2 = other.radius2) and
				(orientation = other.orientation) and (angle1 = other.angle1)
				and (angle2 = other.angle2)
		end;

invariant

	angle1_small_enough: angle1 < 360;
	angle1_large_enough: angle1 >= 0;
	angle2_small_enough: angle2 <= 360;
	angle2_large_enough: angle2 >= 0;
	angles_not_equal: angle2 /= angle1

end -- class SLICE


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

