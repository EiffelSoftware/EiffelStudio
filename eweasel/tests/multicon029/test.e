
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
			print (l_test.test)
		end	
end
