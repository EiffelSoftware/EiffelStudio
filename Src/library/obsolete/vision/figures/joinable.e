note

	description: "Joinable figure (polyline...)"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	JOINABLE

feature -- Element change 

	set_bevel_join
			-- Specifies CapButt endpoint styles, with the triangular notch
			-- filled.
		do
			join_style := JoinBevel
		end;

	set_miter_join
			-- Specifies that the outer edges of the two lines would extend to
			-- meet at an angle.
		do
			join_style := JoinMiter
		end;

	set_round_join
			-- Specifies that lines should be joined by a circular arc with
			-- diameter equal to `line_width', centered on the join point.
		do
			join_style := JoinRound
		end;

feature -- Status report

	is_bevel_join: BOOLEAN
			-- Is CapButt endpoint styles, with the triangular notch filled ?
		do
			Result := join_style = JoinBevel
		end;

	is_miter_join: BOOLEAN
			-- Are the outer edges of the two lines would extend to meet at
			-- an angle ?
		do
			Result := join_style = JoinMiter
		end;

	is_round_join: BOOLEAN
			-- Are lines joined by a circular arc with diameter equal to
			-- `line_width', centered on the join point ?
		do
			Result := join_style = JoinRound
		end;

feature {NONE} -- Access

	join_style: INTEGER;
			-- How corners are drawn for wide lines drawn

	JoinBevel: INTEGER = 2;
			-- Code to define join bevel way

	JoinMiter: INTEGER = 0;
			-- Code to define join miter way

	JoinRound: INTEGER = 1;;
			-- Code to define join round way

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




end -- class JOINABLE

