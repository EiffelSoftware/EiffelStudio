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

	string_value: detachable STRING

	set_id (an_id: like id)
		do
			id := an_id
		end

feature -- Output

	out: STRING
			-- <Precursor>
		do
			Result := id.out + ", " + real_value.out + ", "
			if attached string_value as str then
				Result.append (str)
			end
			Result.append ("%N")
		end

feature {NONE}

	make (real: REAL_32; string: detachable STRING)
		do
			real_value := real
			string_value := string
		end

end
