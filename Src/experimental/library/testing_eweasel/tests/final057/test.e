class TEST
	
create
	make

feature {NONE}

	make
		local
			test1: TEST1
			l_string: STRING
		do
			create test1.make
			l_string := "FDfds"
			test1.check_type (l_string)
		end

end
