class TEST

create
	default_create, make, make_from_other

feature {NONE} -- Creation

	make_from_other (other: separate TEST)
			-- Attached `other' to `a'.
		do
			a := other
		end

        make
        		-- Run test.
        	local
        		x: separate TEST
			p1: separate TEST
			p2: separate TEST
		do
			create x.make_from_other (create {separate TEST})
			create p1.make_from_other (x)
			create p2.make_from_other (x)
			start (p1, 0)
			start (p2, 1)
			wait (p1)
			wait (p2)
				-- 2 processors with 3 iterations produce 6.
			io.put_integer (value_of (x))
			io.put_new_line
		end

feature -- Access

	start (x: separate TEST; r: INTEGER)
			-- Run `x' with argument `r'.
		do
			x.run (r)
		end

	wait (x: separate TEST)
			-- Wait until `x' is ready.
		require
			x.done
		do
		end

	run (r: INTEGER)
			-- Make 3 calls to `g (a, r)'.
		local
			i: INTEGER
		do
			from
				-- Execute loop 3 times (for i in [0..2]).
			until
				i > 2
			loop
				i := i + 1
				if attached a as x then
					g (x, r)
				end
			end
			done := True
		rescue
			retry
		end

	g (x: separate TEST; r: INTEGER)
			-- Increment `x.value' when `x.value \\ 2 = r' and raise exception.
		require
			x.value \\ 2 = r
		do
			x.increment;
				-- Use `x.value' to make sure `x.increment' was completed.
			(create {EXCEPTIONS}).raise (x.value.out)
		end

	value_of (x: separate TEST): like value
			-- Value of `x'.
		do
			Result := x.value
		ensure
			Result = x.value
		end

	a: detachable separate TEST
			-- Other object (if any).

	done: BOOLEAN
			-- Has `run' completed?

	value: INTEGER
			-- Current value.

	increment
			-- Increment `value' by 1.
		do
			value := value + 1
		end

end
