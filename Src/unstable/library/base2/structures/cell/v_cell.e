note
	description: "Cells containing an item."
	author: "Nadia Polikarpova"
	model: item

class
	V_CELL [G]

create
	put

feature -- Access

	item: G
			-- Content of the cell.

feature -- Replacement

	put (v: G)
			-- Replace `item' with `v'.
		note
			modify: item
		do
			item := v
		ensure
			item_effect: item = v
		end
end
