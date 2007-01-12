indexing
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
		end

create
	make

feature {NONE} -- Implementation

	make is
			-- Creation metod
		local
			l_err: WEL_ERROR
			l_env: EV_ENVIRONMENT
			l_app_imp: EV_APPLICATION_IMP
		do
			create l_env
			l_app_imp ?= l_env.application.implementation
			check not_void: l_app_imp /= Void end
			theme_drawer := l_app_imp.theme_drawer

			create l_err
			l_err.reset_last_error_code
			if l_err.last_error_code /= 0 then
				l_err.display_last_error
			end
			create wel_color
		end

feature -- Querys

	default_background_color: EV_COLOR is
			-- Redefine
		local
			l_colors: EV_STOCK_COLORS
		do
			create l_colors
			Result := l_colors.default_background_color
		end

	active_border_color: EV_COLOR is
			-- Redefine
		local
			l_pointer: POINTER
		do
			Result := theme_drawer.theme_color (l_pointer, {WEL_COLOR_CONSTANTS}.color_btnshadow)
		end

	focused_selection_color: EV_COLOR is
			-- Redefine
		local
			l_pointer: POINTER
		do
			Result := theme_drawer.theme_color (l_pointer, {WEL_COLOR_CONSTANTS}.color_highlight)
		end

	focused_title_text_color: EV_COLOR is
			-- Redefine
		local
			l_pointer: POINTER
		do
			Result := theme_drawer.theme_color (l_pointer, {WEL_COLOR_CONSTANTS}.color_captiontext)
		end

	non_focused_selection_color: EV_COLOR is
			-- Redefine
		local
			l_pointer: POINTER
		do
			Result := theme_drawer.theme_color (l_pointer, {WEL_COLOR_CONSTANTS}.color_btnface)
		end

	non_focused_selection_title_color: EV_COLOR is
			-- Redefine
		local
			l_pointer: POINTER
		do
			Result := theme_drawer.theme_color (l_pointer, {WEL_COLOR_CONSTANTS}.color_inactivecaption)
		end

	non_focused_title_text_color: EV_COLOR is
			-- Redefine
		local
			l_pointer: POINTER
		do
			Result := theme_drawer.theme_color (l_pointer, {WEL_COLOR_CONSTANTS}.color_inactivecaptiontext)
		end

	button_text_color: EV_COLOR is
			-- Redefine
		local
			l_pointer: POINTER
		do
			Result := theme_drawer.theme_color (l_pointer, {WEL_COLOR_CONSTANTS}.color_btntext)
		end

feature -- Font

	tool_bar_font: EV_FONT is
			-- Redefine
		local
			l_imp: EV_FONT_IMP
			l_shared_font: WEL_SHARED_FONTS
		do
			create Result
			create l_shared_font
			l_imp ?= Result.implementation
			l_imp.set_by_wel_font (l_shared_font.menu_font)
		end

feature {NONE}  -- Implementation

	wel_color: WEL_SYSTEM_COLORS
			-- Wel system colors.

	theme_drawer: EV_THEME_DRAWER_IMP
			-- Theme drawer used for query system colors.

invariant
	not_void: wel_color /= Void

indexing
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"






end
