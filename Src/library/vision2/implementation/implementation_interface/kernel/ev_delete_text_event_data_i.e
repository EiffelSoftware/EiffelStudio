indexing
	description: "EiffelVision delete text data. Implementation interface";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_DELETE_TEXT_EVENT_DATA_I
	
inherit
	EV_RICH_TEXT_EVENT_DATA_I	
		rename
			set_all as set_all_rich_text
		end

feature -- Access	

	cursor_position: INTEGER
			-- The position where the text has been inserted
	
	start_position: INTEGER
			-- The start position of the deleted text
			
	end_position: INTEGER
			-- The end position of the deleted text

	text: STRING
			-- The text that has been deleted
	
feature -- Element change

	set_all (a_rich_text: EV_RICH_TEXT; a_cursor_position, 
				a_start_position, a_end_position: INTEGER;
				a_text: STRING) is
			-- Fill all the values of the data.
		do
			set_all_rich_text (a_rich_text)
			set_cursor_position (a_cursor_position)
			set_start_position (a_start_position)
			set_end_position (a_end_position)
			set_text (a_text)
		end

	set_cursor_position (a_cursor_position: INTEGER) is
		do
			cursor_position := a_cursor_position
		end

	set_start_position (a_start_position: INTEGER) is
		do
			start_position := a_start_position
		end

	set_end_position (a_end_position: INTEGER) is
		do
			end_position := a_end_position
		end

	set_text (a_text: STRING) is
		do
			text := a_text
		end

end -- class EV_DELETE_TEXT_EVENT_DATA_I

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
