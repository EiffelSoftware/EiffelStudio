indexing

	description:
		"Dialog with only one OK button to show an error";
	date: "$Date$";
	revision: "$Revision$"

class ERROR_WINDOW

inherit
	ERROR_D
		redefine
			make
		end;

	COMMAND;

creation
	
	make

feature -- creation

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a message dialog with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require else
			valid_parent: a_name /= Void;
			parent_not_void: a_parent /= Void
		do
			{ERROR_D} Precursor (a_name, a_parent)
			add_ok_action (Current, ok);
			hide_help_button
			hide_cancel_button
		ensure then
			parent_set: parent = a_parent;
			identifier_set: identifier.is_equal (a_name)
		end;

feature -- Execution argument

	ok: ANY is
		once
			!! Result
		end

feature -- Execute
	
	execute (arg: ANY) is
		do
			popdown
		end

end -- ERROR_WINDOW
