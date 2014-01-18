class
	TEST

create
	make

feature

	make
		local
			i: INTEGER
		do
			i := euclid (13, 7)
			g
		end

	g
		do
		end

	euclid (a, b: INTEGER): INTEGER
			-- Greatest common divisor of a and b
		require
			a > 0;
			b > 0
		local
			m, n: INTEGER
		do
			from
				m := a;
				n := b
			invariant
				-- gcd (m, n) = gcd (a, b)
			variant
				m.max (n)
			until
				m = n
			loop
				if m > n then
					m := m - n
				else
					n := n - m
				end
			end
			Result := m
		end

end
