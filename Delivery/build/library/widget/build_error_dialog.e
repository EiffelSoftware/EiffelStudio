indexing
	description: "Message box with a specific error symbol to warn the user %
		%of an invalid or potentially dangerous condition, %
		%it appears like an error dialog."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	BUILD_ERROR_DIALOG

inherit

	ERROR_D
		redefine
			make
		end

	COMMAND

creation
	make

feature -- Initialization

	make (a_message: STRING; a_parent: COMPOSITE) is
			-- Create an error dialog with `a_name' as identifier,
			-- and call `set_default'.

		do
			{ERROR_D} Precursor (a_message, a_parent)
			set_title ("Error window")
			set_message (a_message)
			hide_help_button
			hide_cancel_button
			set_exclusive_grab
			add_ok_action (Current, Current)
			set_action ("<Unmap>", Current, Void)
			popup				
		end

feature {NONE}

	execute (argument: ANY) is
		do
			destroy
		end


end -- class BUILD_ERROR_DIALOG
