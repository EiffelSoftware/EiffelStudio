class
	TEST

create
	make

feature -- Initialization

	make is
		local
			l_efx: NATIVE_EXCEPTION
			l_ee: E
			l_msg: SYSTEM_STRING
		do
			l_msg := "An exception occurred"
			create l_efx.make_from_message (l_msg)
			create l_ee.make_from_message (l_msg)
			
				-- Should be the same error message because {E} does not redefine NATIVE_EXCEPTION.to_string
			print ({SYSTEM_STRING}.compare (l_efx.to_string, l_ee.to_string) = 0)
			print ("%N")
		end

end