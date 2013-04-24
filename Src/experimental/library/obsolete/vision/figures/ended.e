note

	description: "Ended figures (segment, arc,...)"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class ENDED 


feature -- Element change

	set_butt_cap
			-- Specifies that lines will be square at the endpoint with no
			-- projection beyound. The end is perpendicular to the slope of
			-- the line.
		do
			cap_style := CapButt
		end;

	set_notlast_cap
			-- Is equivalent to CapButt, except that for a `line_width' of 0
			-- or 1, the final endpoint is not drawn.
		do
			cap_style := CapNotLast
		end;

	set_projecting_cap
			-- Specifies that lines will be square at the end but with the path
			-- continuouing beyond the endpoint for a distance equal to half
			-- the `line_width'.
			-- equivalent to CapButt for `line_width' of 0 or 1.
		do
			cap_style := CapProjecting
		end;

	set_round_cap
			-- Specifies that lines will be terminated by a circular arc with
			-- the diameter equal to the `line_width', centered at the endpoint.
			-- equivalent to CapButt for `line_width' of 0 or 1.
		do
			cap_style := CapRound
		end


feature -- Status report 

	is_butt_cap: BOOLEAN
			-- Is lines square at the endpoint with no projection beyond ?
		do
			Result := cap_style = CapButt
		end;

	is_notlast_cap: BOOLEAN
			-- Is equivalent to `is_butt_cap', except that for a
			-- line_width of 0 or 1, the final endpoint is not drawn ?
		do
			Result := cap_style = CapNotLast
		end;

	is_projecting_cap: BOOLEAN
			-- Are lines square at the end but with the path continuouing
			-- the endpoint for a distance equal to half the `line_width' ?
		do
			Result := cap_style = CapProjecting
		end;

	is_round_cap: BOOLEAN
			-- Are lines terminated by a circular arc with the diameter equal
			-- to the `line_width', centered at the endpoint.
		do
			Result := cap_style = CapRound
		end;

feature {NONE} -- Access

	cap_style: INTEGER;
			-- How the endpoints of lines are drawn.

	CapButt: INTEGER = 1;
			-- Code to define butt cap

	CapNotLast: INTEGER = 0;
			-- Code to define not last cap

	CapProjecting: INTEGER = 3;
			-- Code to define projecting cap

	CapRound: INTEGER = 2;;
			-- Code to define round cap

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class ENDED

