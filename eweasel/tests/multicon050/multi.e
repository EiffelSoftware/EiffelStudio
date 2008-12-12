indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MULTI [G -> {ARRAY [H] rename at as at end}, H -> NUMERIC]

create
	make
feature

	g: G

feature

	test: ANY
		local
			l_a: ANY
		do
			l_a := g @ 3
		end

feature
 	make (a_g: G)
 		do
 			g := a_g
 		end

end
