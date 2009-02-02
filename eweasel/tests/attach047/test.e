class
	TEST

create
	make

feature {NONE} -- Creation

	make (args: ARRAY [STRING])
		do
			io.put_string (args.generating_type)
			io.put_new_line
		end

end
