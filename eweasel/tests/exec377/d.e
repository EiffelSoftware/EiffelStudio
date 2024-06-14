note
	description: "Summary description for {B}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	D

inherit
	B
		rename
			make as make_b,
			name as name_b
		redefine
			code,
			to_string
		end

	C
		rename
			make as make_c,
			name as name_c
		redefine
			code,
			to_string
		select
			make_c,
			name_c
		end

create
	make

feature {NONE} -- Initialization

	make (b,c: STRING)
		do
			make_b (b)
			make_c (c)
		end

feature -- Access

	code: STRING
		do
--			Result := name_b.as_lower + name_c.as_lower
			Result := Precursor {B} + Precursor {C} -- ISSUE
		end

	to_string: STRING
		do
			Result := "b:"
			if attached name_b as b then
				Result.append (b)
			else
				Result.append ("?")
			end
			Result.append (" c:")
			if attached name_c as c then
				Result.append (c)
			else
				Result.append ("?")
			end
--			Result := "b:"+ Precursor {B} + " c:" + Precursor {C}
		end


end
