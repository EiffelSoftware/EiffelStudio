indexing
	description:
		"Eiffel Vision font constants. Objects that access font may %N%
		%inherit this class to use its facilities."
	status: "See notice at end of class"
	keywords: "character, face, size, family, weight, shape, bold, italic"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FONT_CONSTANTS

feature -- Constants

	Ev_font_family_screen: INTEGER is 1
	Ev_font_family_roman: INTEGER is 2
	Ev_font_family_sans: INTEGER is 3
	Ev_font_family_typewriter: INTEGER is 4
	Ev_font_family_modern: INTEGER is 5

	Ev_font_weight_thin: INTEGER is 6
	Ev_font_weight_regular: INTEGER is 7
	Ev_font_weight_bold: INTEGER is 8
	Ev_font_weight_black: INTEGER is 9

	Ev_font_shape_regular: INTEGER is 10
	Ev_font_shape_italic: INTEGER is 11

feature -- Contract support

	valid_family (a_family: INTEGER): BOOLEAN is
			-- Is `a_family' a valid family value.
		do
			Result := a_family = Ev_font_family_screen or else
				a_family = Ev_font_family_roman or else
				a_family = Ev_font_family_sans or else
				a_family = Ev_font_family_typewriter or else
				a_family = Ev_font_family_modern
		end

	valid_weight (a_weight: INTEGER): BOOLEAN is
			-- Is `a_weight' a valid weight value.
		do
			Result := a_weight = Ev_font_weight_thin or else
				a_weight = Ev_font_weight_regular or else
				a_weight = Ev_font_weight_bold or else
				a_weight = Ev_font_weight_black
		end

	valid_shape (a_shape: INTEGER): BOOLEAN is
			-- Is `a_shape' a valid shape value.
		do
			Result := a_shape = Ev_font_shape_regular or else
				a_shape = Ev_font_shape_italic
		end

end -- class EV_FONT_CONSTANTS

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.2  2000/02/14 12:05:12  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.5  2000/01/28 20:02:21  oconnor
--| released
--|
--| Revision 1.1.2.4  2000/01/27 19:30:44  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.2.3  2000/01/21 22:24:49  brendel
--| A
--|
--| Revision 1.1.2.2  2000/01/21 20:05:28  brendel
--| Added valid_family, valid_weight and valid_shape.
--|
--| Revision 1.1.2.1  2000/01/07 18:06:26  king
--| Initial.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
