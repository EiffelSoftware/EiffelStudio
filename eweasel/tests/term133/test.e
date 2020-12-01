class
	TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run tests.
		do
			(create {A [ANY]}).      test ("ANY")
			(create {A [BOOLEAN]}).  test ("BOOLEAN")
			(create {A [CHARACTER]}).test ("CHARACTER_8")
			(create {A [STRING]}).   test ("STRING_8")
			(create {A [TEST]}).     test ("TEST")
		end

end
