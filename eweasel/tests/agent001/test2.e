class
	TEST2

inherit
	TEST1
		redefine
			query
		end

create
	make

feature

	query: FUNCTION [ANY, TUPLE, INTEGER]

end
