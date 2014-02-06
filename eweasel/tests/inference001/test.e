class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		local
			i
		do
			i := 5
			i := 7
			print (i)
			io.put_new_line
		end

end
