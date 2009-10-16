class
	TEST1 [G]

feature

	f 
		require
			b: items.for_all (agent loader.g)
			c: ({G}).has_default
			c: ({LINKED_LIST [G]}).has_default
		local
			bool: BOOLEAN
		do
			bool := items.for_all (agent loader.g)
		ensure
			c: items.for_all (agent loader.g)
		end

	items: ARRAYED_LIST [G]

	loader: TEST2 [G]

invariant
	d: items.for_all (agent loader.g)

end
