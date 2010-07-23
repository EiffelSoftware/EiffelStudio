class C [G, H, I -> {TEST, A [J]}, J]

inherit
	B [I, J]
		redefine
			h
		end

feature $EXPORT -- Test

	h (a: I; b: J)
		do
		end

end
