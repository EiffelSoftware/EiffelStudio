indexing
	description: "Color (COLOR) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_COLOR_CONSTANTS

feature -- Access

	Color_scrollbar: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"COLOR_SCROLLBAR"
		end

	Color_background: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"COLOR_BACKGROUND"
		end

	Color_activecaption: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"COLOR_ACTIVECAPTION"
		end

	Color_inactivecaption: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"COLOR_INACTIVECAPTION"
		end

	Color_menu: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"COLOR_MENU"
		end

	Color_window: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"COLOR_WINDOW"
		end

	Color_windowframe: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"COLOR_WINDOWFRAME"
		end

	Color_menutext: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"COLOR_MENUTEXT"
		end

	Color_windowtext: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"COLOR_WINDOWTEXT"
		end

	Color_captiontext: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"COLOR_CAPTIONTEXT"
		end

	Color_activeborder: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"COLOR_ACTIVEBORDER"
		end

	Color_inactiveborder: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"COLOR_INACTIVEBORDER"
		end

	Color_appworkspace: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"COLOR_APPWORKSPACE"
		end

	Color_highlight: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"COLOR_HIGHLIGHT"
		end

	Color_highlighttext: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"COLOR_HIGHLIGHTTEXT"
		end

	Color_btnface: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"COLOR_BTNFACE"
		end

	Color_btnshadow: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"COLOR_BTNSHADOW"
		end

	Color_graytext: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"COLOR_GRAYTEXT"
		end

	Color_btntext: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"COLOR_BTNTEXT"
		end

	Color_inactivecaptiontext: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"COLOR_INACTIVECAPTIONTEXT"
		end

	Color_btnhighlight: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"COLOR_BTNHIGHLIGHT"
		end

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

