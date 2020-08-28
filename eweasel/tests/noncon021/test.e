class
	TEST

inherit {NONE}
	TEST1

create
	make

feature {NONE} -- Initialization

	make
		local
			l_string_reference: like string_reference
		do
			l_string_reference := string_reference
			io.put_string ("OK%N")
		end

end
