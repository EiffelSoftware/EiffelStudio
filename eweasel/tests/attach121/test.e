class
	TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
				-- Note the bad name "foobar" instead of "foo".
			create foobar.make (agent do end)
		end

feature -- Access

	foo: ANY

end