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
			valid_line_index: valid_line_index (i)
		do
			Result := implementation.line (i)
		ensure
			result_not_void: Result /= Void
		end

feature -- Status Report

	line_count: INTEGER is
			-- Number of lines in widget
		require
			exist: not destroyed
		do
			Result := implementation.line_count
		ensure
			result_greater_zero: Result > 0
		end 

	first_character_from_line_number (i: INTEGER): INTEGER is
			-- Position of the first character on the `i'-th line.
		require
			exist: not destroyed
			valid_line: valid_line_index (i)
		do
			Result := implementation.first_character_from_line_number (i)
		ensure
			valid_character_position: valid_character_position (i)
		end

	last_character_from_line_number (i: INTEGER): INTEGER is
			-- Position of the last character on the `i'-th line.
		require
			exist: not destroyed
			valid_line: valid_line_index (i)
		do
			Result := implementation.last_character_from_line_number (i)
		ensure
			valid_character_position: valid_character_position (i)
		end


	valid_line_index (i: INTEGER): BOOLEAN is
			-- Is `i' a valid line index?
		require
			exist: not destroyed
		do
			Result := i > 0 and i < line_count
		end


feature -- Basic operation

	put_new_line is
			-- Go to the beginning of the following line of position.
		require
			exists: not destroyed
		do
			implementation.put_new_line
		end

	search (str: STRING): INTEGER is
			-- Search the string `str' in the text.
			-- If `str' is find, it returns its start
			-- index in the text, otherwise, it returns
			-- `-1'
		require
			exists: not destroyed
			valid_string: str /= Void
		do
			Result := implementation.search (str)
		end

	select_lines (first_line, last_line: INTEGER) is
			-- Select all lines from `first_line' to `last_line'.
		require
			exist: not destroyed
			valid_line_index: valid_line_index (first_line) and valid_line_index (last_line)
		do
			select_region (first_character_from_line_number (first_line), 
								last_character_from_line_number (last_line))
		ensure
			has_selection: has_selection
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

