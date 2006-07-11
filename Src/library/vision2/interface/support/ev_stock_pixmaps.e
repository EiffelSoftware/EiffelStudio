indexing
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

	Information_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing a piece of information.
		once
			Result := Implementation.Information_pixmap
		end

	Error_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing an error.
		once
			Result := Implementation.Error_pixmap
		end

	Warning_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing a warning.
		once
			Result := Implementation.Warning_pixmap
		end

	Question_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing a question.
		once
			Result := Implementation.Question_pixmap
		end

	Default_window_icon: EV_PIXMAP is
			-- Pixmap used as default icon for new windows.
		once
			Result := Implementation.Default_window_icon
		end

feature -- Default cursors

	Busy_cursor: EV_POINTER_STYLE is
			-- Standard arrow and small hourglass
		once
			Result := Implementation.Busy_cursor
		end

	Standard_cursor: EV_POINTER_STYLE is
			-- Standard arrow
		once
			Result := Implementation.Standard_cursor
		end

	Crosshair_cursor: EV_POINTER_STYLE is
			-- Crosshair
		once
			Result := Implementation.Crosshair_cursor
		end

	Help_cursor: EV_POINTER_STYLE is
			-- Arrow and question mark
		once
			Result := Implementation.Help_cursor
		end

	Ibeam_cursor: EV_POINTER_STYLE is
			-- I-beam displayed in editable widgets.
		once
			Result := Implementation.Ibeam_cursor
		end

	No_cursor: EV_POINTER_STYLE is
			-- Slashed_circle
		once
			Result := Implementation.No_cursor
		end

	Sizeall_cursor: EV_POINTER_STYLE is
			-- Four-pointed arrow pointing north, south, east and west
		once
			Result := Implementation.Sizeall_cursor
		end

	Sizens_cursor: EV_POINTER_STYLE is
			-- Double-pointed arrow pointing north and south
		once
			Result := Implementation.Sizens_cursor
		end

	Sizenwse_cursor: EV_POINTER_STYLE is
			-- Double-pointed arrow pointing north-west and south-east
		once
			Result := Implementation.Sizenwse_cursor
		end

	Sizenesw_cursor: EV_POINTER_STYLE is
			-- Double-pointed arrow pointing north-east and south-west
		once
			Result := Implementation.Sizenesw_cursor
		end

	Sizewe_cursor: EV_POINTER_STYLE is
			-- Double-pointed arrow pointing west and east
		once
			Result := Implementation.Sizewe_cursor
		end

	Uparrow_cursor: EV_POINTER_STYLE is
			-- Vertical arrow
		once
			Result := Implementation.Uparrow_cursor
		end

	Wait_cursor: EV_POINTER_STYLE is
			-- Hourglass
		once
			Result := Implementation.Wait_cursor
		end

feature {NONE} -- Implementation

	Implementation: EV_STOCK_PIXMAPS_IMP is
			-- Responsible for interaction with native graphics toolkit.
		once
			create Result
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




end -- class EV_STOCK_PIXMAPS

