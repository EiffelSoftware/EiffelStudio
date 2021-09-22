note
	description: "Facilities for accessing default pixmaps."
	author: "Daniel Furrer"
	keywords	: "pixmap, default"
	date: "$Date$"
	revision: "$Revision$"

-- TODO find the icons by tag instead of using fixed icon paths (probably by using NS_WORKSPACE and constants from IconsCore)

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
			Result.set_with_named_file ("/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/ToolbarInfo.icns")
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

feature -- Icon names

	icons_names: detachable LIST [READABLE_STRING_32]
			-- Platform dependent icons names
			-- may not be implemented on all platforms.
		do
			-- TODO: not yet implemented.
		end

end -- class EV_STOCK_PIXMAPS_IMP
