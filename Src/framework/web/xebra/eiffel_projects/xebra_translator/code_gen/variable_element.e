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
	type: STRING

	make (a_name: STRING; a_type: STRING)
		do
			name := a_name
			type := a_type
		end

	serialize (buf: INDENDATION_STREAM)
			-- <Precursor>
		do
			buf.put_string (name + ": " + type)
		end

end
