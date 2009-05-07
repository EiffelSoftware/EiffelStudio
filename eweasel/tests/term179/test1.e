class
	TEST1 [G]

feature

	foo (v: G)
		do
			print (agent (m: G; t: TYPE [G]): G
				do
					print (t)
					print (m)
				end)
		end


end
