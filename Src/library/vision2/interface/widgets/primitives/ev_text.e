indexing
	description: 
	"EiffelVision text area. To query multiple lines of text from the user"
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TEXT

inherit
	EV_TEXT_COMPONENT
		redefine
			make,
			implementation
		end
	
creation
	make,
	make_with_text
	
feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create an empty text area with `par' as
			-- parent.
		do
			!EV_TEXT_IMP!implementation.make
			widget_make (par)
		end

	make_with_text (par: EV_CONTAINER; txt: STRING) is
			-- Create a text area with `par' as
			-- parent and `txt' as text.
		require
			valid_parent: parent_needed implies par /= Void
		do
			!EV_TEXT_IMP!implementation.make_with_text (txt)
			widget_make (par)
		end

feature -- Access

	line (i: INTEGER): STRING is		
			-- Returns the content of the `i'th line.
		require
			valid_line_index: valid_line_index (i) and then
				(i = line_count implies last_line_not_empty)
		do
			Result := implementation.line (i)
		ensure
			result_not_void: Result /= Void
		end

feature -- Status Report
	
	current_line_number: INTEGER is
			-- Returns the number of the line the cursor currently
			-- is on.
		require
			exist: not destroyed
		do
			Result := implementation.current_line_number
		ensure
			valid_line_index: valid_line_index (Result)
		end
	
	line_count: INTEGER is
			-- Number of lines in widget
		require
			exist: not destroyed
		do
			Result := implementation.line_count
		ensure
			result_greater_zero: Result > 0
		end 

	first_position_from_line_number (i: INTEGER): INTEGER is
			-- Position of the first character on the `i'-th line.
		require
			exist: not destroyed
			valid_line: valid_line_index (i) and then
				(i = line_count implies last_line_not_empty)
		do
			Result := implementation.first_position_from_line_number (i)
		ensure
			valid_position: valid_position (i)
		end

	last_position_from_line_number (i: INTEGER): INTEGER is
			-- Position of the last character on the `i'-th line.
		require
			exist: not destroyed
			valid_line: valid_line_index (i) and then
				(i = line_count implies last_line_not_empty)
		do
			Result := implementation.last_position_from_line_number (i)
		ensure
			valid_position: valid_position (i)
		end

	has_system_frozen_widget: BOOLEAN is
			-- Is there any widget frozen?
			-- If a widget is frozen any updates made to it
			-- will not be shown until the widget is
			-- thawn again.
		require
			exist: not destroyed
		do
			Result := implementation.has_system_frozen_widget
		end

feature -- Status Settings

	freeze is
			-- Freeze the widget.
			-- If the widget is frozen any updates made to the
			-- window will not be shown until the widget is
			-- thawn again.
			-- Note: Only one window can be frozen at a time.
			-- This is because of a limitation on Windows.
		require
			exist: not destroyed
			no_frozen_widget: not has_system_frozen_widget
		do
			implementation.freeze
		ensure
			is_frozen: has_system_frozen_widget
		end

	thaw is
			-- Thaw a frozen widget.
		require
			exist: not destroyed
			is_frozen: has_system_frozen_widget
		do
			implementation.thaw
		ensure
			no_frozen_widget: not has_system_frozen_widget
		end

feature -- Basic operation

	put_new_line is
			-- Go to the beginning of the following line of position.
		require
			exists: not destroyed
		do
			implementation.put_new_line
		end

	search (str: STRING; start: INTEGER): INTEGER is
			-- Position of first occurrence of `str' at or after `start';
			-- 0 if none.
		require
			exists: not destroyed
			valid_string: str /= Void
		do
			Result := implementation.search (str, start)
		end

	select_lines (first_line, last_line: INTEGER) is
			-- Select all lines from `first_line' to `last_line'.
		require
			exist: not destroyed
			valid_line_index: valid_line_index (first_line) and valid_line_index (last_line)
		do
			select_region (first_position_from_line_number (first_line), 
								last_position_from_line_number (last_line))
		ensure
			has_selection: has_selection
		end

feature -- Assertion

	valid_line_index (i: INTEGER): BOOLEAN is
			-- Is `i' a valid line index?
		require
			exist: not destroyed
		do
			Result := i > 0 and i <= line_count
		end

	last_line_not_empty: BOOLEAN is
			-- Has the last line at least one character?
		require
			exist: not destroyed
		do
			Result := implementation.last_line_not_empty
		end

feature {NONE} -- Implementation

	implementation: EV_TEXT_I
			-- Implementation 
			
end -- class EV_TEXT

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
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
--|----------------------------------------------------------------

