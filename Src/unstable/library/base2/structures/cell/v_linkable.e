note
	description: "Cells that can be linked to another cell."
	author: "Nadia Polikarpova"
	model: item, right

class
	V_LINKABLE [G]

inherit
	V_CELL [G]

create
	put

feature -- Access

	right: detachable V_LINKABLE [G]
			-- Next cell.

feature -- Replacement

	put_right (cell: detachable V_LINKABLE [G])
			-- Replace `right' with `cell'.
		note
			modify: right
		do
			right := cell
		ensure
			right_effect: right = cell
		end

end
