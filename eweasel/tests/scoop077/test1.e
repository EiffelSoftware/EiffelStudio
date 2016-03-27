class TEST

create
	default_create,
	make

feature {NONE} -- Creation

	make
			-- Run application.
		local
			s: separate ITERABLE [TEST]
			i: INTEGER
		do
			separate (create {separate TEST}) as t do
				s := t.data
			end
			separate s as ss do
				across
					ss as c
				loop
					i := i + 1
					c.item.report (i)
				end
			end
				-- This is going to be printed after the loop
				-- because `t.report (i)' above is executed on
				-- a controlled target that is used in expressions
				-- in the loop and therefore is synchronous.
			io.put_integer (0)
			io.put_new_line
		end

feature -- Access

	data: ITERABLE [TEST]
			-- Some iterable data.
		do
			create {ARRAY [TEST]} Result.make_filled (Current, 1, 5)
		end

feature -- Output

	report (n: INTEGER)
			-- Report a test `n' is passing.
		do
				-- Wait 1 second before printing.
			(create {EXECUTION_ENVIRONMENT}).sleep (1_000_000_000)
			io.put_integer (n)
			io.put_new_line
		end

end
