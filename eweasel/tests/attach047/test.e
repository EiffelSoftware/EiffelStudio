class
	TEST

create
	make

feature {NONE} -- Creation

	make (args: ARRAY [STRING])
		do
			print (args.generating_type)
			io.put_new_line
		end

end
