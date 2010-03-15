note
	description: "List of default colors used by the system.%
				% Mswindows implementation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_STOCK_COLORS_IMP 

feature -- Access

	Color_dialog, Color_3d_face: EV_COLOR
			-- Color usually used for the background of dialogs.
		local
			color_imp: EV_COLOR_IMP
		do
			create Result
			color_imp ?= Result.implementation
			color_imp.set_with_system_id (Wel_color_constants.Color_btnface)
		end

	Color_3d_highlight: EV_COLOR
			-- Used for 3D-effects (light color)
			-- Name "color highlight"
		local
			color_imp: EV_COLOR_IMP
		do
			create Result
			color_imp ?= Result.implementation
			color_imp.set_with_system_id
				(Wel_color_constants.Color_btnhighlight)
		end

	Color_3d_shadow: EV_COLOR
			-- Used for 3D-effects (dark color)
			-- Name "color shadow"
		local
			color_imp: EV_COLOR_IMP
		do
			create Result
			color_imp ?= Result.implementation
			color_imp.set_with_system_id (Wel_color_constants.Color_btnshadow)
		end

	Color_read_only: EV_COLOR
			-- Color usually used for the background of editable
			-- widgets when they are read_only.
		local
			color_imp: EV_COLOR_IMP
		do
			create Result
			color_imp ?= Result.implementation
			color_imp.set_with_system_id
				(Wel_color_constants.Color_inactiveborder)
		end

	Color_read_write: EV_COLOR
			-- Color usely used for the background of editable
			-- widgets when they are in read / write mode.
		do
			create Result.make_with_rgb (1, 1, 1)
		end

	default_background_color: EV_COLOR
			-- Default background color for most widgets.
		do
			Result := Color_dialog
		end

	default_foreground_color: EV_COLOR
			-- Default foreground color for most widgets.
		do
			create Result.make_with_rgb (0, 0, 0)
		end

feature {NONE} -- Constants

	wel_color_constants: WEL_COLOR_CONSTANTS
		once
			create Result
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




end -- class EV_STOCK_COLORS_IMP

