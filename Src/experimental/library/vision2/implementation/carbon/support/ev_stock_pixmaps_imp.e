note
	description	: "Facilities for accessing default pixmaps."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords	: "pixmap, default"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EV_STOCK_PIXMAPS_IMP

feature -- Access

	Information_pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer symbolizing a piece of information.
		do
			create Result
		end

	Error_pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer symbolizing an error.
		do
			create Result
		end

	Warning_pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer symbolizing a warning.
		do
			create Result
		end

	Question_pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer symbolizing a question.
		do
			create Result
		end

	Information_pixmap: EV_PIXMAP
			-- Pixmap symbolizing a piece of information.
		do
			create Result
		end

	Error_pixmap: EV_PIXMAP
			-- Pixmap symbolizing an error.
		do
			create Result
		end

	Warning_pixmap: EV_PIXMAP
			-- Pixmap symbolizing a warning.
		do
			create Result
		end

	Question_pixmap: EV_PIXMAP
			-- Pixmap symbolizing a question.
		do
			create Result
		end

	Collate_pixmap: EV_PIXMAP
			-- Pixmap symbolizing collated printing.
		do
			create Result
		end

	No_collate_pixmap: EV_PIXMAP
			-- Pixmap symbolizing non collated printing.
		do
			create Result
		end

	Landscape_pixmap: EV_PIXMAP
			-- Pixmap symbolizing landscape printing.
		do
			create Result
		end

	Portrait_pixmap: EV_PIXMAP
			-- Pixmap symbolizing portrait printing.
		do
			create Result
		end

	Default_window_icon: EV_PIXMAP
			-- Pixmap used as default icon for new windows.
		do
			create Result
		end

feature -- Default cursors

	Busy_cursor: EV_CURSOR
			-- Standard arrow and small hourglass
		do
			create Result
		end

	Standard_cursor: EV_CURSOR
			-- Standard arrow
		do
			create Result
		end

	Crosshair_cursor: EV_CURSOR
			-- Crosshair
		do
			create Result
		end

	Help_cursor: EV_CURSOR
			-- Arrow and question mark
		do
			create Result
		end

	Ibeam_cursor: EV_CURSOR
			-- I-beam
		do
			create Result
		end

	No_cursor: EV_CURSOR
			-- Slashed_circle
		do
			create Result
		end

	Sizeall_cursor: EV_CURSOR
			-- Four-pointed arrow pointing north, south, east and west
		do
			create Result
		end

	Sizens_cursor: EV_CURSOR
			-- Double-pointed arrow pointing north and south
		do
			create Result
		end

	Sizenwse_cursor: EV_CURSOR
			-- Double-pointed arrow pointing north-west and south-east
		do
			create Result
		end

	Sizenesw_cursor: EV_CURSOR
			-- Double-pointed arrow pointing north-east and south-west
		do
			create Result
		end

	Sizewe_cursor: EV_CURSOR
			-- Double-pointed arrow pointing west and east
		do
			create Result
		end

	Uparrow_cursor: EV_CURSOR
			-- Vertical arrow
		do
			create Result
		end

	Wait_cursor: EV_CURSOR
			-- Hourglass
		do
			create Result
		end

note
	copyright:	"Copyright (c) 2006, The Eiffel.Mac Team"
end -- class EV_STOCK_PIXMAPS_IMP

