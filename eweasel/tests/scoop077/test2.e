class TEST

create
	default_create,
	make

feature {NONE} -- Creation

	make
			-- Run application.
		local
			s: separate ITERABLE [separate TEST]
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
					c.item.report (i) -- VUTA(3) for `report`
				end
			end
			separate s as ss do
				across
					ss is c
				loop
					i := i + 1
					c.report (i) -- VUTA(3) for `report`
				end
			end
			io.put_integer (0)
			io.put_new_line
		end

feature -- Access

	data: ITERABLE [separate TEST]
			-- Some iterable data.
		do
			create {ARRAY [separate TEST]} Result.make_filled (create {separate TEST}, 1, 5)
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
