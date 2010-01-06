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
		local
			i: INTEGER
		do
			i := (agent: INTEGER deferred end).item ([])
		end

end
