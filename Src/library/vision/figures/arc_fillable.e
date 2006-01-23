indexing

	description: "Fillable arc (slice,...)"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	ARC_FILLABLE

feature -- Status report

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

feature -- Status setting

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

feature {NONE} -- Access

	arc_style: INTEGER;
			-- How to fill an arc ?

	ArcChord: INTEGER is 0;
			-- Code to define join endpoints of arc

	ArcPieSlice: INTEGER is 1;;
			-- Code to define join endpoints to center of arc

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class ARC_FILLABLE

