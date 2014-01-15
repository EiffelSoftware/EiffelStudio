note
	description: "Summary description for {FLAT_CLASS_2}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FLAT_CLASS_3

inherit
	ANY
		redefine
			out
		end

create
	make

feature

	id: INTEGER

	real_value: REAL_32

	string_value: STRING

	set_id (an_id: like id)
		do
			id := an_id
		end

feature -- Output

	out: STRING
			-- <Precursor>
		do
			Result := id.out + ", " + real_value.out + ", " + string_value + "%N"
		end

feature {NONE}

	make (real: REAL_32; string: STRING)
		do
			real_value := real
			string_value := string
		end

end
