--| FIXME Not for release
indexing
	description: 
	"EiffelVision scrollable text area. To query multiple lines of text from the user."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SCROLLABLE_TEXT_I

inherit
	EV_TEXT_I
		export
			{NONE} make, make_with_text
		end

feature -- Inititalization

--	make_with_properties (txt: STRING; hscroll, vscroll: BOOLEAN) is
--			-- Create a scrollable text area with text `txt'.
--			-- If `hscroll' True then horizontally scrollable.
--			-- If `vscroll' True then vertically .
--		deferred
--		end

feature -- Status Report
	
	horizontal_scroll_bar_visible: BOOLEAN is
			-- True if horizontal scroll bar shown.
		require
			exists: not destroyed
		deferred
		end
	
	vertical_scroll_bar_visible: BOOLEAN is
			-- True if vertical scroll bar shown.
		require
			exists: not destroyed
		deferred
		end

	has_horizontal_scrolling: BOOLEAN is
			-- True if can be scrolled horizontally.
		require
			exists: not destroyed
		deferred
		end

	has_vertical_scrolling: BOOLEAN is
			-- True if can be scrolled vertically.
		require
			exists: not destroyed
		deferred
		end
feature -- Status Settings

	show_horizontal_scroll_bar is
			-- Show horizontal scroll bar.
		require
			exists: not destroyed
			horizontal_scrolling_enabled: has_horizontal_scrolling
		deferred
		end

	show_vertical_scroll_bar is
			-- Show vertical scroll bar.
		require
			exists: not destroyed
			vertical_scrolling_enabled: has_vertical_scrolling
		deferred
		end

	hide_horizontal_scroll_bar is
			-- Hide horizontal scroll bar.
		require
			exists: not destroyed
			horizontal_scrolling_enabled: has_horizontal_scrolling
		deferred
		end

	hide_vertical_scroll_bar is
			-- Hide vertical scroll bar.
		require
			exists: not destroyed
			vertical_scrolling_enabled: has_vertical_scrolling
		deferred
		end
			
end -- class EV_SCROLLABLE_TEXT

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--!----------------------------------------------------------------

