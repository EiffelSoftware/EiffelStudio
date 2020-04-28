note

	description:

		"Error: Unknown construct type"

	copyright: "Copyright (c) 2004, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_UNEXPECTED_ELEMENT_ERROR

inherit

	UT_ERROR

	EWG_CONFIG_ELEMENT_NAMES
		export {NONE} all end

create

	make

feature {NONE} -- Initialization

	make (an_expected_element_name: STRING; an_element: XM_ELEMENT; a_position: XM_POSITION)
			-- Create an error reporting that instead of `an_element' an
			-- element with the name `an_expected_element_name' was
			-- expected.
		require
			an_expected_element_name_not_void: an_expected_element_name /= Void
			an_expected_element_name_not_empty: an_expected_element_name.count > 0
			an_element_not_void: an_element /= Void
			a_position_not_void: a_position /= Void
			an_element_is_not_expected: STRING_.same_string (an_expected_element_name, an_element.name)
		do
			create parameters.make_filled ("",1, 3)
			parameters.put (an_expected_element_name, 1)
			parameters.put (an_element.name, 2)
			parameters.put (a_position.out, 3)
		end

feature -- Access

	default_template: STRING = "Found element '$2' but expected '$1' $3"
			-- Default template used to built the error message

	code: STRING = "EWG0006"
			-- Error code

end
