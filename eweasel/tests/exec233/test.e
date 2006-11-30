indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

create
	make

feature
	make is
		do
			test
		end

	test is
		require
			(agent (a_1: like b): BOOLEAN 
				local
					l_1: BOOLEAN
				do
					Result := l_1
				end).item ([True])
		do
		ensure
			(agent (a_1: like b): BOOLEAN 
				local
					l_1: BOOLEAN
				do
					l_1 := a_1 and l_1
					Result := l_1
				end).item ([True])

		end

	make_empty is
			-- Create empty string.
		do
		ensure
			empty: (agent: BOOLEAN do Result := count = 0 end).item ([])
			area_allocated: (agent (a_n: like capacity): BOOLEAN do Result := capacity >= a_n end).item ([10])
		end
	
	count: INTEGER
	b: BOOLEAN
	capacity: INTEGER is do end

invariant
	inv: (agent (a_1: BOOLEAN): BOOLEAN 
			local
				l_1: like b
			do
				l_1 := a_1 and l_1
				Result := l_1
			end).item ([True])

end
