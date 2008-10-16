class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run test.
		do
			io.put_integer (c_f (Current))
			io.put_new_line
			io.put_integer (c_g (Current))
			io.put_new_line
		end

feature {NONE} -- Test

	c_f (c: TEST): INTEGER_32 is
			-- Call Eiffel feature `f' via CECIL.
		external "C inline use %"eif_cecil.h%""
		alias "[
			EIF_INTEGER_32 (*f)(EIF_REFERENCE, EIF_INTEGER_32);
			f = (EIF_INTEGER_32 (*)(EIF_REFERENCE, EIF_INTEGER_32))
				(eif_integer_32_function ("f", eif_type_id ("TEST")));
			if (f)
				return (f) (eif_access($c), 1);
			return 0;
		]"
		end

	c_g (c: TEST): INTEGER_32 is
			-- Call Eiffel feature `g' via CECIL.
		external "C inline use %"eif_cecil.h%""
		alias "[
			EIF_INTEGER_32 (*g)(EIF_REFERENCE, EIF_INTEGER_32);
			g = (EIF_INTEGER_32 (*)(EIF_REFERENCE, EIF_INTEGER_32))
				(eif_integer_32_function ("g", eif_type_id ("TEST")));
			if (g)
				return (g) (eif_access($c), 1);
			return 0;
		]"
		end

	f (a: INTEGER_32): INTEGER_32 is
			-- Print value of `a' and return its value incremented by $INCREMENT.
		do
			io.put_integer (a)
			io.put_new_line
			Result := a + $INCREMENT
		end

$G	g (a: INTEGER_32): INTEGER_32 is
$G			-- Print value of `a' and return its value incremented by $INCREMENT.
$G		do
$G			io.put_integer (a)
$G			io.put_new_line
$G			Result := a + $INCREMENT
$G		end

end
