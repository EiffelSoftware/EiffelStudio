indexing
	description: "Color (COLOR) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_COLOR_CONSTANTS

feature -- Access

	Color_scrollbar: INTEGER is 0

	Color_background: INTEGER is 1

	Color_activecaption: INTEGER is 2

	Color_inactivecaption: INTEGER is 3

	Color_menu: INTEGER is 4

	Color_window: INTEGER is 5

	Color_windowframe: INTEGER is 6

	Color_menutext: INTEGER is 7

	Color_windowtext: INTEGER is 8

	Color_captiontext: INTEGER is 9

	Color_activeborder: INTEGER is 10

	Color_inactiveborder: INTEGER is 11

	Color_appworkspace: INTEGER is 12

	Color_highlight: INTEGER is 13

	Color_highlighttext: INTEGER is 14

	Color_btnface: INTEGER is 15

	Color_btnshadow: INTEGER is 16

	Color_graytext: INTEGER is 17

	Color_btntext: INTEGER is 18

	Color_inactivecaptiontext: INTEGER is 19

	Color_btnhighlight: INTEGER is 20

feature -- Status report

	valid_color_constant (c: INTEGER): BOOLEAN is
			-- Is `c' a valid color constant?
		do
			Result := c = Color_scrollbar or else
				c = Color_background or else
				c = Color_activecaption or else
				c = Color_inactivecaption or else
				c = Color_menu or else
				c = Color_window or else
				c = Color_windowframe or else
				c = Color_menutext or else
				c = Color_windowtext or else
				c = Color_captiontext or else
				c = Color_activeborder or else
				c = Color_inactiveborder or else
				c = Color_appworkspace or else
				c = Color_highlight or else
				c = Color_highlighttext or else
				c = Color_btnface or else
				c = Color_btnshadow or else
				c = Color_graytext or else
				c = Color_btntext or else
				c = Color_inactivecaptiontext or else
				c = Color_btnhighlight
		end

end -- class WEL_COLOR_CONSTANTS


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

