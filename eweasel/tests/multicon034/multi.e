indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MULTI [G -> H, H -> {STRING, NUMERIC}]

feature
	foo
		local
			l_g: G
		do
			l_g.to_upper
			l_g := l_g.one
		end
end
