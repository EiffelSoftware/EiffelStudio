indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
		MULTI [G -> {NUMERIC rename out as out_jo end, COMPARABLE}]

feature
	foo (a_g: G)
		local
			l_g: G
		do
			l_g := a_g
			l_g := l_g.one
			print (l_g.out + "%N") -- 1
			l_g := +l_g
			print (l_g.out + "%N") -- 1
			l_g := -l_g
			print (l_g.out + "%N") -- -1
			l_g := -(l_g + l_g)
			print (l_g.out + "%N") -- 2
			l_g := l_g + l_g.one
			print (l_g.out + "%N") -- 3
			l_g := -l_g.zero 
			print (l_g.out + "%N") -- 0
		end
end
