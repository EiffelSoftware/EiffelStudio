note
	description: "Objects that represent a Country"
	date: "$Date$"
	revision: "$Revision$"

class
	COUNTRY

create
	make

feature {NONE} -- Initialization

	make (a_id: READABLE_STRING_32; a_name: READABLE_STRING_32)
			-- Create a new object Country with id set to `a_id'
			-- and name set to `a_name'.
		do
			id := a_id
			name := a_name
		ensure
			name_set: name = a_name
			id_set:   id = a_id
		end

feature -- Access

	id: READABLE_STRING_32
		-- Country Acronym tree letters.

	name: READABLE_STRING_32
		-- Country name.	

	ouput: STRING_8
			-- Country output.
		do
			create Result.make_empty
			Result.append (" Id: ")
			Result.append (id)
			Result.append (" Name: ")
			Result.append("%N")
			Result.append (name)
		end

end
