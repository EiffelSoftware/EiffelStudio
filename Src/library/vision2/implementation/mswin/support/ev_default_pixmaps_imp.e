indexing
	description	: "Facilities for accessing default%
				  %pixmaps and cursors"
	keywords	: "pixmap, cursor, default"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EV_STOCK_PIXMAPS_IMP

feature -- Default pixmaps

	Information_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing a piece of information.
		do
			Result := build_default_icon (Idi_constants.Idi_information)
		end

	Error_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing an error.
		do
			Result := build_default_icon (Idi_constants.Idi_error)
		end

	Warning_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing a warning.
		do
			Result := build_default_icon (Idi_constants.Idi_warning)
		end

	Question_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing a question.
		do
			Result := build_default_icon (Idi_constants.Idi_question)
		end

	Default_window_icon: EV_PIXMAP is
			-- Pixmap used as default icon for new windows 
			-- (Vision2 logo)
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
				-- Create a default pixmap
			create Result

				-- Initialize the pixmap with the icon
			pixmap_imp ?= Result.implementation
			pixmap_imp.set_with_default
		end

feature -- Default cursors

	Busy_cursor: EV_CURSOR is
			-- Standard arrow and small hourglass
		do
			Result := build_default_cursor (Idc_constants.Idc_appstarting)
		end

	Standard_cursor: EV_CURSOR is
			-- Standard arrow
		do
			Result := build_default_cursor (Idc_constants.Idc_arrow)
		end

	Crosshair_cursor: EV_CURSOR is
			-- Crosshair
		do
			Result := build_default_cursor (Idc_constants.Idc_cross)
		end

	Help_cursor: EV_CURSOR is
			-- Arrow and question mark
		do
			Result := build_default_cursor (Idc_constants.Idc_help)
		end

	Ibeam_cursor: EV_CURSOR is
			-- I-beam
		do
			Result := build_default_cursor (Idc_constants.Idc_ibeam)
		end

	No_cursor: EV_CURSOR is
			-- Slashed_circle
		do
			Result := build_default_cursor (Idc_constants.Idc_no)
		end

	Sizeall_cursor: EV_CURSOR is
			-- Four-pointed arrow pointing north, south, east and west
		do
			Result := build_default_cursor (Idc_constants.Idc_sizeall)
		end

	Sizenwse_cursor: EV_CURSOR is
			-- Double-pointed arrow pointing north-west and south-east
		do
			Result := build_default_cursor (Idc_constants.Idc_sizenwse)
		end

	Sizenesw_cursor: EV_CURSOR is
			-- Double-pointed arrow pointing north-east and south-west
		do
			Result := build_default_cursor (Idc_constants.Idc_sizenesw)
		end

	Sizens_cursor: EV_CURSOR is
			-- Double-pointed arrow pointing north and south
		do
			Result := build_default_cursor (Idc_constants.Idc_sizens)
		end

	Sizewe_cursor: EV_CURSOR is
			-- Double-pointed arrow pointing west and east
		do
			Result := build_default_cursor (Idc_constants.Idc_sizewe)
		end

	Uparrow_cursor: EV_CURSOR is
			-- Vertical arrow
		do
			Result := build_default_cursor (Idc_constants.Idc_uparrow)
		end

	Wait_cursor: EV_CURSOR is
			-- Hourglass
		do
			Result := build_default_cursor (Idc_constants.Idc_wait)
		end

feature {NONE} -- Implementation

	build_default_icon (Idi_constant: POINTER): EV_PIXMAP is
			-- Create the pixmap corresponding to the
			-- Windows Icon constants `Idi_constant'.
		local
			pixmap_imp: EV_PIXMAP_IMP
			wel_icon: WEL_ICON
		do
				-- Create a default pixmap
			create Result

				-- Read the predefined Cursor.
			create wel_icon.make_by_predefined_id (Idi_constant)
			wel_icon.enable_reference_tracking
			
				-- Initialize the pixmap with the icon
			pixmap_imp ?= Result.implementation
			pixmap_imp.set_with_resource (wel_icon)

			wel_icon.decrement_reference
		end

	build_default_cursor (Idc_constant: POINTER): EV_CURSOR is
			-- Create the pixmap corresponding to the
			-- Windows Cursor constants `Idc_constant'.
		local
			pixmap_imp: EV_PIXMAP_IMP
			wel_cursor: WEL_CURSOR
		do
				-- Create a default pixmap
			create Result

				-- Read the predefined Cursor.
			create wel_cursor.make_by_predefined_id (Idc_constant)
			wel_cursor.enable_reference_tracking
			
				-- Initialize the pixmap with the icon
			pixmap_imp ?= Result.implementation
			pixmap_imp.set_with_resource (wel_cursor)

				-- Set the hotspot of the cursor
			Result.set_x_hotspot (wel_cursor.x_hotspot)
			Result.set_y_hotspot (wel_cursor.y_hotspot)

			wel_cursor.decrement_reference
		end

feature {NONE} -- Constants

	Idi_constants: WEL_IDI_CONSTANTS is
		once
			create Result
		end

	Idc_constants: WEL_IDC_CONSTANTS is
		once
			create Result
		end

end -- class EV_STOCK_PIXMAPS_IMP

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--|-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.5  2001/07/14 12:46:25  manus
--| Replace --! by --|
--|
--| Revision 1.4  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.3  2001/06/07 23:08:13  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.1.2.7  2001/03/04 22:25:08  pichery
--| Added reference tracking
--|
--| Revision 1.1.2.6  2000/11/06 19:37:08  king
--| Accounted for default to stock name change
--|
--| Revision 1.1.2.5  2000/10/12 15:50:24  pichery
--| Added reference tracking for GDI objects to decrease
--| the number of GDI objects alive.
--|
--| Revision 1.1.2.4  2000/06/28 21:52:39  pichery
--| Fixed bug
--|
--| Revision 1.1.2.3  2000/06/28 21:41:58  pichery
--| Added 2 new default cursors: "Size North-East/South-West" and
--| "Size North-West/South-east"
--|
--| Revision 1.1.2.2  2000/05/04 04:24:53  pichery
--| - Implemented the new default cursors.
--| - Refactoring
--|
--| Revision 1.1.2.1  2000/05/03 19:09:17  oconnor
--| mergred from HEAD
--|
--| Revision 1.1  2000/05/03 16:35:40  pichery
--| New default pixmaps platform independent implementation
--|
--| Revision 1.2  2000/05/03 00:23:57  pichery
--| Added default window pixmap.
--|
--| Revision 1.1  2000/04/29 03:21:55  pichery
--| Added new class with Default pixmaps
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------

