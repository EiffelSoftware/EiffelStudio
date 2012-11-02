class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		do
		end

	check_equal (tag: STRING; b: BOOLEAN)
		do
			if not b then
				io.put_string ("Error in " + tag + "%N")
			end
		end

	env: EXECUTION_ENVIRONMENT
		once
			create Result
		end

end
