indexing
	description: "Multi constraint test"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
		ABC
inherit
		A
		rename
			make as make_aa
		end
		B
		rename
			f as f_b,
			g as g_b
		end
		C
		rename
			make as make_cc,
			f as f_cc,
			g as g_cc
		end

create
	make

end

