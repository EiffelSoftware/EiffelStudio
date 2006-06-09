indexing
	description: "Boolean item in a property grid."
	date: "$Date$"
	revision: "$Revision$"

class
	BOOLEAN_PROPERTY

inherit
	CHOICE_PROPERTY [BOOLEAN]

create
	make_with_value

feature {NONE} -- Initialization

	make_with_value (a_name: like name; a_value: BOOLEAN) is
			-- Create with `a_value'.
		do
			make_with_choices (a_name, <<True, False>>)
			disable_text_editing
			set_value (a_value)
		end

end
