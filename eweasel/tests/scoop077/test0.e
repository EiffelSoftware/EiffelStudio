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
			across
				s as c            -- VUTA(3) for `s.new_cursor`
			loop                      -- VUTA(3) for `c.after`
				i := i + 1
				c.item.report (i) -- VUTA(3) for `c.item`; VUTA(3) for `report`
			end                       -- VUTA(3) for `c.forth`
			across
				s is c            -- VUTA(3) for `s.new_cursor`
			loop                      -- VUTA(3) for `c.after`
				i := i + 1
				c.report (i)      -- VUTA(3) for `c.item`; VUTA(3) for `report`
			end                       -- VUTA(3) for `c.forth`
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
			-- Report a test `n` is passing.
		do
				-- Wait 1 second before printing.
			(create {EXECUTION_ENVIRONMENT}).sleep (1_000_000_000)
			io.put_integer (n)
			io.put_new_line
		end

end
