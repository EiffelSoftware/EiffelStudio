class
	MULTI [G -> H create default_create end, H -> NUMERIC]

feature
	test
		local
			l_g: G
		do
			create l_g
			l_g := l_g.one
		end
end
