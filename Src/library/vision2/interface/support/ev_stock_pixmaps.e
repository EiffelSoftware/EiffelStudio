
note
	description:
		"Facilities for accessing default pixmaps."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "pixmap, default"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_STOCK_PIXMAPS

feature -- Default pixmaps

	Information_pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer symbolizing a piece of information.
		once
			Result := Implementation.Information_pixel_buffer
		end

	Error_pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer symbolizing an error.
		once
			Result := Implementation.Error_pixel_buffer
		end

	Warning_pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer symbolizing a warning.
		once
			Result := Implementation.Warning_pixel_buffer
		end

	Question_pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer symbolizing a question.
		once
			Result := Implementation.Question_pixel_buffer
		end

	Information_pixmap: EV_PIXMAP
			-- Pixmap symbolizing a piece of information.
		once
			Result := Implementation.Information_pixmap
		end

	Error_pixmap: EV_PIXMAP
			-- Pixmap symbolizing an error.
		once
			Result := Implementation.Error_pixmap
		end

	Warning_pixmap: EV_PIXMAP
			-- Pixmap symbolizing a warning.
		once
			Result := Implementation.Warning_pixmap
		end

	Question_pixmap: EV_PIXMAP
			-- Pixmap symbolizing a question.
		once
			Result := Implementation.Question_pixmap
		end

	Default_window_icon: EV_PIXMAP
			-- Pixmap used as default icon for new windows.
		once
			Result := Implementation.Default_window_icon
		end

feature -- Default cursors

	Busy_cursor: EV_POINTER_STYLE
			-- Standard arrow and small hourglass
		once
			create Result.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.busy_cursor)
		end

	Standard_cursor: EV_POINTER_STYLE
			-- Standard arrow
		once
			create Result.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.standard_cursor)
		end

	Crosshair_cursor: EV_POINTER_STYLE
			-- Crosshair
		once
			create Result.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.crosshair_cursor)
		end

	Help_cursor: EV_POINTER_STYLE
			-- Arrow and question mark
		once
			create Result.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.help_cursor)
		end

	Ibeam_cursor: EV_POINTER_STYLE
			-- I-beam
		once
			create Result.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.ibeam_cursor)
		end

	No_cursor: EV_POINTER_STYLE
			-- Slashed_circle
		once
			create Result.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.no_cursor)
		end

	Sizeall_cursor: EV_POINTER_STYLE
			-- Four-pointed arrow pointing north, south, east and west
		once
			create Result.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.sizeall_cursor)
		end

	Sizens_cursor: EV_POINTER_STYLE
			-- Double-pointed arrow pointing north and south
		once
			create Result.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.sizens_cursor)
		end

	Sizenwse_cursor: EV_POINTER_STYLE
			-- Double-pointed arrow pointing north-west and south-east
		once
			create Result.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.sizenwse_cursor)
		end

	Sizenesw_cursor: EV_POINTER_STYLE
			-- Double-pointed arrow pointing north-east and south-west
		once
			create Result.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.sizenesw_cursor)
		end

	Sizewe_cursor: EV_POINTER_STYLE
			-- Double-pointed arrow pointing west and east
		once
			create Result.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.sizewe_cursor)
		end

	Uparrow_cursor: EV_POINTER_STYLE
			-- Vertical arrow
		once
			create Result.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.uparrow_cursor)
		end

	Wait_cursor: EV_POINTER_STYLE
			-- Hourglass
		once
			create Result.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.wait_cursor)
		end

	Header_sizewe_cursor: EV_POINTER_STYLE
			-- Cursor used when resizing header widget columns.
		once
			create Result.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.header_sizewe_cursor)
		end

	Hyperlink_cursor: EV_POINTER_STYLE
			-- Cursor used when over a hyperlink.
		once
			create Result.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.hyperlink_cursor)
		end

feature {EV_ANY, EV_ANY_I, EV_ANY_HANDLER} -- Implementation

	Implementation: EV_STOCK_PIXMAPS_IMP
			-- Responsible for interaction with native graphics toolkit.
		once
			create Result
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




end -- class EV_STOCK_PIXMAPS

