class CHILD_6 [G -> {H, INTEGER_32}, H]

inherit
	PARENT [G]

feature

	f (a: G; b: H)
		local
			g: G
			h: H
		do
			g := a
			h := b
			h := a
		end

end
