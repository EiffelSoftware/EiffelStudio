indexing

	description:
		"Window to show a message";
	date: "$Date$";
	revision: "$Revision$"

class MESSAGE_WINDOW

inherit

	MESSAGE_D
		redefine
			make
		end;
	COMMAND;

create
	
	make

feature -- creation

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a message dialog with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require else
			valid_parent: a_name /= Void;
			parent_not_void: a_parent /= Void
		do
			Precursor {MESSAGE_D} (a_name, a_parent)
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
			create Result
		end

feature -- Execute
	
	execute (arg: ANY) is
		do
			popdown
		end

end -- MESSAGE_WINDOW
