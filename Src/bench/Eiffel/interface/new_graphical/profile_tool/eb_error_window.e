indexing

	description:
		"Dialog with only one OK button to show an error"
	date: "$Date$"
	revision: "$Revision$"

class EB_ERROR_WINDOW

inherit
	EV_ERROR_DIALOG
		redefine
			make_default
		end

	EV_COMMAND

creation
	
	make_default

feature -- creation

	make_default (par: EV_CONTAINER; a_title, a_msg: STRING) is
			-- Create a message dialog with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require else
--			valid_parent: a_name /= Void
			parent_not_void: par /= Void
		do
			make_with_text (par, a_title, a_msg)
			add_ok_command (Current, Void)
			implementation.set_default (a_msg, a_title)
		ensure then
--			parent_set: parent = par
--			identifier_set: identifier.is_equal (a_name)
		end

feature -- Execution argument

--	ok: ANY is
--		once
--			create Result.make
--		end

feature -- Execute
	
	execute (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
			destroy
		end

end -- EB_ERROR_WINDOW
