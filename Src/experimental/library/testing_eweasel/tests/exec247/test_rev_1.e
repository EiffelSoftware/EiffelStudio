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
			io.new_line;
			(agent do end).call ([])	
		end

invariant
	i_1: (agent: BOOLEAN do end).item ([])

end
