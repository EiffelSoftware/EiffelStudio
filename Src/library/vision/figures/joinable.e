indexing

	description: "Joinable figure (polyline...)";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	JOINABLE

feature -- Element change 

	set_bevel_join is
			-- Specifies CapButt endpoint styles, with the triangular notch
			-- filled.
		do
			join_style := JoinBevel
		end;

	set_miter_join is
			-- Specifies that the outer edges of the two lines would extend to
			-- meet at an angle.
		do
			join_style := JoinMiter
		end;

	set_round_join is
			-- Specifies that lines should be joined by a circular arc with
			-- diameter equal to `line_width', centered on the join point.
		do
			join_style := JoinRound
		end;

feature -- Status report

	is_bevel_join: BOOLEAN is
			-- Is CapButt endpoint styles, with the triangular notch filled ?
		do
			Result := join_style = JoinBevel
		end;

	is_miter_join: BOOLEAN is
			-- Are the outer edges of the two lines would extend to meet at
			-- an angle ?
		do
			Result := join_style = JoinMiter
		end;

	is_round_join: BOOLEAN is
			-- Are lines joined by a circular arc with diameter equal to
			-- `line_width', centered on the join point ?
		do
			Result := join_style = JoinRound
		end;

feature {NONE} -- Access

	join_style: INTEGER;
			-- How corners are drawn for wide lines drawn

	JoinBevel: INTEGER is 2;
			-- Code to define join bevel way

	JoinMiter: INTEGER is 0;
			-- Code to define join miter way

	JoinRound: INTEGER is 1;
			-- Code to define join round way

end -- class JOINABLE



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

