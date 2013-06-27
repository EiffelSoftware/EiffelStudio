class B [G -> attached TEST]

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
			attached a.generating_type
			attached x.generating_type
		end

	g (a: G)
		do
			check attached a then end
			check attached x then end
		ensure
			attached a.generating_type
			attached x.generating_type
		end

	h (y: G): G
		do
			x := y
			Result := y
		ensure
			attached x.generating_type
			attached Result.generating_type
		end

feature -- Data

	x: G

end
