class TEST

create
	make

feature {NONE} -- Creation

	make
		local
			a: separate A
		do
			create a.make (Current)
			test_a (a)
		end

feature

	test_a (a_a: separate A)
		do
			a_a.perform_creation_logging
		end

	test_test
		local
			a: separate A
		do
			create a.make (Current)
		end

end
