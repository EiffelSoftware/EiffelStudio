class C [G -> {E, D [G]}]

inherit
	B [G]
		redefine
			g, h
		end

feature -- Test

	g (a: A [E])
		do
		end

	h (a: G)
		do
		end

end
