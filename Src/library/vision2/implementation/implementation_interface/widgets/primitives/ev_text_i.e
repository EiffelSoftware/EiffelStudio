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
		redefine
			interface
		end
	
	EV_FONTABLE_I
		redefine
			interface
		end

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
		do
			Result := text.occurrences ('%N') + 1
		ensure
			result_greater_zero: Result > 0
			result_consistent: Result = text.occurrences ('%N') + 1
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
		
feature {EV_ANY_I} -- Implementation

	interface: EV_TEXT

end -- class EV_TEXT_I

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

