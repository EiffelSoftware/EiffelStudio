indexing
	description: "EiffelVision highlight event data.% 
	%Class for representing button event data";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_HIGHLIGHT_EVENT_DATA
	
inherit
	EV_RICH_TEXT_EVENT_DATA	
		rename 
			make as make_event_data
		redefine
			print_contents,
			rich_text
		end

creation
	make

feature {NONE} -- Initialization

	make (a_rich_text: EV_TEXT_EDITOR; a_first_pos, a_last_pos: INTEGER; a_format: EV_CHARACTER_FORMAT) is
		require
			a_rich_text_not_void: a_rich_text /= Void
			a_first_pos_valid: a_rich_text.valid_position (a_first_pos)
			a_last_pos_valid: a_rich_text.valid_position (a_last_pos)
			a_format_not_void: a_format /= Void
		do
			rich_text := a_rich_text
			first_pos := a_first_pos
			last_pos := a_last_pos
			format := a_format
		ensure
			rich_text_not_void: rich_text = a_rich_text
			first_pos_set: first_pos = a_first_pos
			last_pos_set: last_pos = a_last_pos
			format_set: format = a_format
		end
	
feature -- Access	

	first_pos: INTEGER
			-- first character position
	last_pos: INTEGER
			-- last character position

	rich_text: EV_TEXT_EDITOR

	format: EV_CHARACTER_FORMAT
			-- The format to be applied on the text between
			-- `first_pos' and `last_pos' in the widget
			-- identified by `rich_text'.

feature -- Debug
	
	print_contents is
			-- print the contents of the object
		do
			io.put_string ("First Position: ")
			io.put_integer (first_pos)
			io.put_string ("%N")
			io.put_string ("Last Position: ")
			io.put_integer (last_pos)
			io.put_string ("%N")
		end


end -- class EV_HIGHLIGHT_EVENT_DATA

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
