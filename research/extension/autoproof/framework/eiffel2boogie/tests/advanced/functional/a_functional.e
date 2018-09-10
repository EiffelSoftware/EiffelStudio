note
	explicit: "all"

class A_FUNCTIONAL

feature

	not_functional1
			-- Warning: no return type
		note
			status: functional
		do
		end

	not_functional2: INTEGER
			-- Error: not a single assignment	
		note
			status: functional
		local
			a: INTEGER
		do
			a := 1
			Result := a
		end

	functional1: INTEGER
			-- OK
		note
			status: functional
		require
			reads ([])
		do
			Result := 7
		end

	functional2 (a: INTEGER): INTEGER
			-- OK
		note
			status: functional
		do
			Result := a + 4
		end

	functional3 (a: A_FUNCTIONAL): INTEGER
			-- OK
		note
			status: functional
		do
			-- Checks are allowed in functional, to help prove validity of their bodies
			check assume: a /= Void end
			Result := a.functional1
		end

	call_functional
			-- OK
		do
			check functional1 = 7 end
			check functional2 (1) = 5 end
			check functional2 (2) = 6 end
		end

feature -- Preconditions

	functional4 (x: INTEGER): INTEGER
			-- OK
		note
			status: functional
		require
			positive: x >= 0
		do
			Result := x + 1
		end

	caller1
		local
			y: INTEGER
		do
			y := functional4 (1)  -- OK
			y := functional4 (-1) -- Bad
			y := functional2 (-1) -- OK
		end

	caller2
		do
		ensure
			bad: functional4 (-1) = 0
		end

feature -- Recursion

	factorial (x: INTEGER): INTEGER
		note
			status: functional
		do
			Result := if x <= 1 then 1 else x * factorial (x - 1) end
		end

	factorial_client (x: INTEGER; b: BOOLEAN)
		require
			x >= 5
		do
			if b then
				check factorial (x) = x * (x - 1) * factorial (x - 2) end -- No: two unrollings needed				
			else
				check factorial (x) = x * factorial (x - 1) end -- OK: one unrolling is enough				
			end
		end

invariant
	subjects = []
end
