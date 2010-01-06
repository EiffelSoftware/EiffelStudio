class
		MULTI2 [G -> {H, I} create default_create end, H -> {NUMERIC rename default_create as dn end, ANY, ANY rename default_create as dn2 end}, I -> {ANY rename default_create as dn3, out as my_out end}]

create
	make

feature
	make
		local
			l_g: G
		do
			$WRONG_CREATION
			create l_g.default_create
			create l_g
			l_g := l_g.one
			print (l_g.my_out)
			io.put_new_line
		end
end
