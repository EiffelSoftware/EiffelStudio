class
	TEST1 [G -> detachable ANY]

create
	default_create, make

feature

	make 
		local
			l_g: detachable G
		do
			print (l_g)
			io.put_new_line
		end

end
