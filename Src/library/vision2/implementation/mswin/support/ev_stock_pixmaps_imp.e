indexing
	description	: "Facilities for accessing default%
				  %pixmaps and cursors"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords	: "pixmap, cursor, default"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EV_STOCK_PIXMAPS_IMP

inherit
	EV_ANY_HANDLER

feature -- Default pixmaps

	Information_pixmap: EV_PIXEL_BUFFER is
			-- Pixel Buffer symbolizing a piece of information.
		do
			Result := build_default_icon ({WEL_IDI_CONSTANTS}.Idi_information)
		end

	Error_pixmap: EV_PIXEL_BUFFER is
			-- Pixel Buffer symbolizing an error.
		do
			Result := build_default_icon ({WEL_IDI_CONSTANTS}.Idi_error)
		end

	Warning_pixmap: EV_PIXEL_BUFFER is
			-- Pixel Buffer symbolizing a warning.
		do
			Result := build_default_icon ({WEL_IDI_CONSTANTS}.Idi_warning)
		end

	Question_pixmap: EV_PIXEL_BUFFER is
			-- Pixel Buffer symbolizing a question.
		do
			Result := build_default_icon ({WEL_IDI_CONSTANTS}.Idi_question)
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

feature {NONE} -- Implementation

	build_default_icon (Idi_constant: POINTER): EV_PIXEL_BUFFER is
			-- Create the pixmap corresponding to the
			-- Windows Icon constants `Idi_constant'.
		local
			pixbuf_imp: EV_PIXEL_BUFFER_IMP
			wel_icon: WEL_ICON
		do
				-- Create a default pixmap
			create Result

				-- Read the predefined Cursor.
			create wel_icon.make_by_predefined_id (Idi_constant)
			wel_icon.enable_reference_tracking

				-- Initialize the pixel buffer with the icon
			pixbuf_imp ?= Result.implementation
			pixbuf_imp.set_from_icon (wel_icon)

			wel_icon.decrement_reference
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

