indexing
	description: "Class representing a generated command that %
				% calls a feature on an application object."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

deferred class
	GENERATED_COMMAND [G]

inherit 

	BUILD_CMD

feature

	target: G

	error_dialog: BUILD_ERROR_DIALOG

	set_target (t: G) is
			-- Make `t' the target for next execution
		require
			not_void: t /= Void
		do
			target := t
		ensure
			target_set: target_set
			set_by_argument: target = t
		end

	target_set: BOOLEAN is
			-- Has a non-void target been defined?
		do
			Result := target /= Void
		end

	display_error_message (a_message: STRING; a_parent: COMPOSITE) is
			-- Display error message `a_message'.
		do
			if a_parent /= Void then
				!! error_dialog.make (a_message, a_parent)
			else
				io.put_string (a_message)
			end
		end

end -- class GENERATED_COMMAND
