class B

inherit
	THREAD

create
	make

feature {NONE} -- Creation

	make (test_number: INTEGER) is
			-- Launch test number `test_number'.
		do
			internal_number := test_number
			launch
		end

feature -- Basic operations

	execute is
		do
			io.put_string ("Test ")
			io.put_integer (number)
			io.put_string (": OK")
			io.put_new_line
		end

feature {NONE} -- Status

	number: INTEGER is
			-- Test number
		once
			Result := internal_number
		end

	internal_number: INTEGER
			-- Current test number

end