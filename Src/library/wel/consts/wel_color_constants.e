indexing
	description: "Color (COLOR) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_COLOR_CONSTANTS

feature -- Access

	Color_scrollbar: INTEGER is 0
			-- Scroll bar gray area.
			--
			-- Declared in Windows as COLOR_SCROLLBAR

	Color_background, Color_desktop: INTEGER is 1
			-- Desktop.
			--
			-- Declared in Windows as COLOR_BACKGROUND

	Color_activecaption: INTEGER is 2
			-- Active window title bar. 
			--
			-- Windows 98/Me, Windows 2000 or later:
			--   Specifies the left side color in the color gradient of an active
			--   window's title bar if the gradient effect is enabled.
			--
			-- Declared in Windows as COLOR_ACTIVECAPTION

	Color_inactivecaption: INTEGER is 3
			-- Inactive window caption. 
			--
			-- Windows 98/Me, Windows 2000 or later:
			--   Specifies the left side color in the color gradient of an inactive
			--   window's title bar if the gradient effect is enabled.
			--
			-- Declared in Windows as COLOR_INACTIVECAPTION

	Color_menu: INTEGER is 4
			-- Menu background.
			--
			-- Declared in Windows as COLOR_MENU

	Color_window: INTEGER is 5
			-- Window background.
			--
			-- Declared in Windows as COLOR_WINDOW

	Color_windowframe: INTEGER is 6
			-- Window frame.
			--
			-- Declared in Windows as COLOR_WINDOWFRAME

	Color_menutext: INTEGER is 7
			-- Text in menus.
			--
			-- Declared in Windows as COLOR_MENUTEXT

	Color_windowtext: INTEGER is 8
			-- Text in windows.
			--
			-- Declared in Windows as COLOR_WINDOWTEXT

	Color_captiontext: INTEGER is 9
			-- Text in caption, size box, and scroll bar arrow box.
			--
			-- Declared in Windows as COLOR_CAPTIONTEXT

	Color_activeborder: INTEGER is 10
			-- Active window border.
			--
			-- Declared in Windows as COLOR_ACTIVEBORDER

	Color_inactiveborder: INTEGER is 11
			-- Inactive window border.
			--
			-- Declared in Windows as COLOR_INACTIVEBORDER

	Color_appworkspace: INTEGER is 12
			-- Background color of multiple document interface (MDI) applications.
			--
			-- Declared in Windows as COLOR_APPWORKSPACE

	Color_highlight: INTEGER is 13
			-- Item(s) selected in a control.
			--
			-- Declared in Windows as COLOR_HIGHLIGHT

	Color_highlighttext: INTEGER is 14
			-- Text of item(s) selected in a control.
			--
			-- Declared in Windows as COLOR_HIGHLIGHTTEXT

	Color_3dface, Color_btnface: INTEGER is 15
			-- Face color for three-dimensional display elements and
			-- for dialog box backgrounds.
			--
			-- Declared in Windows as COLOR_3DFACE

	Color_3dshadow, Color_btnshadow: INTEGER is 16
			-- Shadow color for three-dimensional display elements
			-- (for edges facing away from the light source).
			--
			-- Declared in Windows as COLOR_3DSHADOW

	Color_graytext: INTEGER is 17
			-- Grayed (disabled) text. This color is set to 0 if the current
			-- display driver does not support a solid gray color.
			--
			-- Declared in Windows as COLOR_GRAYTEXT

	Color_btntext: INTEGER is 18
			-- Text on push buttons.
			--
			-- Declared in Windows as COLOR_BTNTEXT

	Color_inactivecaptiontext: INTEGER is 19
			-- Color of text in an inactive caption.
			--
			-- Declared in Windows as COLOR_INACTIVECAPTIONTEXT

	Color_3dhilight, Color_3dhighlight, Color_btnhilight, Color_btnhighlight: INTEGER is 20
			-- Highlight color for three-dimensional display elements
			-- (for edges facing the light source.)
			--
			-- Declared in Windows as COLOR_3DHILIGHT

	Color_3ddkshadow: INTEGER is 21
			-- Dark shadow for three-dimensional display elements.
			--
			-- Declared in Windows as COLOR_3DDKSHADOW

	Color_3dlight: INTEGER is 22
			-- Light color for three-dimensional display elements
			-- (for edges facing the light source.)
			--
			-- Declared in Windows as COLOR_3DLIGHT

	Color_infotext: INTEGER is 23
			-- Text color for tooltip controls.
			--
			-- Declared in Windows as COLOR_INFOTEXT

	Color_infobk: INTEGER is 24
			-- Background color for tooltip controls.
			--
			-- Declared in Windows as COLOR_INFOBK

	Color_hotlight: INTEGER is 26
			-- Windows 98/Me, Windows 2000 or later:
			--   Color for a hot-tracked item. Single clicking a hot-tracked
			--   item executes the item.
			--
			-- Declared in Windows as COLOR_HOTLIGHT

	Color_gradientactivecaption: INTEGER is 27
			-- Windows 98/Me, Windows 2000 or later:
			--   Right side color in the color gradient of an active window's
			--   title bar. COLOR_ACTIVECAPTION specifies the left side color.
			--   Use SPI_GETGRADIENTCAPTIONS with the SystemParametersInfo
			--   function to determine whether the gradient effect is enabled.
			--
			-- Declared in Windows as COLOR_GRADIENTACTIVECAPTION

	Color_gradientinactivecaption: INTEGER is 28
			-- Windows 98/Me, Windows 2000 or later:
			--   Right side color in the color gradient of an inactive window's
			--   title bar. COLOR_INACTIVECAPTION specifies the left side color.
			--
			-- Declared in Windows as COLOR_GRADIENTINACTIVECAPTION

	Color_menuhilight: INTEGER is 29
			-- Windows XP:
			--   The color used to highlight menu items when the menu appears
			--   as a flat menu (see SystemParametersInfo). The highlighted
			--   menu item is outlined with COLOR_HIGHLIGHT.
			--
			-- Declared in Windows as COLOR_MENUHILIGHT

	Color_menubar: INTEGER is 30
			-- Windows XP:
			--   The background color for the menu bar when menus appear as 
			--   flat menus (see SystemParametersInfo). However, `Color_menu'
			--   continues to specify the background color of the menu popup.
			--
			-- Declared in Windows as COLOR_MENUBAR

feature -- Status report

	valid_color_constant (c: INTEGER): BOOLEAN is
			-- Is `c' a valid color constant?
		do
			Result := 
				c = Color_3ddkshadow or else
				c = Color_3dface or else
				c = Color_3dhilight or else
				c = Color_3dlight or else
				c = Color_3dshadow or else
				c = Color_activeborder or else
				c = Color_activecaption or else
				c = Color_appworkspace or else
				c = Color_background or else
				c = Color_btntext or else
				c = Color_captiontext or else
				c = Color_gradientactivecaption or else
				c = Color_gradientinactivecaption or else
				c = Color_graytext or else
				c = Color_highlight or else
				c = Color_highlighttext or else
				c = Color_hotlight or else
				c = Color_inactiveborder or else
				c = Color_inactivecaption or else
				c = Color_inactivecaptiontext or else
				c = Color_infobk or else
				c = Color_infotext or else
				c = Color_menu or else
				c = Color_menuhilight or else
				c = Color_menubar or else
				c = Color_menutext or else
				c = Color_scrollbar or else
				c = Color_window or else
				c = Color_windowframe or else
				c = Color_windowtext
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

