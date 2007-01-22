
--| Copyright (c) 1993, David Hollenberg, USC Information Sciences Institute
--| All rights reserved.

class B[G -> {X rename f as f_x end, Y rename default_create as default_create_y end} create default_create end]
inherit
	A[G]

feature

	f_b
		local
			g : G
		do
			create g.default_create
			f_a
			g.f_x
			g.f
		end

end
