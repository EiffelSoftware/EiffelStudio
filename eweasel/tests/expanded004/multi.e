class MULTI [G -> {NUMERIC, INTEGER rename one as second_integer end, COMPARABLE}]

feature

	p (a_g: G)
			-- 
		local
			l_numeric: NUMERIC
			l_any: ANY
			l_comparable: COMPARABLE
			l_g: detachable G
		do
			println ("Computation")
			println (a_g)
			l_g := a_g
			l_numeric := l_g
				-- Should *NOT* have an effect on l_numeric.
			l_g := l_g.one
			println (l_numeric + l_numeric)
			println (l_numeric + l_numeric - 11)

			println ("Comparison with reverse assignment")
			l_any := l_numeric
			l_comparable ?= l_any
			println (l_comparable)
			println (l_g)
			if l_comparable <= l_g then -- l_comparable should be 42 and a_g should be 1.
				println ("wrong")
			else
					-- This is the expected case
				println ("correct")
			end


			println ("Reverse assignment")
			l_g ?= l_numeric
			println (l_g)

			println ("Equality test #1")
			if l_numeric = l_any then
				println ("correct")
			else
				println ("wrong")
			end

			println ("Equality test #2")
			println (l_g)
			if l_numeric.twin = l_any then
				println ("correct")
			else
				println ("wrong")
			end

			println ("Equality test #3")
			create l_any
			if l_numeric = l_any then
				println ("wrong")
			else
				println ("correct")
			end
		end
	println (a_any: ANY)
			-- Prints `a_any' and adds a new line.
		do
			print (a_any)
			io.put_new_line
		end
end
