
--| Copyright (c) 1993, David Hollenberg, USC Information Sciences Institute
--| All rights reserved.

class C[G -> {X rename default_create as default_create_x end, Y rename f as f_y end} create default_create end]
inherit
	A[G]

feature

	f_c
		local
			g : G
		do
			create g.default_create
			f_a
			g.f
			g.f_y
		end

end
