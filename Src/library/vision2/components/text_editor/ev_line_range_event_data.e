indexing
	description: "EiffelVision general notion of event data%
					 %that is based on a range of lines";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_LINE_RANGE_EVENT_DATA
	
inherit
	EV_RICH_TEXT_EVENT_DATA	
		rename 
			make as make_event_data
		redefine
			print_contents,
			rich_text
		end

create
	make

feature {NONE} -- Initialization

	make (a_rich_text: EV_RICH_TEXT; a_first_line, a_last_line: INTEGER) is
		require
			a_rich_text_not_void: a_rich_text /= Void
			a_first_line_valid: a_first_line >= 1
			a_last_line_valid: a_last_line >= 1
		do
			rich_text := a_rich_text
			first_line := a_first_line
			last_line := a_last_line
		ensure
			rich_text_not_void: rich_text = a_rich_text
			first_line_valid: first_line = a_first_line
			last_line_valid: last_line = a_last_line
		end
	
feature -- Access	

	first_line: INTEGER
			-- first line
	last_line: INTEGER
			-- last line

	rich_text: EV_RICH_TEXT
feature -- Debug
	
	print_contents is
			-- print the contents of the object
		do
			io.put_string ("First Line: ")
			io.put_integer (first_line)
			io.put_string ("%N")
			io.put_string ("Last Line: ")
			io.put_integer (last_line)
			io.put_string ("%N")
		end

end -- class EV_LINE_RANGE_EVENT_DATA

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
