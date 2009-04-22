class
	TEST

create
	make

feature

	make
			-- Run tests.
		local
			i: INTEGER
			s: detachable STRING
		do
			from
				s := "abc"
				i := s.count
			until
				i <= 0
			loop
				if s.item (i) = 'b' then
					s := Void
				elseif attached s as v then
					v.put ('b', i)
				elseif attached {TEST} s then
					(agent do end).call ([])
				end
				i := i - 1
			end
		end

end
