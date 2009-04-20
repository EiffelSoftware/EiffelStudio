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
				end
				i := i - 1
			end
		end

end
