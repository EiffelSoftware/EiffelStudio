indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST4 [G, H]

inherit
	TEST3 [G, H]
		redefine
			set_coef
		end

feature

	set_coef (a: TEST2 [G, H]) is
		do

		end

end
