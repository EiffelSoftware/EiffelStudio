class TEST1 [G -> TUPLE create default_create end]

create
	make

feature {NONE} -- Initialize

	make
		do
			create item
			create list.make
		end

feature -- Access

	list: LINKED_LIST [G]

	item: G

end
