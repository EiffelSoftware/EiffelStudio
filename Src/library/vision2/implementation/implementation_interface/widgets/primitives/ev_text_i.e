indexing
	description: 
		"EiffelVision text area. Implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_TEXT_I
	
inherit
	EV_TEXT_COMPONENT_I

feature -- Access

	line (i: INTEGER): STRING is
			-- `Result' is content of the `i'th line.
		require
			valid_line: valid_line_index (i) and then
				(i = line_count implies last_line_not_empty)
		deferred
		ensure
			result_not_void: Result /= Void
		end

feature -- Status report

	current_line_number: INTEGER is
			-- `Result'is number of line containing cursor.
		require
		deferred
		ensure
			valid_line_index: valid_line_index (Result)
		end

	line_count: INTEGER is
			-- Number of lines of text in `Current'.
		require
		deferred
		ensure
			result_greater_zero: Result > 0
		end 

	first_position_from_line_number (i: INTEGER): INTEGER is
			-- Position of the first character on the `i'-th line.
		require
			valid_line: valid_line_index (i) and then
				(i = line_count implies last_line_not_empty)
		deferred
		ensure
			valid_caret_position: valid_caret_position (i)
		end

	last_position_from_line_number (i: INTEGER): INTEGER is
			-- Position of the last character on the `i'-th line.
		require
			valid_line: valid_line_index (i) and then
				(i = line_count implies last_line_not_empty)
		deferred
		ensure
			valid_caret_position: valid_caret_position (i)
		end

	has_system_frozen_widget: BOOLEAN is
			-- Are there any frozen widgets?
			-- If a widget is frozen any updates made to it
			-- will not be shown until the widget is
			-- thawn again.
		require
		deferred
		end

feature -- Status settings

	freeze is
			-- Freeze the widget.
			-- If the widget is frozen any updates made to the
			-- window will not be shown until the widget is
			-- thawn again.
			-- Note: Only one window can be frozen at a time.
			-- This is because of a limitation on Windows.
		require
			not_widget_is_frozen: not has_system_frozen_widget
		deferred
		ensure
			is_frozen: has_system_frozen_widget
		end

	thaw is
			-- Thaw a frozen widget.
		require
			is_frozen: has_system_frozen_widget
		deferred
		ensure
			no_widget_is_frozen: not has_system_frozen_widget
		end

feature -- Basic operation

	put_new_line is
			-- Go to the beginning of the following line.
		require
		deferred
		end

	search (str: STRING; start: INTEGER): INTEGER is
			-- Position of first occurrence of `str' at or after `start';
			-- 0 if none.
		require
			valid_string: str /= Void
		deferred
		end

	scroll_to_line (i: INTEGER) is
			-- Ensure that line `i' is visible in `Current'.
		require
			valid_line_index: valid_line_index (i) and then
				(i = line_count implies last_line_not_empty)
		deferred
		end

feature -- Assertions

	valid_line_index (i: INTEGER): BOOLEAN is
			-- Is `i' a valid line index?
		require
		do
			Result := i > 0 and i <= line_count
		end

	last_line_not_empty: BOOLEAN is
			-- Has the last line at least one character?
		require
		deferred
		end

end -- class EV_TEXT_I

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.18  2001/07/14 12:46:24  manus
--| Replace --! by --|
--|
--| Revision 1.17  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.16  2001/06/07 23:08:10  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.12.4.3  2000/12/06 22:48:37  rogers
--| Implemented scroll_to_line as deferred.
--|
--| Revision 1.12.4.2  2000/08/18 00:02:08  rogers
--| removed fixme not_Reviewed. Comments, formatting. Removed
--| set_default_options.
--|
--| Revision 1.12.4.1  2000/05/03 19:09:07  oconnor
--| mergred from HEAD
--|
--| Revision 1.15  2000/04/13 23:07:05  brendel
--| Unreleased.
--|
--| Revision 1.14  2000/02/22 18:39:44  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.13  2000/02/14 11:40:38  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.12.6.7  2000/02/04 05:14:06  oconnor
--| unreleased
--|
--| Revision 1.12.6.6  2000/02/04 05:06:35  oconnor
--| released
--|
--| Revision 1.12.6.5  2000/01/27 19:30:05  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.12.6.4  1999/12/30 01:57:49  rogers
--| changed valid_position to valid_caret_position.
--|
--| Revision 1.12.6.3  1999/12/09 19:04:10  oconnor
--| commented out set_vertical_resize, set_horizontal_resize
--|
--| Revision 1.12.6.2  1999/12/09 03:15:06  oconnor
--| commented out make_with_* features, these should be in interface only
--|
--| Revision 1.12.6.1  1999/11/24 17:30:14  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.12.2.3  1999/11/04 23:10:45  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.12.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
