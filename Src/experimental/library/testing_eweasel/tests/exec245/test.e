indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

create 
	make

feature
	make is
		do
		end

	extendible: BOOLEAN

invariant
	i_1: (agent extendible).item ([])

end
