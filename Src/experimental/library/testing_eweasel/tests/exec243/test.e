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
			i := (agent: INTEGER 
				external
					"C inline"
				alias
					"[
						return 10;
					]"
				end).item ([])
		end

end
