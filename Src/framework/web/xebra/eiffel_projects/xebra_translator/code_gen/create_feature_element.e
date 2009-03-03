note
	description: "Summary description for {CREATE_FEATURE_ELEMENT}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

class
	CREATE_FEATURE_ELEMENT

inherit
	SERVLET_ELEMENT

create
	make

feature -- Access

	name: STRING

	make (constructor_name: STRING)
		do
			name := constructor_name
		end

	serialize (buf: INDENDATION_STREAM)
			-- <Precursor>
		do
			buf.put_string (name)
			buf.put_string ("do end")
		end

end
