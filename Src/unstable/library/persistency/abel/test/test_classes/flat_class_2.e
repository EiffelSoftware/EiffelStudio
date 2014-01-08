note
	description: "Summary description for {FLAT_CLASS_2}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FLAT_CLASS_2

create
	make

feature

	id: INTEGER

	int_value: INTEGER

	string_value: STRING

feature {NONE}

	make (int: INTEGER; string: STRING)
		do
			int_value := int
			string_value := string
		end

end
