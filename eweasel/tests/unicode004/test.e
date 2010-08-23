class
	test

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			print_code ("¡¢£¤¥")
		end

	print_code (a_string: STRING_8)
		local
			i: INTEGER
			s: STRING_8
		do
			from
				i := 1
			until
				i > a_string.count
			loop
				s := a_string.item_code (i).to_hex_string
				s.keep_tail (2)
				print (s)
				print (" ")
				i := i + 1
			end
			print ("%N")
		end

end
