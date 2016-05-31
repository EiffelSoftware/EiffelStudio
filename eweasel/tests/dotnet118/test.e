class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		do
			f (1)
		end

	f (v: NATURAL_64)
		do
			io.put_string (v.out)
			io.put_new_line
		end
		
end
