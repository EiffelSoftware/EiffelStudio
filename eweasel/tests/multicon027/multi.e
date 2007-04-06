class
	MULTI [G -> H create default_create end, H -> NUMERIC]

create
	make

feature
	make
		local
			l_g: G
		do
			create l_g
			create l_g.default_create
			l_g := l_g.one
			print (l_g.out)
			io.put_new_line
		end
end
