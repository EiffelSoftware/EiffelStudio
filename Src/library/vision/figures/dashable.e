indexing

	description: "Dashable figure (line, arc,...)";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	DASHABLE 

feature -- Access 

	dash_pattern: DASH;
			-- Pattern of dash to be used to draw lines

feature -- Element change 

	set_dash_pattern (a_dash: DASH) is
			-- Set pattern of dash to be used to draw lines.
		require
			a_dash_exists: a_dash /= Void;
			a_dash_valid: not a_dash.is_empty
		do
			dash_pattern := a_dash;
		end;

	set_doubledash_line is
			-- Specifies that full path of the line is drawn, dashes with the
			-- foreground pixel value, gaps with th background pixel values.
		do
			line_style := LineDoubleDash;
		end;

	set_onoffdash_line is
			-- Specifies that only the dashes are drawn with the foreground
			-- pixel.
		do
			line_style := LineOnOffDash;
		end;

	set_solid_line is
			-- Specifies that the full path of the line is drawn using the
			-- foreground pixel value.
		do
			line_style := LineSolid;	
		end;

feature -- Status report

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

feature {NONE} -- Access

	line_style: INTEGER;
			-- Style of line of current figure

	LineDoubleDash: INTEGER is 2;
			-- Code to define double dash line

	LineOnOffDash: INTEGER is 1;
			-- Code to define on off dash line

	LineSolid: INTEGER is 0;
			-- Code to define solid line

invariant

	pattern_when_exists: dash_pattern /= Void implies (not dash_pattern.is_empty)

end -- class DASHABLE



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

