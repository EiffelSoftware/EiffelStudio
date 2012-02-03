class A

inherit
	THREAD
		rename
			make as thread_make
		end

create
	make

feature {NONE} -- Creation

	make (test_number: INTEGER) is
			-- Launch test number `test_number'.
		do
			thread_make
			number := test_number
			launch
		end

feature -- Basic operations

	execute is
		once
			io.put_string ("Test ")
			io.put_integer (number)
			io.put_string (": OK")
			io.put_new_line
		end

feature {NONE} -- Status

	number: INTEGER
			-- Current test number

end
