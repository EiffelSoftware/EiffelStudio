indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MULTI [G -> {ARRAY [H] rename at as at alias "|*|" end, LIST [H] rename item as item_of_list  end}, H -> NUMERIC]

create
	make
feature

	g: G

feature

	test: ANY
		local
			l_a: ANY
			l_g: G
			l_h: H
		do
			l_g := g

			Result := g.i_th(1)
			print (Result.out + "%N")	-- prints 43

			Result := Current.g |*| 2
			print (Result.out + "%N")	-- prints 44

			Result := g |*| 3
			print (Result.out + "%N")	-- prints 45

			l_h := l_g.item(4)
			print (l_h.out + "%N")		-- prints 46

			l_a := g @ 3
			print (l_a.out + "%N")		-- prints 45

			l_a := l_g |*| 2
			print (l_a.out + "%N")		-- prints 44

			l_h := g.item (1)
			print (l_h.out + "%N")		-- prints 43

			l_h := l_h.plus (l_h)
			l_h := l_h + l_h
			print ("-%N")
			print (l_h.out + "%N")		-- prints 172
			print ("-%N")
		end

feature
 	make (a_g: G)
 		do
 			g := a_g
 		end

end
