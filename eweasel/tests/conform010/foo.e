class FOO [G -> H, H]

feature

	f (g: G)
		local
			h: H
		do
			h := g
		end

end
