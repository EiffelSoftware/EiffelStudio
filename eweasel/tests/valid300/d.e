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
		end

	C
		rename
			make as make_c,
			name as name_c
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

end
