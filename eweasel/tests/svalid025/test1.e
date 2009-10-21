class
	TEST1 [G]

feature

	f 
		require
			b: items.for_all (agent loader.g)
			c: ({G}).has_default
			d: ({LINKED_LIST [G]}).has_default
			e: ([items]) /= Void
			f: (<< items >>) /= Void
			g: (create {TEST2 [G]}) /= Void
			h: attached {TEST2 [G]} loader as l_loader and then l_loader.generator /= Void
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
