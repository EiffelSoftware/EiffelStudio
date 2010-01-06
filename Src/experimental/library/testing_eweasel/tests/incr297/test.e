
--| Copyright (c) 2008, David Hollenberg, USC Information Sciences Institute
--| All rights reserved.

class TEST
inherit
	TEST1 [TEST2 [TEST3]]

create
	make

feature

	make
		do
			print (weasel)
			io.new_line
		end

end
