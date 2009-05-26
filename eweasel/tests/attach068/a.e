class A

create
	from_test

convert
	from_test ({TEST})

feature {NONE} -- Creation

	from_test (a: TEST)
		do
			io.put_string ("Test: OK")
			io.put_new_line
		end

end