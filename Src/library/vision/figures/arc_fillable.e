--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                      (805) 685-1006                                --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- ARC_FILLABLE: Fillable arc (slice,...).

indexing

	date: "$Date$";
	revision: "$Revision$"

class ARC_FILLABLE 

feature {NONE}

	arc_style: INTEGER;
			-- How to fill an arc ?

	ArcChord: INTEGER is 0;
			-- Code to define join endpoints of arc

	ArcPieSlice: INTEGER is 1;
			-- Code to define join endpoints to center of arc

feature 

	is_chord_arc: BOOLEAN is
			-- Do the arc and the single line segment joining the endpoints
			-- of the arc create a closed figure ?
		do
			Result := arc_style = ArcChord
		end;

	is_pieslice_arc: BOOLEAN is
			-- Do the arc and the two line segments joining the endpoints of
			-- the arc with the center point create a closed figure ?
		do
			Result := arc_style = ArcPieSlice
		end;

	set_chord_arc is
			-- Specifies that the arc and the single line segment joining the
			-- endpoints of the arc create a closed figure.
		do
			arc_style := ArcChord
		end;

	set_pieslice_arc is
			-- Specifies that the arc and the two line segments joining the
			-- endpoints of the arc with the center point create a closed
			-- figure.
		do
			arc_style := ArcPieSlice
		end;

end
