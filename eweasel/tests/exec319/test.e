class TEST

inherit
	A

create
	make

feature {NONE} -- Tests

	is_tested_with_assertions: BOOLEAN
		require else
				-- The next condition is False, so the inherited precondition should be True.
			across data (<<-1, -2, -3>>) as c some c.item > 0 end
		local
			i: INTEGER
		do
			across
				data (<<1, 0>>) as c
			invariant
				not across data (<<1, 2, -3>>) as d all d.item > 0 end
			until
				c.item = 0
			loop
				i := i + 1
			end
			Result := i = 1
		ensure then
			not across data (<<-1, -2, 3>>) as c all c.item > 0 end
		end

end
