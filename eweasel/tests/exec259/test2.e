class TEST2 [G]

create
	make

feature

	make is
			--
		local
			g: SPECIAL [G]
		do
			create g.make_filled (({G}).default, 10)
		end


end
