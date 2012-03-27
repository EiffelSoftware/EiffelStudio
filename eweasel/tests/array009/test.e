class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run tests.
		local
			a: ARRAY [STRING]
		do
				-- Insert 3 items at normal position.
			create a.make_empty
			a.force ("a", 1)
			a.force ("b", 2)
			a.force ("c", 3)
				-- Put new values to existing positions.
			a.force ("d", 1)
			a.force ("e", 2)
			a.force ("f", 3)
				-- Set `a.lower' to minimum value.
			a.rebase ({INTEGER}.min_value)
				-- Put new values to existing positions.
			a.force ("g", a.lower)
			a.force ("h", a.lower + 1)
				-- Set `a.upper' to maximum value.
			a.rebase ({INTEGER}.max_value - a.count + 1)
				-- Put new values to existing positions.
			a.force ("i", a.upper)
			a.force ("j", a.upper - 1)
		end

end
