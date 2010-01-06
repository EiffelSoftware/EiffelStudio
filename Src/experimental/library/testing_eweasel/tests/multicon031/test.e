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
		do
			create l_test
		end	
end
