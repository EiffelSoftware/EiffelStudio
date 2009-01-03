
--| Copyright (c) 1993, David Hollenberg, USC Information Sciences Institute
--| All rights reserved.

class 
	TEST
create	
	make
feature
	make  is
			-- foo
		local
			l_bc: BC[XY2]
			l_a: A[XY]
			l_b: B[XY]
			l_c: C[XY]
		do
			create l_bc
				-- 25 times XY2.f as output expected
			l_bc.test

			l_a := l_bc
			l_b := l_bc
			l_c := l_bc
			l_a.f_a
			l_b.f_a
			l_b.f_b
			l_c.f_a
			l_c.f_c

				-- 14 times XY.f as output expected
			create l_a
			create l_b
			create l_c
			l_a.f_a
			l_b.f_a
			l_b.f_b
			l_c.f_a
			l_c.f_c


		end	
end
