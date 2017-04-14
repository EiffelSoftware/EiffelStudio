note
	description: "System color on Windows."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_SYSTEM_COLOR_IMP

inherit
	SD_SYSTEM_COLOR

	EV_BUTTON_IMP
	-- Inherit for export features.
		rename
			make as make_not_use
		export
			{NONE} all
		redefine
			base_make_called
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Implementation

	make
			-- Creation metod
		local
			l_err: WEL_ERROR
		do
			check attached {EV_APPLICATION_IMP} ev_application.implementation as l_app_imp then
				theme_drawer := l_app_imp.theme_drawer
			end

			create l_err
			l_err.reset_last_error_code
			if l_err.last_error_code /= 0 then
				l_err.display_last_error
			end
			create wel_color

			create child_cell -- Only for make void safe compiler happy
		end

	base_make_called: BOOLEAN = True
			-- Not breaking the invariant in EV_ANY_I.

feature -- Querys

	default_background_color: EV_COLOR
			-- <Precursor>
		do
			Result := (create {EV_STOCK_COLORS}).default_background_color
		end

	active_border_color: EV_COLOR
			-- <Precursor>
		local
			l_pointer: POINTER
		do
			Result := theme_drawer.theme_color (l_pointer, {WEL_COLOR_CONSTANTS}.color_btnshadow)
		end

	focused_selection_color: EV_COLOR
			-- <Precursor>
		local
			l_pointer: POINTER
		do
			Result := theme_drawer.theme_color (l_pointer, {WEL_COLOR_CONSTANTS}.color_highlight)
		end

	focused_title_text_color: EV_COLOR
			-- <Precursor>
		local
			l_pointer: POINTER
		do
			Result := theme_drawer.theme_color (l_pointer, {WEL_COLOR_CONSTANTS}.color_captiontext)
		end

	non_focused_selection_color: EV_COLOR
			-- <Precursor>
		local
			l_pointer: POINTER
		do
			Result := theme_drawer.theme_color (l_pointer, {WEL_COLOR_CONSTANTS}.color_btnface)
		end

	non_focused_selection_title_color: EV_COLOR
			-- <Precursor>
		local
			l_pointer: POINTER
		do
			Result := theme_drawer.theme_color (l_pointer, {WEL_COLOR_CONSTANTS}.color_inactivecaption)
		end

	non_focused_title_text_color: EV_COLOR
			-- <Precursor>
		local
			l_pointer: POINTER
		do
			Result := theme_drawer.theme_color (l_pointer, {WEL_COLOR_CONSTANTS}.color_inactivecaptiontext)
		end

	button_text_color: EV_COLOR
			-- <Precursor>
		local
			l_pointer: POINTER
		do
			Result := theme_drawer.theme_color (l_pointer, {WEL_COLOR_CONSTANTS}.color_btntext)
		end

feature -- Font

	tool_bar_font: EV_FONT
			-- <Precursor>
		local
			l_shared_font: WEL_SHARED_FONTS
		do
			create Result
			create l_shared_font
			if attached {EV_FONT_IMP} Result.implementation as l_imp then
				l_imp.set_by_wel_font (l_shared_font.menu_font)
			else
				check False end -- Implied by design of Vision2
			end
		end

feature {NONE}  -- Implementation

	wel_color: WEL_SYSTEM_COLORS
			-- Wel system colors.

	theme_drawer: EV_THEME_DRAWER_IMP
			-- Theme drawer used for query system colors.

invariant
	not_void: wel_color /= Void

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
