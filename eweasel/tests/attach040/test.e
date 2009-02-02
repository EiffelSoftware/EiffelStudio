class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		do
			perform ("OK")
		end


	perform (a_string: ?STRING)
			-- This precondition should not compile
		do
		ensure
			test: {el_string: STRING} a_string implies old test (el_string)
		end


	test (a_string: !STRING): BOOLEAN
			-- Required to perform test
		do
			if {l_string: STRING} a_string then
				print (l_string)
				Result := True
			else
				print ("FAILED")
				Result := False
			end
			print ('%N')
		end

end

