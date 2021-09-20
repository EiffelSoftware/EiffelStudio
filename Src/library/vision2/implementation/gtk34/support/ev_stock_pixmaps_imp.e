note
	description: "Facilities for accessing default pixmaps."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "pixmap, default"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_STOCK_PIXMAPS_IMP

inherit
	EV_ANY_HANDLER

feature -- Access

	Information_pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer symbolizing a piece of information.
		do
			Result := information_pixmap
		end

	Error_pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer symbolizing an error.
		do
			Result := error_pixmap
		end

	Warning_pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer symbolizing a warning.
		do
			Result := warning_pixmap
		end

	Question_pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer symbolizing a question.
		do
			Result := question_pixmap
		end

	Information_pixmap: EV_PIXMAP
			-- Pixmap symbolizing a piece of information.
		do
			Result := pixmap_from_stock_id ("dialog-information")
		end

	Error_pixmap: EV_PIXMAP
			-- Pixmap symbolizing an error.
		do
			Result := pixmap_from_stock_id ("dialog-error")
		end

	Warning_pixmap: EV_PIXMAP
			-- Pixmap symbolizing a warning.
		do
			Result := pixmap_from_stock_id ("dialog-warning")
		end

	Question_pixmap: EV_PIXMAP
			-- Pixmap symbolizing a question.
		do
			Result := pixmap_from_stock_id ("dialog-question")
		end

	Collate_pixmap: EV_PIXMAP
			-- Pixmap symbolizing collated printing.
		local
			pixmap_imp: detachable EV_PIXMAP_IMP
		do
			create Result
			pixmap_imp ?= Result.implementation
			check pixmap_imp /= Void then end
			pixmap_imp.set_from_xpm_data (collate_pixmap_xpm)
		end

	No_collate_pixmap: EV_PIXMAP
			-- Pixmap symbolizing non collated printing.
		local
			pixmap_imp: detachable EV_PIXMAP_IMP
		do
			create Result
			pixmap_imp ?= Result.implementation
			check pixmap_imp /= Void then end
			pixmap_imp.set_from_xpm_data (no_collate_pixmap_xpm)
		end

	Landscape_pixmap: EV_PIXMAP
			-- Pixmap symbolizing landscape printing.
		local
			pixmap_imp: detachable EV_PIXMAP_IMP
		do
			create Result
			pixmap_imp ?= Result.implementation
			check pixmap_imp /= Void then end
			pixmap_imp.set_from_xpm_data (landscape_pixmap_xpm)
		end

	Portrait_pixmap: EV_PIXMAP
			-- Pixmap symbolizing portrait printing.
		local
			pixmap_imp: detachable EV_PIXMAP_IMP
		do
			create Result
			pixmap_imp ?= Result.implementation
			check pixmap_imp /= Void then end
			pixmap_imp.set_from_xpm_data (portrait_pixmap_xpm)
		end

	Default_window_icon: EV_PIXMAP
			-- Pixmap used as default icon for new windows.
		do
				-- Create a default pixmap.
			create Result
				-- Initialize the pixmap with the icon.
			Result.implementation.set_with_default
		end

feature {NONE} -- Implementation

	pixmap_from_stock_id (a_stock_id: EV_GTK_C_STRING): EV_PIXEL_BUFFER
			-- Retrieve pixmap from gtk stock id
		local
			a_cs: EV_GTK_C_STRING
			pixbuf_imp: detachable EV_PIXEL_BUFFER_IMP
			retried: BOOLEAN
		do
			if not retried then
				a_cs := a_stock_id
				create Result
				pixbuf_imp ?= Result.implementation
				check pixbuf_imp /= Void then end
				pixbuf_imp.set_from_stock_id (a_cs.item)
			else
				create Result
			end
		rescue
			retried := True
			retry
		end

feature {EV_ANY_HANDLER, EV_ANY_I} -- Externals

	frozen information_pixmap_xpm: POINTER
		external
			"C | %"ev_c_util.h%""
		alias
			"information_pixmap_xpm"
		ensure
			is_class: class
		end

	frozen error_pixmap_xpm: POINTER
		external
			"C | %"ev_c_util.h%""
		alias
			"error_pixmap_xpm"
		ensure
			is_class: class
		end

	frozen warning_pixmap_xpm: POINTER
		external
			"C | %"ev_c_util.h%""
		alias
			"warning_pixmap_xpm"
		ensure
			is_class: class
		end

	frozen question_pixmap_xpm: POINTER
		external
			"C | %"ev_c_util.h%""
		alias
			"question_pixmap_xpm"
		ensure
			is_class: class
		end

	frozen collate_pixmap_xpm: POINTER
		external
			"C | %"ev_c_util.h%""
		alias
			"collate_pixmap_xpm"
		ensure
			is_class: class
		end

	frozen no_collate_pixmap_xpm: POINTER
		external
			"C | %"ev_c_util.h%""
		alias
			"no_collate_pixmap_xpm"
		ensure
			is_class: class
		end

	frozen landscape_pixmap_xpm: POINTER
		external
			"C | %"ev_c_util.h%""
		alias
			"landscape_pixmap_xpm"
		ensure
			is_class: class
		end

	frozen portrait_pixmap_xpm: POINTER
		external
			"C | %"ev_c_util.h%""
		alias
			"portrait_pixmap_xpm"
		ensure
			is_class: class
		end

	frozen busy_cursor_xpm: POINTER
		external
			"C | %"ev_c_util.h%""
		alias
			"busy_cursor_xpm"
		ensure
			is_class: class
		end

	frozen crosshair_cursor_xpm: POINTER
		external
			"C | %"ev_c_util.h%""
		alias
			"crosshair_cursor_xpm"
		ensure
			is_class: class
		end

	frozen help_cursor_xpm: POINTER
		external
			"C | %"ev_c_util.h%""
		alias
			"help_cursor_xpm"
		ensure
			is_class: class
		end

	frozen ibeam_cursor_xpm: POINTER
		external
			"C | %"ev_c_util.h%""
		alias
			"ibeam_cursor_xpm"
		ensure
			is_class: class
		end

	frozen no_cursor_xpm: POINTER
		external
			"C | %"ev_c_util.h%""
		alias
			"no_cursor_xpm"
		ensure
			is_class: class
		end

	frozen sizeall_cursor_xpm: POINTER
		external
			"C | %"ev_c_util.h%""
		alias
			"sizeall_cursor_xpm"
		ensure
			is_class: class
		end

	frozen sizenesw_cursor_xpm: POINTER
		external
			"C | %"ev_c_util.h%""
		alias
			"sizenesw_cursor_xpm"
		ensure
			is_class: class
		end

	frozen sizens_cursor_xpm: POINTER
		external
			"C | %"ev_c_util.h%""
		alias
			"sizens_cursor_xpm"
		ensure
			is_class: class
		end

	frozen sizenwse_cursor_xpm: POINTER
		external
			"C | %"ev_c_util.h%""
		alias
			"sizenwse_cursor_xpm"
		ensure
			is_class: class
		end

	frozen sizewe_cursor_xpm: POINTER
		external
			"C | %"ev_c_util.h%""
		alias
			"sizewe_cursor_xpm"
		ensure
			is_class: class
		end

	frozen standard_cursor_xpm: POINTER
		external
			"C | %"ev_c_util.h%""
		alias
			"standard_cursor_xpm"
		ensure
			is_class: class
		end

	frozen uparrow_cursor_xpm: POINTER
		external
			"C | %"ev_c_util.h%""
		alias
			"uparrow_cursor_xpm"
		ensure
			is_class: class
		end

	frozen wait_cursor_xpm: POINTER
		external
			"C | %"ev_c_util.h%""
		alias
			"wait_cursor_xpm"
		ensure
			is_class: class
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
