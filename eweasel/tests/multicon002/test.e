
--| Copyright (c) 1993, David Hollenberg, USC Information Sciences Institute
--| All rights reserved.

class
	TEST
creation
	make
feature
	make  is
			-- foo
		local
			l_test: MULTI[ABC]
		do
			create l_test.make
		end
end