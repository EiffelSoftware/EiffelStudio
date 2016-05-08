note

	description:

		"Error: Wrong root element in Xace file"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2001-2011, Andreas Leitner and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_XACE_WRONG_ROOT_ELEMENT_ERROR

inherit

	ET_XACE_ERROR

create

	make

feature {NONE} -- Initialization

	make (an_element_name: STRING; a_position: XM_POSITION)
			-- Create a new error reporting that Xace file does not
			-- contain the expected root element `an_element_name'.
		require
			an_element_name_not_void: an_element_name /= Void
			an_element_name_not_empty: an_element_name.count > 0
			a_position_not_void: a_position /= Void
		do
			create parameters.make_filled (empty_string, 1, 2)
			parameters.put (an_element_name, 1)
			parameters.put (a_position.out, 2)
		end

feature -- Access

	default_template: STRING = "Xace document must have a '$1' root-element $2"
			-- Default template used to built the error message

	code: STRING = "XA0001"
			-- Error code

end
