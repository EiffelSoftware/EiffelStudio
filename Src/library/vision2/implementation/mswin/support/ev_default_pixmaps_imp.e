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

