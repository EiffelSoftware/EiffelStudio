note
	description: "Cells that can be linked to two neighbour cells."
	author: "Nadia Polikarpova"
	model: item, left, right

class
	V_DOUBLY_LINKABLE [G]

inherit
	V_CELL [G]

create
	put

feature -- Access

	right: detachable V_DOUBLY_LINKABLE [G]
			-- Next cell.

	left: detachable V_DOUBLY_LINKABLE [G]
			-- Previous cell.

feature -- Replacement

	put_right (cell: detachable V_DOUBLY_LINKABLE [G])
			-- Replace `right' with `cell'.
		note
			modify: right
		do
			right := cell
		ensure
			right_effect: right = cell
		end

	put_left (cell: detachable V_DOUBLY_LINKABLE [G])
			-- Replace `left' with `cell'.
		note
			modify: left
		do
			left := cell
		ensure
			left_effect: left = cell
		end

	connect (cell: V_DOUBLY_LINKABLE [G])
			-- Establish two-way connection with `cell' on the right.
			-- Do not modify `right' and `cell.left'.
		note
			modify: right, cell__left
		do
			put_right (cell)
			cell.put_left (Current)
		ensure
			right_effect: right = cell
			cell_left_effect: cell.left = Current
		end

end
