class
	TEST2 [G, H]

inherit
	TEST3 [H]
		redefine
			value
		end

create
	make

feature

	make 
		do
			print (value)
		end

	value: H
		do
			io.put_string (([Precursor]).generating_type)
			io.put_new_line

			io.put_string ((<< Precursor >>).generating_type)
			io.put_new_line
		end

end
