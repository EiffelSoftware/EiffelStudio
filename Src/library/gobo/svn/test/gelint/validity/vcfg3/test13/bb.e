class BB

inherit

	CC [EE, EE]

feature

	g is
		local
			e: EE
		do
			create e
			item1 := e
			item2 := e
		end

end -- class BB
