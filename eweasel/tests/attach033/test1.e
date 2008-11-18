class
	TEST1 [G]

create
	default_create, make

feature

	make 
		local
			l_g: G
		do
			print (l_g)
			io.put_new_line
		end

end
