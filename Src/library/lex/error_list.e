--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Records with a list of messages,
-- which can be displayed on the screen or not

indexing

	date: "$Date$";
	revision: "$Revision$"

class ERROR_LIST

inherit

	LINKED_LIST [STRING]
		rename
			make as linked_list_make
		end

creation

	make

feature

	make is
		do
			linked_list_make;
			display := true
		ensure
			display = true
		end; -- make

	display_message is
			-- From now, display new messages on standard output.
		do
			display := true
		ensure
			display
		end; -- display_message

	do_not_display_message is
			-- From now, do not display new messages on standard output.
		do
			display := false
		ensure
			not display
		end; -- do_not_display_message

	add_message (message: STRING) is
			-- Add message in list and display it or not.
		do
			finish;
			if (before or empty) or else not message.is_equal (item) then
				add_right (message);
				if display then
					output.putstring (message);
					output.new_line
				end
			end
		end -- add_message

feature {NONE}

	display: BOOLEAN;
			-- Are the messages to be displayed?
			-- (default is True)

	output: STD_FILES is
			-- Standard error output if the messages are to be displayed.
		once
			!!Result;
			Result.set_error_default
		end -- output

end -- ERROR_LIST
