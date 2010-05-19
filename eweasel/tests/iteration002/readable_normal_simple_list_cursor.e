class
	READABLE_NORMAL_SIMPLE_LIST_CURSOR[READABLE_G, G]

inherit
	SIMPLE_LIST_CURSOR[READABLE_G, G]
		rename
			item as forbidden_item,
			readable_item as item,
			move_to as forbidden_move_to,
			replace as forbidden_replace
		export{NONE}
			forbidden_item,
			forbidden_move_to,
			forbidden_replace
		redefine
			target
		end

create
	make

feature -- Access

	item: READABLE_G
	do
		result := target.first
	end

feature -- Status report

	after: BOOLEAN
	do
		result := false
	end

feature -- Changes

	forbidden_item: G
	do
		check attached {G} item as writeable_item then
			result := writeable_item
		end
	end

	forbidden_replace (new_item: G)
	do
	end

feature {NONE} -- Implementation

	target: READABLE_SIMPLE_LIST[READABLE_G, G]

end
