class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
			io.put_natural_8 ({A}.natural_constant)
			io.put_new_line
			io.put_natural_16 ({A}.natural_external)
			io.put_new_line
			io.put_natural_32 ({A}.natural_function)
			io.put_new_line
			io.put_natural_64 ({A}.natural_once)
			io.put_new_line
			io.put_string ({A}.string_constant.out)
			io.put_new_line
			io.put_string ({A}.string_external ({STRING_32} "string_external").out)
			io.put_new_line
			io.put_string ({A}.string_function.out)
			io.put_new_line
			io.put_string ({A}.string_once.out)
			io.put_new_line
		end

end