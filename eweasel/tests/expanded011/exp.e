expanded class EXP

feature

	i: INTEGER

	allocate_memory
		local
			m: MEMORY
		do
			i := -1
			create m
			m.collect
		end
end
