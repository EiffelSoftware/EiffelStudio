class
	TEST

inherit {NONE}
	TEST1

create
	make

feature {NONE} -- Initialization

	make is
		local
			l_constant: like constant
		do
			l_constant := constant
			io.put_string ("OK%N")
		end

end
