class A [G]

create

	make

feature

	make (y: G)
		do
			x := y
		end

	f (a: G)
		do
		ensure
			attached a.generating_type -- VUTA(2)
			attached x.generating_type -- VUTA(2)
		end

	g (a: G)
		do
			check attached a then end
			check attached x then end
		ensure
			attached a.generating_type -- VUTA(2)
			attached x.generating_type -- VUTA(2)
		end

	h (y: G): G
		do
			x := y
			Result := y
		ensure
			attached x.generating_type -- VUTA(2)
			attached Result.generating_type -- VUTA(2)
		end

feature -- Data

	x: G

end
