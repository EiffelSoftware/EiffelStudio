
--| Copyright (c) 2008, David Hollenberg, USC Information Sciences Institute
--| All rights reserved.

class TEST
inherit
	TEST1 [INTEGER]
		rename
			hamster as hamster alias "+"
		end

create
	make

feature

	make is
		do
			create x
			print (x ## (3)); io.new_line
			print (x ## (3.14)); io.new_line
			print (hamster (3)); io.new_line
			print (Current.hamster (3)); io.new_line
			print (Current + (3)); io.new_line
		end

	x: TEST1 [DOUBLE]

end
