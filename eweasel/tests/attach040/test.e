class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		do
			perform ("OK")
		end


	perform (a_string: detachable STRING)
			-- This precondition should not compile
		do
		ensure
			test: attached {STRING} a_string as el_string implies old test (el_string)
		end


	test (a_string: attached STRING): BOOLEAN
			-- Required to perform test
		do
			if attached {STRING} a_string as l_string then
				print (l_string)
				Result := True
			else
				print ("FAILED")
				Result := False
			end
			print ('%N')
		end

end

