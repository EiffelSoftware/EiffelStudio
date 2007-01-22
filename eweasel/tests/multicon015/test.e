
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
			l_test: MULTI[INTEGER]
		do
			create l_test
			io.put_integer(l_test.abs_diff (2,-2))
			io.put_integer(l_test.abs_diff (-1,1))
			io.put_new_line
		end	
end
