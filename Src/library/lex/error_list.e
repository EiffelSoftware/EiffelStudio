indexing

	description:
		"Lists of error messages for screen display";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class ERROR_LIST inherit

	LINKED_LIST [STRING]
		rename
			make as linked_list_make
		end

creation

	make

feature -- Initialization

	make is
		do
			linked_list_make;
			display := true
		ensure
			display = true
		end; 

feature -- Status setting

	display_message is
			-- From now, display new messages on standard output.
		do
			display := true
		ensure
			display
		end; 

	do_not_display_message is
			-- From now, do not display new messages on standard output.
		do
			display := false
		ensure
			not display
		end; 

feature -- Element change

	add_message (message: STRING) is
			-- Add message in list and display it or not.
		do
			finish;
			if (before or empty) or else not message.is_equal (item) then
				put_right (message);
				if display then
					output.put_string (message);
					output.new_line
				end
			end
		end; 

feature {NONE} -- Implementation

	display: BOOLEAN;
			-- Are the messages to be displayed?
			-- (default is True)

	output: STD_FILES is
			-- Standard error output if the messages are to be displayed.
		once
			!!Result;
			Result.set_error_default
		end;

end -- ERROR_LIST
 

--|----------------------------------------------------------------
--| EiffelLex: library of reusable components for ISE Eiffel.
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

