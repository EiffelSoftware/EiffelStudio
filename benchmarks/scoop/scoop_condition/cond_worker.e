class
	COND_WORKER

create
	make

feature

	num_iterations: INTEGER

	make (v: separate VAR; max: INTEGER)
		do
				-- Each worker shares a separate VAR.
			var := v
			num_iterations := max
		end

	var: separate VAR

	produce
		local
			i: INTEGER
		do
				-- Producers wait for the number in var to be odd many times.
			from
				i := 1
			until
				i > num_iterations
			loop
				produce_odd (var)
				i := i + 1
			end
			done := True
		end

	produce_odd (v: separate VAR)
		require
			v.i \\ 2 = 1
		local
			i: INTEGER
		do
			i := v.i
			v.set_i (v.i + 1)
		end

	consume
		local
			i: INTEGER
		do
				-- Consumers wait for the number in var to be even many times.
			from
				i := 1
			until
				i > num_iterations
			loop
				consume_even (var)
				i := i + 1
			end
			done := True
		end

	consume_even (v: separate VAR)
		require
			v.i \\ 2 = 0
		local
			i: INTEGER
		do
			i := v.i
			v.set_i (i + 1)
		end

	done: BOOLEAN

	is_done: BOOLEAN
		do
			Result := done
		end

end
