indexing
	description	: "Facilities for accessing default pixmaps."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords	: "pixmap, default"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EV_STOCK_PIXMAPS_IMP

inherit
	EV_ANY_HANDLER

feature -- Access

	Information_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing a piece of information.
		do
			Result := pixmap_from_stock_id ("gtk-dialog-info")
		end

	Error_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing an error.
		do
			Result := pixmap_from_stock_id ("gtk-dialog-error")
		end

	Warning_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing a warning.
		do
			Result := pixmap_from_stock_id ("gtk-dialog-warning")
		end

	Question_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing a question.
		do
			Result := pixmap_from_stock_id ("gtk-dialog-question")
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
			pixmap_imp: EV_PIXMAP_I
		do
				-- Create a default pixmap
			create Result
				-- Initialize the pixmap with the icon
			pixmap_imp := Result.implementation
			pixmap_imp.set_with_default
		end

feature -- Default cursors

	Busy_cursor: EV_POINTER_STYLE is
			-- Standard arrow and small hourglass
		do
			create Result.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.busy_cursor)
		end

	Standard_cursor: EV_POINTER_STYLE is
			-- Standard arrow
		do
			create Result.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.standard_cursor)
		end

	Crosshair_cursor: EV_POINTER_STYLE is
			-- Crosshair
		do
			create Result.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.crosshair_cursor)
			Result.set_x_hotspot (15)
			Result.set_y_hotspot (15)
		end

	Help_cursor: EV_POINTER_STYLE is
			-- Arrow and question mark
		do
			create Result.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.help_cursor)
		end

	Ibeam_cursor: EV_POINTER_STYLE is
			-- I-beam
		do
			create Result.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.ibeam_cursor)
			Result.set_x_hotspot (7)
			Result.set_y_hotspot (10)
		end

	No_cursor: EV_POINTER_STYLE is
			-- Slashed_circle
		do
			create Result.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.no_cursor)
			Result.set_x_hotspot (10)
			Result.set_y_hotspot (10)
		end

	Sizeall_cursor: EV_POINTER_STYLE is
			-- Four-pointed arrow pointing north, south, east and west
		do
			create Result.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.sizeall_cursor)
			Result.set_x_hotspot (8)
			Result.set_y_hotspot (8)
		end

	Sizens_cursor: EV_POINTER_STYLE is
			-- Double-pointed arrow pointing north and south
		do
			create Result.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.sizens_cursor)
			Result.set_x_hotspot (5)
			Result.set_y_hotspot (7)
		end

	Sizenwse_cursor: EV_POINTER_STYLE is
			-- Double-pointed arrow pointing north-west and south-east
		do
			create Result.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.sizenwse_cursor)
			Result.set_x_hotspot (8)
			Result.set_y_hotspot (7)
		end

	Sizenesw_cursor: EV_POINTER_STYLE is
			-- Double-pointed arrow pointing north-east and south-west
		do
			create Result.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.sizenesw_cursor)
			Result.set_x_hotspot (7)
			Result.set_y_hotspot (7)
		end

	Sizewe_cursor: EV_POINTER_STYLE is
			-- Double-pointed arrow pointing west and east
		do
			create Result.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.sizewe_cursor)
			Result.set_x_hotspot (7)
			Result.set_y_hotspot (5)
		end

	Uparrow_cursor: EV_POINTER_STYLE is
			-- Vertical arrow
		do
			create Result.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.uparrow_cursor)
			Result.set_x_hotspot (0)
			Result.set_y_hotspot (5)
		end

	Wait_cursor: EV_POINTER_STYLE is
			-- Hourglass
		do
			create Result.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.busy_cursor)
			Result.set_x_hotspot (16)
			Result.set_y_hotspot (16)
		end

feature {NONE} -- Implementation

	pixmap_from_stock_id (a_stock_id: EV_GTK_C_STRING): EV_PIXMAP is
			-- Retrieve pixmap from gtk stock id
		local
			a_cs: EV_GTK_C_STRING
			pixmap_imp: EV_PIXMAP_IMP
			retried: BOOLEAN
		do
			if not retried then
				a_cs := a_stock_id
				create Result
				pixmap_imp ?= Result.implementation
				pixmap_imp.set_from_stock_id (a_cs.item)
			else
				create Result
			end
		rescue
			retried := True
			retry
		end

feature {EV_ANY_HANDLER} -- Externals

	frozen information_pixmap_xpm: POINTER is
		external
			"C | %"ev_c_util.h%""
		alias
			"information_pixmap_xpm"
		end

	frozen error_pixmap_xpm: POINTER is
		external
			"C | %"ev_c_util.h%""
		alias
			"error_pixmap_xpm"
		end

	frozen warning_pixmap_xpm: POINTER is
		external
			"C | %"ev_c_util.h%""
		alias
			"warning_pixmap_xpm"
		end

	frozen question_pixmap_xpm: POINTER is
		external
			"C | %"ev_c_util.h%""
		alias
			"question_pixmap_xpm"
		end

	frozen collate_pixmap_xpm: POINTER is
		external
			"C | %"ev_c_util.h%""
		alias
			"collate_pixmap_xpm"
		end

	frozen no_collate_pixmap_xpm: POINTER is
		external
			"C | %"ev_c_util.h%""
		alias
			"no_collate_pixmap_xpm"
		end

	frozen landscape_pixmap_xpm: POINTER is
		external
			"C | %"ev_c_util.h%""
		alias
			"landscape_pixmap_xpm"
		end

	frozen portrait_pixmap_xpm: POINTER is
		external
			"C | %"ev_c_util.h%""
		alias
			"portrait_pixmap_xpm"
		end

	frozen busy_cursor_xpm: POINTER is
		external
			"C | %"ev_c_util.h%""
		alias
			"busy_cursor_xpm"
		end

	frozen crosshair_cursor_xpm: POINTER is
		external
			"C | %"ev_c_util.h%""
		alias
			"crosshair_cursor_xpm"
		end

	frozen help_cursor_xpm: POINTER is
		external
			"C | %"ev_c_util.h%""
		alias
			"help_cursor_xpm"
		end

	frozen ibeam_cursor_xpm: POINTER is
		external
			"C | %"ev_c_util.h%""
		alias
			"ibeam_cursor_xpm"
		end

	frozen no_cursor_xpm: POINTER is
		external
			"C | %"ev_c_util.h%""
		alias
			"no_cursor_xpm"
		end

	frozen sizeall_cursor_xpm: POINTER is
		external
			"C | %"ev_c_util.h%""
		alias
			"sizeall_cursor_xpm"
		end

	frozen sizenesw_cursor_xpm: POINTER is
		external
			"C | %"ev_c_util.h%""
		alias
			"sizenesw_cursor_xpm"
		end

	frozen sizens_cursor_xpm: POINTER is
		external
			"C | %"ev_c_util.h%""
		alias
			"sizens_cursor_xpm"
		end

	frozen sizenwse_cursor_xpm: POINTER is
		external
			"C | %"ev_c_util.h%""
		alias
			"sizenwse_cursor_xpm"
		end

	frozen sizewe_cursor_xpm: POINTER is
		external
			"C | %"ev_c_util.h%""
		alias
			"sizewe_cursor_xpm"
		end

	frozen standard_cursor_xpm: POINTER is
		external
			"C | %"ev_c_util.h%""
		alias
			"standard_cursor_xpm"
		end

	frozen uparrow_cursor_xpm: POINTER is
		external
			"C | %"ev_c_util.h%""
		alias
			"uparrow_cursor_xpm"
		end

	frozen wait_cursor_xpm: POINTER is
		external
			"C | %"ev_c_util.h%""
		alias
			"wait_cursor_xpm"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_STOCK_PIXMAPS_IMP

