indexing

	description: "Fillable arc (slice,...)";
	status: "See notice at end of class";
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

	ArcPieSlice: INTEGER is 1;
			-- Code to define join endpoints to center of arc

end -- class ARC_FILLABLE

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

