indexing
	description: "Paragraph format alignment (PFA) constants for the rich %
		%edit control."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PFA_CONSTANTS

feature -- Access

	Pfa_left: INTEGER is
			-- Paragraphs are aligned with the left margin.
		external
			"C [macro %"redit.h%"]"
		alias
			"PFA_LEFT"
		end

	Pfa_right: INTEGER is
			-- Paragraphs are aligned with the right margin.
		external
			"C [macro %"redit.h%"]"
		alias
			"PFA_RIGHT"
		end

	Pfa_center: INTEGER is
			-- Paragraphs are centered.
		external
			"C [macro %"redit.h%"]"
		alias
			"PFA_CENTER"
		end

end -- class WEL_PFA_CONSTANTS


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

