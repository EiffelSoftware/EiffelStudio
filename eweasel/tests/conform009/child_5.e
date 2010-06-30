class CHILD_5 [expanded G -> H, H]

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
