indexing
	description: "Multi constraint test"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class 
	TEST
creation	
	make
feature
	make  is
			-- Creation
		local
			l_test: MULTI2[INTEGER]
			l_any: ANY
		do
			create l_test
			l_any := l_test.test
		end	
end
