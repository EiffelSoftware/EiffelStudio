indexing

	description: "Ended figures (segment, arc,...)";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class ENDED 


feature -- Element change

	set_butt_cap is
			-- Specifies that lines will be square at the endpoint with no
			-- projection beyound. The end is perpendicular to the slope of
			-- the line.
		do
			cap_style := CapButt
		end;

	set_notlast_cap is
			-- Is equivalent to CapButt, except that for a `line_width' of 0
			-- or 1, the final endpoint is not drawn.
		do
			cap_style := CapNotLast
		end;

	set_projecting_cap is
			-- Specifies that lines will be square at the end but with the path
			-- continuouing beyond the endpoint for a distance equal to half
			-- the `line_width'.
			-- equivalent to CapButt for `line_width' of 0 or 1.
		do
			cap_style := CapProjecting
		end;

	set_round_cap is
			-- Specifies that lines will be terminated by a circular arc with
			-- the diameter equal to the `line_width', centered at the endpoint.
			-- equivalent to CapButt for `line_width' of 0 or 1.
		do
			cap_style := CapRound
		end


feature -- Status report 

	is_butt_cap: BOOLEAN is
			-- Is lines square at the endpoint with no projection beyond ?
		do
			Result := cap_style = CapButt
		end;

	is_notlast_cap: BOOLEAN is
			-- Is equivalent to `is_butt_cap', except that for a
			-- line_width of 0 or 1, the final endpoint is not drawn ?
		do
			Result := cap_style = CapNotLast
		end;

	is_projecting_cap: BOOLEAN is
			-- Are lines square at the end but with the path continuouing
			-- the endpoint for a distance equal to half the `line_width' ?
		do
			Result := cap_style = CapProjecting
		end;

	is_round_cap: BOOLEAN is
			-- Are lines terminated by a circular arc with the diameter equal
			-- to the `line_width', centered at the endpoint.
		do
			Result := cap_style = CapRound
		end;

feature {NONE} -- Access

	cap_style: INTEGER;
			-- How the endpoints of lines are drawn.

	CapButt: INTEGER is 1;
			-- Code to define butt cap

	CapNotLast: INTEGER is 0;
			-- Code to define not last cap

	CapProjecting: INTEGER is 3;
			-- Code to define projecting cap

	CapRound: INTEGER is 2;
			-- Code to define round cap

end -- class ENDED



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

