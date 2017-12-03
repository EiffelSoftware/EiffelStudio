class
	READABLE_SIMPLE_LIST[READABLE_G, G]

inherit
	ITERABLE[G]

create
	make

feature {NONE} -- Initialization

	make
	local
		value: detachable READABLE_G
	do
		check attached value then
			create list.make_filled (value, 1, 0)
		end
	end

feature -- Iteration

	first: READABLE_G
	do
		result := list[1]
	end

	list: ARRAY[READABLE_G]

	new_cursor: READABLE_NORMAL_SIMPLE_LIST_CURSOR[READABLE_G, G]
	do
		create Result.make(current)
	end

end
