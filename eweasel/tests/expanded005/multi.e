class MULTI [G -> {ANCESTOR_1, EXPANDED_CLASS, ANCESTOR_2}]

feature

	p (a_g: G)
			-- 
		local
--			l_a1: ANCESTOR_1
--			l_a2: ANCESTOR_2
			l_g: G
		do
			l_g := a_g
			l_g.change_state
			if l_g = a_g then
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
