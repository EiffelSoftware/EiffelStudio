--| Copyright (c) 1993, David Hollenberg, USC Information Sciences Institute
--| All rights reserved.

class BC[G->XY create default_create end]
inherit
	 B[G]
	 C[G]

feature

	g: G

	test
		do
			create g
			g.f
			f_a
			f_b
			f_c
		end
end
