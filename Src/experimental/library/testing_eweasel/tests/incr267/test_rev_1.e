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

	a0
		do
			(agent do print ("hello") end).call ([])
		end

	f0
		do
			(agent do print ("hello") end).call ([])
		end

	test
		local
		do
			i := i2 + 1
		end

end
