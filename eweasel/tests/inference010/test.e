class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		local
			i; j; k
			x
			y
		do
			x := <<i>> -- target and source
			i := 5     -- source => target
			x := <<j>> -- target => source
			y := <<j>> -- source => target
			y := <<k>> -- target => source
			report (1, x [1] = 0)
			report (2, y [1] = 0)
			report (3, x.generating_type ~ y.generating_type)
		end

feature {NONE} -- Output

	report (test: INTEGER; value: BOOLEAN)
			-- Output `value' for test `test' on a new line.
		do
			io.put_string ("Test #")
			io.put_integer (test)
			if value then
				io.put_string (": OK.")
			else
				io.put_string (": Failed.")
			end
			io.put_new_line
		end

end
