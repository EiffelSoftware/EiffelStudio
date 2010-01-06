indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	A [G]

feature
	test(g: G): G is
		do
		ensure
			(agent: G do end).item ([]) = g
--			g = g
		end

end
