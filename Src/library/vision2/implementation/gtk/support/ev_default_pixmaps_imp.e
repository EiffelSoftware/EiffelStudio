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
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			create Result
			pixmap_imp ?= Result.implementation
			pixmap_imp.set_from_xpm_data (busy_cursor_xpm)
		end

	Standard_cursor: EV_CURSOR is
			-- Standard arrow
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			create Result
			pixmap_imp ?= Result.implementation
			pixmap_imp.set_from_xpm_data (standard_cursor_xpm)
		end

	Crosshair_cursor: EV_CURSOR is
			-- Crosshair
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			create Result
			pixmap_imp ?= Result.implementation
			pixmap_imp.set_from_xpm_data (crosshair_cursor_xpm)
		end

	Help_cursor: EV_CURSOR is
			-- Arrow and question mark
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			create Result
			pixmap_imp ?= Result.implementation
			pixmap_imp.set_from_xpm_data (help_cursor_xpm)
		end

	Ibeam_cursor: EV_CURSOR is
			-- I-beam
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			create Result
			pixmap_imp ?= Result.implementation
			pixmap_imp.set_from_xpm_data (ibeam_cursor_xpm)
		end

	No_cursor: EV_CURSOR is
			-- Slashed_circle
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			create Result
			pixmap_imp ?= Result.implementation
			pixmap_imp.set_from_xpm_data (no_cursor_xpm)
		end

	Sizeall_cursor: EV_CURSOR is
			-- Four-pointed arrow pointing north, south, east and west
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			create Result
			pixmap_imp ?= Result.implementation
			pixmap_imp.set_from_xpm_data (sizeall_cursor_xpm)
		end

	Sizens_cursor: EV_CURSOR is
			-- Double-pointed arrow pointing north and south
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			create Result
			pixmap_imp ?= Result.implementation
			pixmap_imp.set_from_xpm_data (sizens_cursor_xpm)
		end

	Sizenwse_cursor: EV_CURSOR is
			-- Double-pointed arrow pointing north-west and south-east
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			create Result
			pixmap_imp ?= Result.implementation
			pixmap_imp.set_from_xpm_data (sizenwse_cursor_xpm)
		end

	Sizenesw_cursor: EV_CURSOR is
			-- Double-pointed arrow pointing north-east and south-west
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			create Result
			pixmap_imp ?= Result.implementation
			pixmap_imp.set_from_xpm_data (sizenesw_cursor_xpm)
		end

	Sizewe_cursor: EV_CURSOR is
			-- Double-pointed arrow pointing west and east
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			create Result
			pixmap_imp ?= Result.implementation
			pixmap_imp.set_from_xpm_data (sizewe_cursor_xpm)
		end

	Uparrow_cursor: EV_CURSOR is
			-- Vertical arrow
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			create Result
			pixmap_imp ?= Result.implementation
			pixmap_imp.set_from_xpm_data (uparrow_cursor_xpm)
		end

	Wait_cursor: EV_CURSOR is
			-- Hourglass
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			create Result
			pixmap_imp ?= Result.implementation
			pixmap_imp.set_from_xpm_data (wait_cursor_xpm)
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
		
	busy_cursor_xpm: POINTER is
		external
			"C [macro %"ev_c_util.h%"]"
		alias
			"busy_cursor_xpm"
		end
		
	crosshair_cursor_xpm: POINTER is
		external
			"C [macro %"ev_c_util.h%"]"
		alias
			"crosshair_cursor_xpm"
		end
		
	help_cursor_xpm: POINTER is
		external
			"C [macro %"ev_c_util.h%"]"
		alias
			"help_cursor_xpm"
		end
		
	ibeam_cursor_xpm: POINTER is
		external
			"C [macro %"ev_c_util.h%"]"
		alias
			"ibeam_cursor_xpm"
		end
		
	no_cursor_xpm: POINTER is
		external
			"C [macro %"ev_c_util.h%"]"
		alias
			"no_cursor_xpm"
		end
		
	sizeall_cursor_xpm: POINTER is
		external
			"C [macro %"ev_c_util.h%"]"
		alias
			"sizeall_cursor_xpm"
		end
		
	sizenesw_cursor_xpm: POINTER is
		external
			"C [macro %"ev_c_util.h%"]"
		alias
			"sizenesw_cursor_xpm"
		end
		
	sizens_cursor_xpm: POINTER is
		external
			"C [macro %"ev_c_util.h%"]"
		alias
			"sizens_cursor_xpm"
		end
		
	sizenwse_cursor_xpm: POINTER is
		external
			"C [macro %"ev_c_util.h%"]"
		alias
			"sizenwse_cursor_xpm"
		end
		
	sizewe_cursor_xpm: POINTER is
		external
			"C [macro %"ev_c_util.h%"]"
		alias
			"sizewe_cursor_xpm"
		end
	
	standard_cursor_xpm: POINTER is
		external
			"C [macro %"ev_c_util.h%"]"
		alias
			"standard_cursor_xpm"
		end
		
	uparrow_cursor_xpm: POINTER is
		external
			"C [macro %"ev_c_util.h%"]"
		alias
			"busy_cursor_xpm"
		end
		
	wait_cursor_xpm: POINTER is
		external
			"C [macro %"ev_c_util.h%"]"
		alias
			"busy_cursor_xpm"
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

