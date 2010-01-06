
class TEST
create
	make

feature {NONE} -- Creation

	make
		do
		end

feature

	print_length
		external
			"C macro use %"test.h%""
		alias
			"(ub1) 0"
		end

	the_length2: INTEGER
		external
			"C macro use %"test.h%""
		alias
			"47"
		end

	length3: INTEGER
		external
			"C macro use %"test.h%""
		alias
			"47"
		end

	set_is_expired (b: BOOLEAN)
		do
			set_boolean_value (address, b)
		end

	set_boolean_value (addr: POINTER b: BOOLEAN)
		external
			"C"
		end

	address: POINTER

	length1: INTEGER
		external
			"C macro use %"test.h%""
		alias
			"47"
		end

end
