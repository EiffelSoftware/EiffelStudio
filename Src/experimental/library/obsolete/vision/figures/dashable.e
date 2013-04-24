note

	description: "Dashable figure (line, arc,...)"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	DASHABLE 

feature -- Access 

	dash_pattern: DASH;
			-- Pattern of dash to be used to draw lines

feature -- Element change 

	set_dash_pattern (a_dash: DASH)
			-- Set pattern of dash to be used to draw lines.
		require
			a_dash_exists: a_dash /= Void;
			a_dash_valid: not a_dash.is_empty
		do
			dash_pattern := a_dash;
		end;

	set_doubledash_line
			-- Specifies that full path of the line is drawn, dashes with the
			-- foreground pixel value, gaps with th background pixel values.
		do
			line_style := LineDoubleDash;
		end;

	set_onoffdash_line
			-- Specifies that only the dashes are drawn with the foreground
			-- pixel.
		do
			line_style := LineOnOffDash;
		end;

	set_solid_line
			-- Specifies that the full path of the line is drawn using the
			-- foreground pixel value.
		do
			line_style := LineSolid;	
		end;

feature -- Status report

	is_doubledash_line: BOOLEAN
			-- Is full path of the line drawn, dashes with the foreground
			-- pixel value, gaps with th background pixel values ?
		do
			Result := line_style = LineDoubleDash
		end;

	is_onoffdash_line: BOOLEAN
			-- Are only dashes drawn with the foreground pixel ?
		do
			Result := line_style = LineOnOffDash
		end;

	is_solid_line: BOOLEAN
			-- Is full path of the line drawn using the foreground pixel value ?
		do
			Result := line_style = LineSolid
		end;

feature {NONE} -- Access

	line_style: INTEGER;
			-- Style of line of current figure

	LineDoubleDash: INTEGER = 2;
			-- Code to define double dash line

	LineOnOffDash: INTEGER = 1;
			-- Code to define on off dash line

	LineSolid: INTEGER = 0;
			-- Code to define solid line

invariant

	pattern_when_exists: dash_pattern /= Void implies (not dash_pattern.is_empty)

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




end -- class DASHABLE

