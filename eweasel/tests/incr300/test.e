
--| Copyright (c) 2008, David Hollenberg, USC Information Sciences Institute
--| All rights reserved.

class TEST
inherit
	TEST1 [TEST2]
		redefine
			default_create
		end

create
	make

feature

	make
		do
			print (weasel.generating_type)
			io.new_line
		end

	default_create
		do
			print ("In TEST default_create%N")
		end

end
