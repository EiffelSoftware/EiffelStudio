class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		do
			io.put_integer (f (Current))
			io.put_new_line
		end

feature {NONE} -- Test

	f (c: TEST): INTEGER_32 is
			-- Call Eiffel feature via CECIL.
		external "C inline use %"eif_cecil.h%""
		alias "[
			return (
				(EIF_INTEGER_32 (*)(EIF_REFERENCE, EIF_INTEGER_32))
				(eif_integer_32_function ("g", eif_type_id ("TEST")))
			) ($c, 1);
		]"
		end

	g (a: INTEGER_32): INTEGER_32 is
			-- Print value of `a' and return its value incremented by 1.
		do
			io.put_integer (a)
			io.put_new_line
			Result := a + 1
		end

end
