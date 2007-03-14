class
		MULTI2 [G -> {H, I} create default_create end, H -> NUMERIC rename default_create as dn end, I -> {ANY}]

feature
	test
		local
			l_g: G
		do
			create l_g.dn
			create l_g.default_create
			create l_g
			l_g := l_g.one
			print (l_g.out)
		end
end
