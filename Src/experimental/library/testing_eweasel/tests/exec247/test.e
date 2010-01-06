indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST
create
	make

feature
	make 
		do 
			(agent do end).call ([])	
		end

invariant
	i_1: (agent: BOOLEAN do end).item ([])

end
