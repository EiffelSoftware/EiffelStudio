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

create
	make

feature {NONE} -- Implementation

	make is
			-- Creation metod
		local
			l_err: WEL_ERROR
		do
			create {EV_XP_THEME_DRAWER_IMP} theme_drawer
			create l_err
			l_err.reset_last_error_code
			if l_err.last_error_code /= 0 then
				l_err.display_last_error
			end
			create wel_color
		end

feature -- Querys

	active_border_color: EV_COLOR is
			-- Redefine.
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
