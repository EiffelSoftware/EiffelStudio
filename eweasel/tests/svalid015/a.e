
--| Copyright (c) 1993, David Hollenberg, USC Information Sciences Institute
--| All rights reserved.

class A[G -> {X rename f as f_x end, Y rename default_create as default_create_y, f as f_y end} create default_create end]

feature

	f_a
		local
			g : G
		do
			create g
			g.f_x
			g.f_y
		end

end
