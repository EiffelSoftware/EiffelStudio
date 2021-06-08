class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		local
			b1; b2; b3; b4; b5; b6; b7; b8; b9; b10; b11
		do
				-- Output.
			report (1, b1.generating_type)
			report (2, b2.generating_type)
			report (3, b3.generating_type)
			report (4, b4.generating_type)
			report (5, b5.generating_type)
			report (6, b6.generating_type)
			report (7, b7.generating_type)
			report (8, b8.generating_type)
			report (9, b9.generating_type)
			report (10, b10.generating_type)
			report (11, b11.generating_type)
				-- Conditional instruction.
			if b1 then
			elseif b2 then
			end
				-- Conditional expression.
			;(if b3 then "" elseif b4 then "" else "" end).do_nothing
				-- Next constructs are protected from execution
				-- because they either raise an exception or never terminate.
			if False then
					-- Check instruction.
				check b5 end
				check b6 then end
					-- Loop instruction.
				from
				invariant
					b7
				until
					b8
				loop
				end
			end
				-- Loop expression.
			;(across "" as c invariant b9 until b10 all b11 end).do_nothing
		end

feature {NONE} -- Output

	report (test: INTEGER; value: TYPE [detachable separate ANY])
			-- Output `value' for test `test' on a new line.
		do
			io.put_string ("Test #")
			io.put_integer (test)
			io.put_string (": ")
			io.put_string (value.out)
			io.put_new_line
		end

end
