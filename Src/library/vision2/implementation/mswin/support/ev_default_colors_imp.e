indexing
	description: "List of default colors used by the system.%
				% Mswindows implementation"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_STOCK_COLORS_IMP 

feature -- Access

	Color_dialog, Color_3d_face: EV_COLOR is
			-- Color usually used for the background of dialogs.
		local
			color_imp: EV_COLOR_IMP
		do
			create Result
			color_imp ?= Result.implementation
			color_imp.set_with_system_id (Wel_color_constants.Color_btnface)
		end

	Color_3d_highlight: EV_COLOR is
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

	Color_3d_shadow: EV_COLOR is
			-- Used for 3D-effects (dark color)
			-- Name "color shadow"
		local
			color_imp: EV_COLOR_IMP
		do
			create Result
			color_imp ?= Result.implementation
			color_imp.set_with_system_id (Wel_color_constants.Color_btnshadow)
		end

	Color_read_only: EV_COLOR is
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

	Color_read_write: EV_COLOR is
			-- Color usely used for the background of editable
			-- widgets when they are in read / write mode.
		do
			create Result.make_with_rgb (1, 1, 1)
		end

	default_background_color: EV_COLOR is
			-- Default background color for most widgets.
		do
			Result := Color_dialog
		end

	default_foreground_color: EV_COLOR is
			-- Default foreground color for most widgets.
		do
			create Result.make_with_rgb (0, 0, 0)
		end

feature {NONE} -- Constants

	wel_color_constants: WEL_COLOR_CONSTANTS is
		once
			create Result
		end

end -- class EV_STOCK_COLORS_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

