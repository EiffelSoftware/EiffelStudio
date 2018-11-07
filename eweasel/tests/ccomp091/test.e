class
	TEST

create
	make

feature {NONE} -- Creation

	make
		local
			i: TYPED_POINTER [TYPED_POINTER [INTEGER]]
		do
			report (not attached {REAL_64} default_pointer, 1)
			report (attached {TYPED_POINTER [TYPED_POINTER [INTEGER]]} i, 2)
			report (not attached {TYPED_POINTER [TYPED_POINTER [POINTER]]} i, 3)
		end

feature {NONE} -- Output

	report (is_passing: BOOLEAN; number: NATURAL_8)
			-- Report whether a test identified by `number` passes according to `is_passing`.
		do
			io.put_string ("Test #")
			io.put_natural_8 (number)
			io.put_string
				(if is_passing then
					": OK"
				else
					": Failed"
				end)
			io.put_new_line
		end

end
