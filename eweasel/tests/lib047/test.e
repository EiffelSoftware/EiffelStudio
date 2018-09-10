class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
			create a.make_empty
			a.balanced_linear_search (1, 1)
			report (1)
			a.binary_search (1)
			report (2)
			a.linear_search (1)
			report (3)
		end

feature {NONE} -- Access

	a: SORTABLE_ARRAY [INTEGER]
			-- An empty array to search in.

feature {NONE} -- Output

	report (n: NATURAL_8)
			-- Report whether test number `n` is passed:
			-- "OK" if no matching item is found,
			-- "Failed" otherwise.
		do
			io.put_string ("Test #")
			io.put_natural_8 (n)
			io.put_string (if a.found then ": Failed%N" else ": OK%N" end)
		end

end
