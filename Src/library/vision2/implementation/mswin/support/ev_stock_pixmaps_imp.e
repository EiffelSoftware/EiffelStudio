note
	description: "Facilities for accessing default%
				  %pixmaps and cursors"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "pixmap, cursor, default"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_STOCK_PIXMAPS_IMP

inherit
	EV_ANY_HANDLER

	WEL_SYSTEM_METRICS

feature {NONE} -- Initialization

feature -- Default pixmaps

	Information_pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel Buffer symbolizing a piece of information.
		do
			Result := build_default_pixel_buffer ({WEL_IDI_CONSTANTS}.Idi_information)
		end

	Error_pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel Buffer symbolizing an error.
		do
			Result := build_default_pixel_buffer ({WEL_IDI_CONSTANTS}.Idi_error)
		end

	Warning_pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel Buffer symbolizing a warning.
		do
			Result := build_default_pixel_buffer ({WEL_IDI_CONSTANTS}.Idi_warning)
		end

	Question_pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel Buffer symbolizing a question.
		do
			Result := build_default_pixel_buffer ({WEL_IDI_CONSTANTS}.Idi_question)
		end

	Information_pixmap: EV_PIXMAP
			-- Pixmap symbolizing a piece of information.
		do
			Result := build_default_pixmap ({WEL_IDI_CONSTANTS}.Idi_information)
		end

	Error_pixmap: EV_PIXMAP
			-- Pixmap symbolizing an error.
		do
			Result := build_default_pixmap ({WEL_IDI_CONSTANTS}.Idi_error)
		end

	Warning_pixmap: EV_PIXMAP
			-- Pixmap symbolizing a warning.
		do
			Result := build_default_pixmap ({WEL_IDI_CONSTANTS}.Idi_warning)
		end

	Question_pixmap: EV_PIXMAP
			-- Pixmap symbolizing a question.
		do
			Result := build_default_pixmap ({WEL_IDI_CONSTANTS}.Idi_question)
		end

	Default_window_icon: EV_PIXMAP
			-- Pixmap used as default icon for new windows
			-- (Vision2 logo)
		local
			pixmap_imp: detachable EV_PIXMAP_IMP
		do
				-- Create a default pixmap
			create Result

				-- Initialize the pixmap with the icon
			pixmap_imp ?= Result.implementation
			check pixmap_imp /= Void then end
			pixmap_imp.set_with_default
		end

feature {NONE} -- Implementation

	build_default_pixel_buffer (Idi_constant: POINTER): EV_PIXEL_BUFFER
			-- Create the pixel buffer corresponding to the
			-- Windows Icon constants `Idi_constant'.
		local
			pixbuf_imp: detachable EV_PIXEL_BUFFER_IMP
			wel_icon: WEL_ICON
		do
				-- Create a default pixel buffer
			create Result

				-- Read the predefined Cursor.
			create wel_icon.make_by_predefined_id (Idi_constant)
			wel_icon.enable_reference_tracking
			pixbuf_imp ?= Result.implementation
			check pixbuf_imp /= Void then end
			pixbuf_imp.set_from_icon (wel_icon)
			wel_icon.decrement_reference
		end

	build_default_pixmap (Idi_constant: POINTER): EV_PIXMAP
			-- Create the pixmap corresponding to the
			-- Windows Icon constants `Idi_constant'.
		local
			pixmap_imp: detachable EV_PIXMAP_IMP
			wel_icon: WEL_ICON
		do
				-- Create a default pixmap
			create Result

				-- Read the predefined Cursor.
			create wel_icon.make_by_predefined_id (Idi_constant)
			wel_icon.enable_reference_tracking

				-- Initialize the pixmap with the icon
			pixmap_imp ?= Result.implementation
			check pixmap_imp /= Void then end
			pixmap_imp.set_with_resource (wel_icon)

			wel_icon.decrement_reference
		end

feature -- Icon names

	icons_names: detachable LIST [READABLE_STRING_32]
			-- Platform dependent icons names
			-- may not be implemented on all platforms.
		do
			-- TODO: not yet implemented.
		end

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_STOCK_PIXMAPS_IMP










