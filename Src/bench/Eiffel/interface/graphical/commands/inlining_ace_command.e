indexing
	description: "Enable or disable the edit text field where the user can put%
			%the inlining size."
	date: "$Date$"
	revision: "$Revision$"

class
	INLINING_ACE_COMMAND

inherit
	COMMAND

creation
	make

feature -- Initialization

	make (toggle: TOGGLE_B; edit_field: TEXT_FIELD) is
			-- Creation routine
		do
			toggle_button := toggle
			text_field := edit_field
		end

feature -- Basic operations

	execute (argument: ANY) is
			-- When the command is executed it will change the
			-- status of the edit text field where the user can
			-- put the size of the inlining.
		do
			if toggle_button.state then
				text_field.set_sensitive
			else
				text_field.set_insensitive
			end
		end

feature {NONE} -- Implementation

	text_field: TEXT_FIELD
			-- Text field where the user enters the inlining size.

	toggle_button: TOGGLE_B
			-- Toggle button which controls the status of `text_field'.

end -- class INLINING_ACE_COMMAND
