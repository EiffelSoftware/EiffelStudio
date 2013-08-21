class TEST1 [G -> TUPLE]

create
	make

feature {NONE} -- Initialize

	make
		do
			create list.make
		end

feature -- Access

	list: LINKED_LIST [G]

	item: G

end
