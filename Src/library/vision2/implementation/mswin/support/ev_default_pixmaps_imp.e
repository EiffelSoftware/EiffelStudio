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

	Information_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing a piece of information.
		do
			Result := build_default_icon ({WEL_IDI_CONSTANTS}.Idi_information)
		end

	Error_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing an error.
		do
			Result := build_default_icon ({WEL_IDI_CONSTANTS}.Idi_error)
		end

	Warning_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing a warning.
		do
			Result := build_default_icon ({WEL_IDI_CONSTANTS}.Idi_warning)
		end

	Question_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing a question.
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
		end

	No_cursor: EV_POINTER_STYLE is
			-- Slashed_circle
		do
			create Result.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.no_cursor)
		end

	Sizeall_cursor: EV_POINTER_STYLE is
			-- Four-pointed arrow pointing north, south, east and west
		do
			create Result.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.sizeall_cursor)
		end

	Sizens_cursor: EV_POINTER_STYLE is
			-- Double-pointed arrow pointing north and south
		do
			create Result.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.sizens_cursor)
		end

	Sizenwse_cursor: EV_POINTER_STYLE is
			-- Double-pointed arrow pointing north-west and south-east
		do
			create Result.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.sizenwse_cursor)
		end

	Sizenesw_cursor: EV_POINTER_STYLE is
			-- Double-pointed arrow pointing north-east and south-west
		do
			create Result.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.sizenesw_cursor)
		end

	Sizewe_cursor: EV_POINTER_STYLE is
			-- Double-pointed arrow pointing west and east
		do
			create Result.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.sizewe_cursor)
		end

	Uparrow_cursor: EV_POINTER_STYLE is
			-- Vertical arrow
		do
			create Result.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.uparrow_cursor)
		end

	Wait_cursor: EV_POINTER_STYLE is
			-- Hourglass
		do
			create Result.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.wait_cursor)
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

