indexing
	description:
		"Cells containing an item"

class
	CELL [G]
alias
	"ISE.Base.Cell"

create
	put

feature -- Access

	item: G
			-- Content of cell

feature -- Element change

	put, replace (v : like item) is
			-- Make `v' the cell's `item'.
		do
			item := v
		ensure
			item_inserted: item = v
		end

end -- class CELL