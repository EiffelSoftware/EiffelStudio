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
			(agent once end).call ([])
		end

end
