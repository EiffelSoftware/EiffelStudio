indexing
	description: "Constants for use by and with EV_PARAGRAPH_FORMAT."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PARAGRAPH_CONSTANTS

feature -- Constants

	Alignment_left: INTEGER is 1
		-- Aligned left.
		
	Alignment_center: INTEGER is 2
		-- Aligned center.
		
	Alignment_right: INTEGER is 3
		-- Aligned right.
		
	Alignment_justified: INTEGER is 4
		-- Justified.
		
feature -- Contract support

	valid_alignment (an_alignment: INTEGER): BOOLEAN is
			-- Is `an_alignment' a valid alignment?
		do
			Result := an_alignment = alignment_left or else
				an_alignment = alignment_center or else
				an_alignment = alignment_right or else
				an_alignment = alignment_justified
		end

end -- class EV_PARAGRAPH_CONSTANTS

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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
