indexing
	description	: "Facilities for accessing default pixmaps."
	keywords	: "pixmap, default"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EV_STOCK_PIXMAPS_IMP

feature -- Access

	Information_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing a piece of information.
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			create Result
			pixmap_imp ?= Result.implementation
			pixmap_imp.set_from_xpm_data (information_pixmap_xpm)
		end

	Error_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing an error.
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			create Result
			pixmap_imp ?= Result.implementation
			pixmap_imp.set_from_xpm_data (error_pixmap_xpm)
		end

	Warning_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing a warning.
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			create Result
			pixmap_imp ?= Result.implementation
			pixmap_imp.set_from_xpm_data (warning_pixmap_xpm)
		end

	Question_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing a question.
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			create Result
			pixmap_imp ?= Result.implementation
			pixmap_imp.set_from_xpm_data (question_pixmap_xpm)
		end

	Collate_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing collated printing.
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			create Result
			pixmap_imp ?= Result.implementation
			pixmap_imp.set_from_xpm_data (collate_pixmap_xpm)
		end

	No_collate_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing non collated printing.
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			create Result
			pixmap_imp ?= Result.implementation
			pixmap_imp.set_from_xpm_data (no_collate_pixmap_xpm)
		end

	Landscape_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing landscape printing.
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			create Result
			pixmap_imp ?= Result.implementation
			pixmap_imp.set_from_xpm_data (landscape_pixmap_xpm)
		end

	Portrait_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing portrait printing.
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			create Result
			pixmap_imp ?= Result.implementation
			pixmap_imp.set_from_xpm_data (portrait_pixmap_xpm)
		end

	Default_window_icon: EV_PIXMAP is
			-- Pixmap used as default icon for new windows.
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
				-- Create a default pixmap
			create Result
			pixmap_imp ?= Result.implementation
			check
				pixmap_imp_not_void: pixmap_imp /= Void
			end

				-- Initialize the pixmap with the icon
			pixmap_imp ?= Result.implementation
			pixmap_imp.set_with_default
		end

feature -- Default cursors

	Busy_cursor: EV_CURSOR is
			-- Standard arrow and small hourglass
		do
			create Result
		end

	Standard_cursor: EV_CURSOR is
			-- Standard arrow
		do
			create Result
		end

	Crosshair_cursor: EV_CURSOR is
			-- Crosshair
		do
			create Result
		end

	Help_cursor: EV_CURSOR is
			-- Arrow and question mark
		do
			create Result
		end

	Ibeam_cursor: EV_CURSOR is
			-- I-beam
		do
			create Result
		end

	No_cursor: EV_CURSOR is
			-- Slashed_circle
		do
			create Result
		end

	Sizeall_cursor: EV_CURSOR is
			-- Four-pointed arrow pointing north, south, east and west
		do
			create Result
		end

	Sizens_cursor: EV_CURSOR is
			-- Double-pointed arrow pointing north and south
		do
			create Result
		end

	Sizenwse_cursor: EV_CURSOR is
			-- Double-pointed arrow pointing north-west and south-east
		do
			create Result
		end

	Sizenesw_cursor: EV_CURSOR is
			-- Double-pointed arrow pointing north-east and south-west
		do
			create Result
		end

	Sizewe_cursor: EV_CURSOR is
			-- Double-pointed arrow pointing west and east
		do
			create Result
		end

	Uparrow_cursor: EV_CURSOR is
			-- Vertical arrow
		do
			create Result
		end

	Wait_cursor: EV_CURSOR is
			-- Hourglass
		do
			create Result
		end

feature {NONE} -- Externals

	C: EV_C_EXTERNALS is
		once
			create Result
		end

	information_pixmap_xpm: POINTER is
		external
			"C [macro %"ev_c_util.h%"]"
		alias
			"information_pixmap_xpm"
		end

	error_pixmap_xpm: POINTER is
		external
			"C [macro %"ev_c_util.h%"]"
		alias
			"error_pixmap_xpm"
		end

	warning_pixmap_xpm: POINTER is
		external
			"C [macro %"ev_c_util.h%"]"
		alias
			"warning_pixmap_xpm"
		end

	question_pixmap_xpm: POINTER is
		external
			"C [macro %"ev_c_util.h%"]"
		alias
			"question_pixmap_xpm"
		end

	collate_pixmap_xpm: POINTER is
		external
			"C [macro %"ev_c_util.h%"]"
		alias
			"collate_pixmap_xpm"
		end

	no_collate_pixmap_xpm: POINTER is
		external
			"C [macro %"ev_c_util.h%"]"
		alias
			"no_collate_pixmap_xpm"
		end

	landscape_pixmap_xpm: POINTER is
		external
			"C [macro %"ev_c_util.h%"]"
		alias
			"landscape_pixmap_xpm"
		end

	portrait_pixmap_xpm: POINTER is
		external
			"C [macro %"ev_c_util.h%"]"
		alias
			"portrait_pixmap_xpm"
		end

	GDK_WATCH: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_WATCH"
		end

	GDK_ARROW: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_ARROW"
		end

	GDK_CROSSHAIR: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_CROSSHAIR"
		end

	GDK_XTERM: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_XTERM"
		end

	GDK_CROSS_REVERSE: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_CROSS_REVERSE"
		end

	GDK_FLEUR: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_FLEUR"
		end

	GDK_SB_V_DOUBLE_ARROW: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_SB_V_DOUBLE_ARROW"
		end

	GDK_SB_H_DOUBLE_ARROW: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_SB_H_DOUBLE_ARROW"
		end

	GDK_SB_UP_ARROW: INTEGER is
		external
			"C [macro <gdk/gdktypes.h>]"
		alias
			"GDK_SB_UP_ARROW"
		end

end -- class EV_STOCK_PIXMAPS_IMP

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

