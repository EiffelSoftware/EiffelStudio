note
	description: "Summary description for {VARIABLE_ELEMENT}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

class
	VARIABLE_ELEMENT

inherit
	SERVLET_ELEMENT

create
	make

feature -- Access

	name: STRING
			-- The name of the variable
	type: STRING
			-- The type of the variable

feature -- Initialization

	make (a_name: STRING; a_type: STRING)
			-- `a_name': The name of the variable
			-- `a_type': The type of the variable
		require
			name_is_valid: not a_name.is_empty
			type_is_valid: not a_type.is_empty
		do
			name := a_name
			type := a_type
		end

feature -- Processing

	serialize (buf: INDENDATION_STREAM)
			-- <Precursor>
		do
			buf.put_string (name + ": " + type)
		end

end
