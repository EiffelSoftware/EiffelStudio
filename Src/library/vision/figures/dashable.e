--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                      (805) 685-1006                                --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- DASHABLE: Dashable figure (line, arc,...).

indexing

	date: "$Date$";
	revision: "$Revision$"

class DASHABLE 

feature 

	dash_pattern: DASH;
			-- Pattern of dash to be used to draw lines

	is_doubledash_line: BOOLEAN is
			-- Is full path of the line drawn, dashes with the foreground
			-- pixel value, gaps with th background pixel values ?
		do
			Result := line_style = LineDoubleDash
		end;

	is_onoffdash_line: BOOLEAN is
			-- Are only dashes drawn with the foreground pixel ?
		do
			Result := line_style = LineOnOffDash
		end;

	is_solid_line: BOOLEAN is
			-- Is full path of the line drawn using the foreground pixel value ?
		do
			Result := line_style = LineSolid
		end;

feature {NONE}

	line_style: INTEGER;
			-- Style of line of current figure

	LineDoubleDash: INTEGER is 2;
			-- Code to define double dash line

	LineOnOffDash: INTEGER is 1;
			-- Code to define on off dash line

	LineSolid: INTEGER is 0;
			-- Code to define solid line

feature 

	set_dash_pattern (a_dash: DASH) is
			-- Set pattern of dash to be used to draw lines.
		require
			a_dash_exists: not (a_dash = Void);
			a_dash_valid: not a_dash.empty
		do
			dash_pattern := a_dash
		end;

	set_doubledash_line is
			-- Specifies that full path of the line is drawn, dashes with the
			-- foreground pixel value, gaps with th background pixel values.
		do
			line_style := LineDoubleDash
		end;

	set_onoffdash_line is
			-- Specifies that only the dashes are drawn with the foreground
			-- pixel.
		do
			line_style := LineOnOffDash
		end;

	set_solid_line is
			-- Specifies that the full path of the line is drawn using the
			-- foreground pixel value.
		do
			line_style := LineSolid
		end;

invariant

	(not (dash_pattern = Void)) implies (not dash_pattern.empty)

end
