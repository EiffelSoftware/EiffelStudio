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

create

	make

feature -- Initialization

	make is
			-- Create list.
		do
			linked_list_make;
			display := True
		ensure
			display_enabled: display
		end; 

feature -- Status setting

	display_message is
			-- From now, display new messages on standard output.
		do
			display := True
		ensure
			display_enabled: display
		end; 

	do_not_display_message is
			-- From now, do not display new messages on standard output.
		do
			display := False
		ensure
			display_disabled: not display
		end; 

feature -- Element change

	add_message (message: STRING) is
			-- Add message in list and display it or not.
		do
			finish;
			if (before or is_empty) or else not message.is_equal (item) then
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
			 create Result;
			Result.set_error_default
		end;

end -- class ERROR_LIST
 

--|----------------------------------------------------------------
--| EiffelLex: library of reusable components for ISE Eiffel.
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

