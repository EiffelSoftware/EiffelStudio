indexing
	description:
		"Facilities for accessing default pixmaps."
	status: "See notice at end of class"
	keywords: "pixmap, default"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_STOCK_PIXMAPS

feature -- Default pixmaps

	Information_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing a piece of information.
		once
			Result := default_pixmaps_imp.Information_pixmap
		end

	Error_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing an error.
		once
			Result := default_pixmaps_imp.Error_pixmap
		end

	Warning_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing a warning.
		once
			Result := default_pixmaps_imp.Warning_pixmap
		end

	Question_pixmap: EV_PIXMAP is
			-- Pixmap symbolizing a question.
		once
			Result := default_pixmaps_imp.Question_pixmap
		end

	Default_window_icon: EV_PIXMAP is
			-- Pixmap used as default icon for new windows.
		once
			Result := default_pixmaps_imp.Default_window_icon
		end

feature -- Default cursors

	Busy_cursor: EV_CURSOR is
			-- Standard arrow and small hourglass
		once
			Result := default_pixmaps_imp.Busy_cursor
		end

	Standard_cursor: EV_CURSOR is
			-- Standard arrow
		once
			Result := default_pixmaps_imp.Standard_cursor
		end

	Crosshair_cursor: EV_CURSOR is
			-- Crosshair
		once
			Result := default_pixmaps_imp.Crosshair_cursor
		end

	Help_cursor: EV_CURSOR is
			-- Arrow and question mark
		once
			Result := default_pixmaps_imp.Help_cursor
		end

	Ibeam_cursor: EV_CURSOR is
			-- I-beam
		once
			Result := default_pixmaps_imp.Ibeam_cursor
		end

	No_cursor: EV_CURSOR is
			-- Slashed_circle
		once
			Result := default_pixmaps_imp.No_cursor
		end

	Sizeall_cursor: EV_CURSOR is
			-- Four-pointed arrow pointing north, south, east and west
		once
			Result := default_pixmaps_imp.Sizeall_cursor
		end

	Sizens_cursor: EV_CURSOR is
			-- Double-pointed arrow pointing north and south
		once
			Result := default_pixmaps_imp.Sizens_cursor
		end

	Sizenwse_cursor: EV_CURSOR is
			-- Double-pointed arrow pointing north-west and south-east
		once
			Result := default_pixmaps_imp.Sizenwse_cursor
		end

	Sizenesw_cursor: EV_CURSOR is
			-- Double-pointed arrow pointing north-east and south-west
		once
			Result := default_pixmaps_imp.Sizenesw_cursor
		end

	Sizewe_cursor: EV_CURSOR is
			-- Double-pointed arrow pointing west and east
		once
			Result := default_pixmaps_imp.Sizewe_cursor
		end

	Uparrow_cursor: EV_CURSOR is
			-- Vertical arrow
		once
			Result := default_pixmaps_imp.Uparrow_cursor
		end

	Wait_cursor: EV_CURSOR is
			-- Hourglass
		once
			Result := default_pixmaps_imp.Wait_cursor
		end

feature {NONE} -- Implementation

	Default_pixmaps_imp: EV_STOCK_PIXMAPS_IMP is
			-- Responsible for interaction with native graphics toolkit.
		once
			create Result
		end

end -- class EV_STOCK_PIXMAPS

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------
