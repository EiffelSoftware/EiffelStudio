indexing
	description: 
		"EiffelVision text area, implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_TEXT_I
	
inherit
	EV_TEXT_COMPONENT_I
		redefine
			set_default_options
		end	

feature {NONE} -- Initialization

	make_with_text (txt: STRING) is
			-- Create a text area with `par' as
			-- parent and `txt' as text.
		deferred
		end

feature -- Access

	line (i: INTEGER): STRING is
			-- Returns the content of the `i'th line.
		require
			valid_line_index: valid_line_index (i)
		deferred
		ensure
			result_not_void: Result /= Void
		end

feature -- Status report

	line_count: INTEGER is
			-- Number of lines in widget
		require
			exist: not destroyed
		deferred
		ensure
			result_greater_zero: Result > 0
		end 

	first_character_from_line_number (i: INTEGER): INTEGER is
			-- Position of the first character on the `i'-th line.
		require
			exist: not destroyed
			valid_line: valid_line_index (i)
		deferred
		ensure
			valid_character_position: valid_character_position (i)
		end

	last_character_from_line_number (i: INTEGER): INTEGER is
			-- Position of the last character on the `i'-th line.
		require
			exist: not destroyed
			valid_line: valid_line_index (i)
		deferred
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

feature -- Status settings

	set_default_options is
			-- Initialize the options of the widget.
		do
			set_expand (True)
			set_vertical_resize (True)
			set_horizontal_resize (True)
		end

feature -- Basic operation

	put_new_line is
			-- Go to the beginning of the following line.
		require
			exists: not destroyed
		deferred
		end

	search (str: STRING): INTEGER is
			-- Search the string `str' in the text.
			-- If `str' is find, it returns its start
			-- index in the text, otherwise, it returns
			-- `Void'
		require
			exists: not destroyed
			valid_string: str /= Void
		deferred
		end

end -- class EV_TEXT_I

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
