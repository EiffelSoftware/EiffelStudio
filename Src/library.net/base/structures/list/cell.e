indexing
	description: "Cells containing an item"
	external_name: "ISE.Base.Cell"

class 
	CELL [G]

create
	put

feature -- Access

	item: G is
		indexing
			description: "Content of cell"
		do
			Result := internal_item
		end

feature -- Element change

	put (v : G) is
		indexing
			description: "Make `v' the cell's `item'."
		do
			internal_item := v
		ensure
			item_inserted: item = v
		end

	replace (v : G) is
		indexing
			description: "Make `v' the cell's `item'."
		do
			internal_item := v
		ensure
			item_inserted: item = v
		end
		
feature -- Implementation

	internal_item: G

end -- class CELL



