class
	TEST2 [G]

inherit
	TEST1 [G]
		redefine
			item
		end

create 
	make

feature

	item: G
		do
			io.put_string ("TEST2")
			io.put_new_line
			Result := storage
		end

end
