class FOO

create
	make

feature {NONE} -- Initialization

	make
		do
			create attr.make
		end

feature 

	f
		do
			io.put_string (([attr]).generating_type.out)
			io.put_new_line
			io.put_string (([attr.val]).generating_type.out)
			io.put_new_line
		end

	attr: X

end
