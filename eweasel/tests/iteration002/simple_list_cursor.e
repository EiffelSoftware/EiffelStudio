deferred class
	SIMPLE_LIST_CURSOR[READABLE_G, G]

inherit
	READABLE_SIMPLE_LIST_CURSOR[READABLE_G, G]
		rename
			item as readable_item,
			forbidden_item as item
		export {ANY}
			item
		end

feature -- Cursor movement

	move_to (new_index: INTEGER)
	do
	end

feature -- Changes

	replace (new_item: G)
	deferred
	end

end
