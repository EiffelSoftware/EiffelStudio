indexing
	description: "Pen style (PS) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PS_CONSTANTS

feature -- Access

	Ps_solid: INTEGER is 0

	Ps_dash: INTEGER is 1

	Ps_dot: INTEGER is 2

	Ps_dashdot: INTEGER is 3

	Ps_dashdotdot: INTEGER is 4

	Ps_null: INTEGER is 5

	Ps_insideframe: INTEGER is 6

feature -- Status report

	valid_pen_style_constant (c: INTEGER): BOOLEAN is
			-- Is `c' a valid pen style constant?
		do
			Result := c = Ps_solid or else
				c = Ps_dash or else
				c = Ps_dot or else
				c = Ps_dashdot or else
				c = Ps_dashdotdot or else
				c = Ps_null or else
				c = Ps_insideframe
		end

end -- class WEL_PS_CONSTANTS

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

