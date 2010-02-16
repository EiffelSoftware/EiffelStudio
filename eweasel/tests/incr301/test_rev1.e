
--| Copyright (c) 2008, David Hollenberg, USC Information Sciences Institute
--| All rights reserved.

class TEST

create
	make

feature

	make
		do
			print (x.s.out); io.new_line
			print (y.s.out); io.new_line
			print (z.s.out); io.new_line
			print (y.s.n.out); io.new_line
			print (z.s.n.out); io.new_line
		end

	x: TEST1 [DOUBLE]

	y: TEST1 [TEST2 [POINTER]]

	z: TEST1 [TEST2 [CHARACTER]]

end
