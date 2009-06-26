note
	description	: "Facilities for accessing default pixmaps."
	author		: "Daniel Furrer"
	keywords	: "pixmap, default"
	date		: "$Date$"
	revision	: "$Revision$"

-- TODO find the icons by tag instead of using fixed icon paths (probably by using NS_WORKSPACE and constants from IconsCore)
-- TODO Load cursors

class
	EV_STOCK_PIXMAPS_IMP

inherit
	NS_IMAGE_CONSTANTS

	EV_ANY_HANDLER

feature -- Access

	Information_pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer symbolizing a piece of information.
		do
			create Result.make_with_pixmap (Information_pixmap)
		end

	Error_pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer symbolizing an error.
		do
			create Result.make_with_pixmap (Error_pixmap)
		end

	Warning_pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer symbolizing a warning.
		do
			create Result.make_with_pixmap (Warning_pixmap)
		end

	Question_pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer symbolizing a question.
		do
			create Result.make_with_pixmap (Question_pixmap)
		end

	Information_pixmap: EV_PIXMAP
			-- Pixmap symbolizing a piece of information.
		do
			create Result
			Result.set_with_named_file ("/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/ToolbarInfoIcon.icns")
			Result.stretch (32, 32)
		end

	Error_pixmap: EV_PIXMAP
			-- Pixmap symbolizing an error.
		do
			create Result
			Result.set_with_named_file ("/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/AlertStopIcon.icns")
			--Result.stretch (32, 32)
		end

	Warning_pixmap: EV_PIXMAP
			-- Pixmap symbolizing a warning.
		do
			create Result
			Result.set_with_named_file ("/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/AlertCautionIcon.icns")
			Result.stretch (32, 32)
		end

	Question_pixmap: EV_PIXMAP
			-- Pixmap symbolizing a question.
		do
			create Result
			Result.set_with_named_file ("/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/AlertNoteIcon.icns")
			Result.stretch (32, 32)
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
			Result.set_with_named_file ("/System/Library/Frameworks/AppKit.framework/Resources/NSDefaultApplicationIcon.tiff")
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

end -- class EV_STOCK_PIXMAPS_IMP
