class
	TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Run test.
		do
			test ({FOO} "bar")
		end

feature -- Test

	test (foo: FOO)
		do
			print ("FOO: " + foo.string + "%N")
		end

end
