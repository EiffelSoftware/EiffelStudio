note
	description: "Definition of the system colors."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SYSTEM_COLORS

inherit
	ANY

	WEL_CONSTANTS
		export
			{NONE} all
		end

feature -- Access

	system_color_scrollbar: WEL_COLOR_REF
			-- Color for the scroll bar gray area.
		do
			Result := get_color (system_color_scrollbar_cell, Wel_color_constants.Color_scrollbar)
		ensure
			Result_exists: Result /= Void
		end

	system_color_background, system_color_desktop: WEL_COLOR_REF
			-- Color of the desktop
		do
			Result := get_color (system_color_background_cell, Wel_color_constants.Color_background)
		ensure
			Result_exists: Result /= Void
		end

	system_color_activecaption: WEL_COLOR_REF
			-- Color for active window title bar.
			--
			-- Windows 98, Windows 2000: Specifies the left side color in the
			-- color gradient of an active window's title bar if the gradient
			-- effect is enabled.
		do
			Result := get_color (system_color_activecaption_cell, Wel_color_constants.Color_activecaption)
		ensure
			Result_exists: Result /= Void
		end

	system_color_inactivecaption: WEL_COLOR_REF
			-- Color for inactive window caption.
			--
			-- Windows 98, Windows 2000: Specifies the left side color in the
			-- color gradient of an inactive window's title bar if the gradient
			-- effect is enabled.
		do
			Result := get_color (system_color_inactivecaption_cell, Wel_color_constants.Color_inactivecaption)
		ensure
			Result_exists: Result /= Void
		end

	system_color_menu: WEL_COLOR_REF
			-- background color for menus.
		do
			Result := get_color (system_color_menu_cell, Wel_color_constants.Color_menu)
		ensure
			Result_exists: Result /= Void
		end

	system_color_window: WEL_COLOR_REF
			-- background for windows.
		do
			Result := get_color (system_color_window_cell, Wel_color_constants.Color_window)
		ensure
			Result_exists: Result /= Void
		end

	system_color_windowframe: WEL_COLOR_REF
			-- Color for window frame.
		do
			Result := get_color (system_color_windowframe_cell, Wel_color_constants.Color_windowframe)
		ensure
			Result_exists: Result /= Void
		end

	system_color_menutext: WEL_COLOR_REF
			-- Color for text in menus.
		do
			Result := get_color (system_color_menutext_cell, Wel_color_constants.Color_menutext)
		ensure
			Result_exists: Result /= Void
		end

	system_color_windowtext: WEL_COLOR_REF
			-- Color for text in windows.
		do
			Result := get_color (system_color_windowtext_cell, Wel_color_constants.Color_windowtext)
		ensure
			Result_exists: Result /= Void
		end

	system_color_captiontext: WEL_COLOR_REF
			-- Color for text in caption, size box, and
			-- scroll bar arrow box.
		do
			Result := get_color (system_color_captiontext_cell, Wel_color_constants.Color_captiontext)
		ensure
			Result_exists: Result /= Void
		end

	system_color_activeborder: WEL_COLOR_REF
			-- Color for active window border.
		do
			Result := get_color (system_color_activeborder_cell, Wel_color_constants.Color_activeborder)
		ensure
			Result_exists: Result /= Void
		end

	system_color_inactiveborder: WEL_COLOR_REF
			-- Color for inactive window border.
		do
			Result := get_color (system_color_inactiveborder_cell, Wel_color_constants.Color_inactiveborder)
		ensure
			Result_exists: Result /= Void
		end

	system_color_appworkspace: WEL_COLOR_REF
			-- Background color of multiple document interface
			-- (MDI) applications.
		do
			Result := get_color (system_color_appworkspace_cell, Wel_color_constants.Color_appworkspace)
		ensure
			Result_exists: Result /= Void
		end

	system_color_highlight: WEL_COLOR_REF
			-- Color for item(s) selected in a control.
		do
			Result := get_color (system_color_highlight_cell, Wel_color_constants.Color_highlight)
		ensure
			Result_exists: Result /= Void
		end

	system_color_highlighttext: WEL_COLOR_REF
			-- Color for text of item(s) selected in a control.
		do
			Result := get_color (system_color_highlighttext_cell, Wel_color_constants.Color_highlighttext)
		ensure
			Result_exists: Result /= Void
		end

	system_color_btnface, system_color_3dface: WEL_COLOR_REF
			-- Face color for three-dimensional display elements and
			-- for dialog box backgrounds.
		do
			Result := get_color (system_color_btnface_cell, Wel_color_constants.Color_btnface)
		ensure
			Result_exists: Result /= Void
		end

	system_color_btnshadow, system_color_3dshadow: WEL_COLOR_REF
			-- Shadow color for three-dimensional display elements
			-- (for edges facing away from the light source).
		do
			Result := get_color (system_color_btnshadow_cell, Wel_color_constants.Color_btnshadow)
		ensure
			Result_exists: Result /= Void
		end

	system_color_graytext: WEL_COLOR_REF
			-- Color for grayed (disabled) text.
		do
			Result := get_color (system_color_graytext_cell, Wel_color_constants.Color_graytext)
		ensure
			Result_exists: Result /= Void
		end

	system_color_btntext: WEL_COLOR_REF
			-- Color of text on push buttons.
		do
			Result := get_color (system_color_btntext_cell, Wel_color_constants.Color_btntext)
		ensure
			Result_exists: Result /= Void
		end

	system_color_inactivecaptiontext: WEL_COLOR_REF
			-- Color of text in an inactive caption.
		do
			Result := get_color (system_color_inactivecaptiontext_cell, Wel_color_constants.Color_inactivecaptiontext)
		ensure
			Result_exists: Result /= Void
		end

	system_color_btnhighlight, system_color_btnhilight, system_color_3dhighlight, system_color_3dhilight: WEL_COLOR_REF
			-- Highlight color for three-dimensional display elements
			-- (for edges facing the light source.)
		do
			Result := get_color (system_color_btnhighlight_cell, Wel_color_constants.Color_btnhighlight)
		ensure
			Result_exists: Result /= Void
		end

	system_color_menuhilight: WEL_COLOR_REF
			-- The color used to highlight menu items when the menu appears as a flat menu (see SystemParametersInfo).
			-- The highlighted menu item is outlined with `system_color_highlight'.
		require
			windows_xp_required: (create {WEL_WINDOWS_VERSION}).is_windows_xp_compatible
		do
			Result := get_color (system_color_menuhilight_cell, Wel_color_constants.Color_menuhilight)
		ensure
			Result_exists: Result /= Void
		end

	system_color_menubar: WEL_COLOR_REF
			-- The background color for the menu bar when menus appear as flat menus (see SystemParametersInfo).
			-- However, `system_color_menu' continues to specify the background color of the menu popup.
		require
			windows_xp_required: (create {WEL_WINDOWS_VERSION}).is_windows_xp_compatible
		do
			Result := get_color (system_color_menubar_cell, Wel_color_constants.Color_menubar)
		ensure
			Result_exists: Result /= Void
		end

	system_color_hotlight: WEL_COLOR_REF
			-- Color for a hot-tracked item. Single clicking a hot-tracked item executes the item.
			-- (Windows 98/Me, Windows 2000 or later)
		require
			windows_98_required: (create {WEL_WINDOWS_VERSION}).is_windows_98_compatible
		do
			Result := get_color (system_color_hotlight_cell, Wel_color_constants.Color_hotlight)
		ensure
			Result_exists: Result /= Void
		end

	system_color_gradientactivecaption: WEL_COLOR_REF
			-- Right side color in the color gradient of an active window's
			-- title bar. `System_color_activecaption' specifies the left side color.
		require
			windows_98_required: (create {WEL_WINDOWS_VERSION}).is_windows_98_compatible
		do
			Result := get_color (system_color_gradientactivecaption_cell, Wel_color_constants.Color_gradientactivecaption)
		ensure
			Result_exists: Result /= Void
		end

	system_color_gradientinactivecaption: WEL_COLOR_REF
			-- Right side color in the color gradient of an inactive window's
			-- title bar. `system_color_inactivecaption' specifies the left side color.
		require
			windows_98_required: (create {WEL_WINDOWS_VERSION}).is_windows_98_compatible
		do
			Result := get_color (system_color_gradientinactivecaption_cell, Wel_color_constants.Color_gradientinactivecaption)
		ensure
			Result_exists: Result /= Void
		end

	system_color_infobk: WEL_COLOR_REF
			-- Background color for tooltip
		do
			Result := get_color (system_color_graytext_cell, Wel_color_constants.color_infobk)
		ensure
			Result_exists: Result /= Void
		end

	system_color_info_text: WEL_COLOR_REF
			-- Background color for tooltip text
		do
			Result := get_color (system_color_graytext_cell, Wel_color_constants.color_infotext)
		ensure
			Result_exists: Result /= Void
		end

feature {WEL_COMPOSITE_WINDOW}

	system_color_scrollbar_cell: CELL [?WEL_COLOR_REF]
			-- Container for `system_color_scrollbar'
		once
			create Result.put (Void)
		end

	system_color_background_cell: CELL [?WEL_COLOR_REF]
			-- Container for `system_color_background'
		once
			create Result.put (Void)
		end

	system_color_activecaption_cell: CELL [?WEL_COLOR_REF]
			-- Container for `system_color_activecaption'
		once
			create Result.put (Void)
		end

	system_color_inactivecaption_cell: CELL [?WEL_COLOR_REF]
			-- Container for `system_color_inactivecaption'
		once
			create Result.put (Void)
		end

	system_color_menu_cell: CELL [?WEL_COLOR_REF]
			-- Container for `system_color_menu'
		once
			create Result.put (Void)
		end

	system_color_window_cell: CELL [?WEL_COLOR_REF]
			-- Container for `system_color_window'
		once
			create Result.put (Void)
		end

	system_color_windowframe_cell: CELL [?WEL_COLOR_REF]
			-- Container for `system_color_windowframe'
		once
			create Result.put (Void)
		end

	system_color_menutext_cell: CELL [?WEL_COLOR_REF]
			-- Container for `system_color_menutext'
		once
			create Result.put (Void)
		end

	system_color_windowtext_cell: CELL [?WEL_COLOR_REF]
			-- Container for `system_color_windowtext'
		once
			create Result.put (Void)
		end

	system_color_captiontext_cell: CELL [?WEL_COLOR_REF]
			-- Container for `system_color_captiontext'
		once
			create Result.put (Void)
		end

	system_color_activeborder_cell: CELL [?WEL_COLOR_REF]
			-- Container for `system_color_activeborder'
		once
			create Result.put (Void)
		end

	system_color_inactiveborder_cell: CELL [?WEL_COLOR_REF]
			-- Container for `system_color_inactiveborder'
		once
			create Result.put (Void)
		end

	system_color_appworkspace_cell: CELL [?WEL_COLOR_REF]
			-- Container for `system_color_appworkspace'
		once
			create Result.put (Void)
		end

	system_color_highlight_cell: CELL [?WEL_COLOR_REF]
			-- Container for `system_color_highlight'
		once
			create Result.put (Void)
		end

	system_color_highlighttext_cell: CELL [?WEL_COLOR_REF]
			-- Container for `system_color_highlighttext'
		once
			create Result.put (Void)
		end

	system_color_btnface_cell: CELL [?WEL_COLOR_REF]
			-- Container for `system_color_btnface'
		once
			create Result.put (Void)
		end

	system_color_btnshadow_cell: CELL [?WEL_COLOR_REF]
			-- Container for `system_color_btnshadow'
		once
			create Result.put (Void)
		end

	system_color_graytext_cell: CELL [?WEL_COLOR_REF]
			-- Container for `system_color_graytext'
		once
			create Result.put (Void)
		end

	system_color_btntext_cell: CELL [?WEL_COLOR_REF]
			-- Container for `system_color_btntext'
		once
			create Result.put (Void)
		end

	system_color_inactivecaptiontext_cell: CELL [?WEL_COLOR_REF]
			-- Container for `system_color_inactivecaptiontext'
		once
			create Result.put (Void)
		end

	system_color_btnhighlight_cell: CELL [?WEL_COLOR_REF]
			-- Container for `system_color_btnhighlight'
		once
			create Result.put (Void)
		end

	system_color_menuhilight_cell: CELL [?WEL_COLOR_REF]
			-- Container for `system_color_menuhilight'
		once
			create Result.put (Void)
		end

	system_color_menubar_cell: CELL [?WEL_COLOR_REF]
			-- Container for `system_color_menubar'
		once
			create Result.put (Void)
		end

	system_color_hotlight_cell: CELL [?WEL_COLOR_REF]
			-- Container for `system_color_hotlight'
		once
			create Result.put (Void)
		end

	system_color_gradientactivecaption_cell: CELL [?WEL_COLOR_REF]
			-- Container for `system_color_gradientactivecaption'
		once
			create Result.put (Void)
		end

	system_color_gradientinactivecaption_cell: CELL [?WEL_COLOR_REF]
			-- Container for `system_color_gradientinactivecaption'
		once
			create Result.put (Void)
		end

feature {NONE} -- Implementation

	get_color (color_cell: CELL [?WEL_COLOR_REF]; color_constant: INTEGER): WEL_COLOR_REF
			-- Return the color contained in `color_cell'. Create it
			-- if necessary using the system color `color_constant'.
		require
			valid_cell: color_cell /= Void
			valid_color: Wel_color_constants.valid_color_constant (color_constant)
		local
			loc_color: ?WEL_COLOR_REF
		do
			loc_color := color_cell.item
			if loc_color = Void then
				create loc_color.make_system (color_constant)
				color_cell.put (loc_color)
			end
			Result := loc_color
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_SYSTEM_COLORS

