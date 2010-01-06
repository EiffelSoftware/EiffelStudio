
--| Copyright (c) 1993, David Hollenberg, USC Information Sciences Institute
--| All rights reserved.

class 
		TEST[G -> {COMPARABLE rename default_create as comparables_default_create end, NUMERIC rename generating_type as numerics_generating_type end} create default_create end]
creation	
	make
feature
	make  is
			-- foo
		local
			l_test: G
		do
			create l_test
			print (l_test.generating_type)
			print ("%N")
			l_test := l_test.one
			print (l_test.one + l_test)
			print ("%N")
		end	
end
