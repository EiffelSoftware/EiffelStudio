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
			default_create as default_create_aa
		end
		B
		rename
			default_create as default_create_bb, 
			make as default_create,
			f as f_b,
			g as g_b
		select
			default_create_bb
		end
		C
		rename
			default_create as default_create_cc,
			make as make_c,
			f as f_cc,
			g as g_cc
		end

create
	make,	default_create, make_c

end

