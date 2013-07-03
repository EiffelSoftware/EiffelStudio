class A [G]
 
feature -- Access
 
	items: LINEAR [G]
		attribute
			create {ARRAYED_LIST [G]} Result.make (0)
		end
 
invariant
	test: (attached {LINEAR [detachable G]} items as l_items) and then not l_items.has (Void)

end
