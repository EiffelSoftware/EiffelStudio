indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

create 
	make

feature 
	make do end

	a1
		do
			(agent do print ("hello") end).call ([])
		end

	f1
		do
			(agent do print ("hello") end).call ([])
		end

	test
		local
		do
		--	i := i2 + 1
		end

end
