indexing
	description: "Paragraph format mask (PFM) constants for the rich edit %
		%control."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PFM_CONSTANTS

feature -- Access

	Pfm_startindent: INTEGER is 1
			-- The dxStartIndent member is valid.

	Pfm_rightindent: INTEGER is 2
			-- The dxRightIndent member is valid.

	Pfm_offset: INTEGER is 4
			-- The dxStartIndent member is valid and specifies
			-- a relative value.

	Pfm_alignment: INTEGER is 8
			-- The wAlignment member is valid.

	Pfm_tabstops: INTEGER is 16
			-- The cTabStobs and rgxTabStops members are valid.

	Pfm_numbering: INTEGER is 32
			-- The wNumbering member is valid.

	Pfm_offsetindent: INTEGER is 2147483648
			-- The dxOffset member is valid.

end -- class WEL_PFM_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

