
--| Copyright (c) 1993, David Hollenberg, USC Information Sciences Institute
--| All rights reserved.

class 
	TEST

inherit
	EXCEPTIONS

creation	
	make
feature
	make  is
			-- foo
		local
			l_test: MULTI[ABC, ABC2]
			l_retried: BOOLEAN
		do
			if not l_retried then
				create l_test.make
				print (l_test.generating_type)
				print ("%N")
				l_test.perform_testing
				print ("weaselweasel%N")
			else
				print ("wusel%N")
			end
		rescue
			print (tag_name+"%N")
			if not l_retried then
				l_retried := True
				retry
			end
		end	
end
