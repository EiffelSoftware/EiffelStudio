class A [G]

feature

	b: BOOLEAN
	i: INTEGER

	h: detachable like f
	j: like i

	f (g: G): G
		do
			Result := G
		ensure
			b = Void -- VWEQ
			Void = b -- VWEQ
			b = i -- VWEQ
			i = b -- VWEQ
			g = Void -- OK
			Void = g -- OK
			g = i -- OK
			i = g -- OK
			h = Void -- OK
			Void = h -- OK
			h = i -- OK
			i = h -- OK
			j = Void -- VWEQ
			Void = j -- VWEQ
			b = j -- VWEQ
			j = b -- VWEQ
			g = j -- OK
			j = g -- OK
		end

end