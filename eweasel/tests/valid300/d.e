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
			Result := Precursor {B} + Precursor {C}
		end

	to_string: STRING
		do
			Result := "b:" + name_b + " c:" + name_c
		end


end
