indexing

	description:
		"Lists of error messages for screen display"
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class ERROR_LIST inherit

	LINKED_LIST [STRING]
		rename
			make as linked_list_make
		end

create
	make

create {ERROR_LIST}
	linked_list_make

feature -- Initialization

	make is
			-- Create list.
		do
			linked_list_make;
			debug ("lex_output")
				display := True
			end		
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class ERROR_LIST

