indexing

	description:
		"Window to show a message"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_MESSAGE_WINDOW

inherit

	EV_INFORMATION_DIALOG
		redefine
			make_default
		end
	EV_COMMAND

creation
	
	make_default

feature -- creation

	make_default (a_parent: EV_CONTAINER; a_title, a_name: STRING) is
			-- Create a message dialog with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require else
			valid_parent: a_name /= Void
			parent_not_void: a_parent /= Void
		do
			{EV_INFORMATION_DIALOG} Precursor (a_parent, a_title, a_name)
			add_ok_command (Current, ok)
		ensure then
--			parent_set: parent = a_parent
--			identifier_set: identifier.is_equal (a_name)
		end

feature -- Execution argument

	ok: EV_ARGUMENT1 [ANY] is
		once
			!! Result.make (Void)
		end

feature -- Execute
	
	execute (arg: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
		do
			destroy
		end

end -- EB_MESSAGE_WINDOW
