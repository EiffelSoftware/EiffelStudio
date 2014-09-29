class TEST

create
	make

feature

	make
			-- Creation procedure.
		local
			test1: TEST1
		do
			test (test1)
		end

	test (a_value: ANY)
		require
			valid_form: attached {TEST1} a_value
		do
			check attached {TEST1} a_value then
				io.put_string ("Success%N")
			end
		end

end
