class A [G]

feature

	b: BOOLEAN
	i: INTEGER

	f (g: G)
		local
		do
		ensure
			b = Void -- VWEQ
			Void = b -- VWEQ
			b = i -- VWEQ
			i = b -- VWEQ
			g = Void -- OK
			Void = g -- OK
			g = i -- OK
			i = g -- OK
		end

end