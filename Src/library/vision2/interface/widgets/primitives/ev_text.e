indexing
	description: 
		"EiffelVision text area. To query multiple lines of text from the user."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TEXT

inherit
	EV_TEXT_COMPONENT
		redefine
			implementation
		end
	
create
	default_create,
	make_with_text
	
feature {NONE} -- Initialization

	make_with_text (txt: STRING) is
			-- Create `Current' with `txt' assigned to `text'.
		require
			txt_not_void: txt /= Void
		do
			default_create
			set_text (txt)
		end

feature -- Access

	line (i: INTEGER): STRING is		
			-- `Result' is content of `i'th line.
		require
			not_destroyed: not is_destroyed
			valid_line_index: valid_line_index (i) and then
				(i = line_count implies last_line_not_empty)
		do
			Result := implementation.line (i)
		ensure
			result_not_void: Result /= Void
		end

feature -- Status report
	
	current_line_number: INTEGER is
			-- Line currently containing cursor.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.current_line_number
		ensure
			valid_line_index: valid_line_index (Result)
		end
	
	line_count: INTEGER is
			-- Number of lines in `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.line_count
		ensure
			result_greater_zero: Result > 0
		end 

	first_position_from_line_number (i: INTEGER): INTEGER is
			-- Position of first character on `i'-th line.
		require
			not_destroyed: not is_destroyed
			valid_line: valid_line_index (i) and then
				(i = line_count implies last_line_not_empty)
		do
			Result := implementation.first_position_from_line_number (i)
		ensure
			valid_caret_position: valid_caret_position (i)
		end

	last_position_from_line_number (i: INTEGER): INTEGER is
			-- Position of last character on `i'-th line.
		require
			not_destroyed: not is_destroyed
			valid_line: valid_line_index (i) and then
				(i = line_count implies last_line_not_empty)
		do
			Result := implementation.last_position_from_line_number (i)
		ensure
			valid_caret_position: valid_caret_position (i)
		end

feature -- Basic operation

	scroll_to_line (i: INTEGER) is
			-- Ensure that line `i' is visible in `Current'.
		require
			not_destroyed: not is_destroyed
			valid_line_index: valid_line_index (i) and then
				(i = line_count implies last_line_not_empty)
		do
			implementation.scroll_to_line (i)
		end

	put_new_line is
			-- Insert return character at `caret_position'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.put_new_line
		end

	search (str: STRING; start: INTEGER): INTEGER is
			-- Position of first occurrence of `str' at or after `start';
			-- 0 if none.
		require
			not_destroyed: not is_destroyed
			valid_string: str /= Void
		do
			Result := implementation.search (str, start)
		end

	select_lines (first_line, last_line: INTEGER) is
			-- Select all lines from `first_line' to `last_line'.
		require
			not_destroyed: not is_destroyed
			valid_line_index: valid_line_index (first_line) and valid_line_index (last_line)
		do
			select_region (first_position_from_line_number (first_line), 
								last_position_from_line_number (last_line))
		ensure
			has_selection: has_selection
		end

feature -- Contract support

	valid_line_index (i: INTEGER): BOOLEAN is
			-- Is `i' a valid line index?
		do
			Result := i > 0 and i <= line_count
		end

	last_line_not_empty: BOOLEAN is
			-- Has last line at least one character?
		do
			Result := implementation.last_line_not_empty
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_TEXT_I
			-- Responsible for interaction with native graphics toolkit.
			
feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_TEXT_IMP} implementation.make (Current)
		end
			
end -- class EV_TEXT

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
