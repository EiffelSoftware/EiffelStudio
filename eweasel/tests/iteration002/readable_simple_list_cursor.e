deferred class
	READABLE_SIMPLE_LIST_CURSOR[READABLE_G, G]

inherit
	ITERATION_CURSOR[G]
		rename
			item as forbidden_item
		export {NONE}
			forbidden_item
		end

feature -- Access

	item: READABLE_G
		-- Item at current cursor position
	require
		is_valid: is_valid
		is_set: is_set
		valid_position: not after
	deferred
	end

end

