indexing

	description: 
		"Cells containing two items.";
	date: "$Date$";
	revision: "$Revision $"

class
	
	CELL2 [G, H]

inherit

	CELL [G]
		rename
			item as item1,
			put as put1,
			replace as replace1
		end

creation

	make

feature -- Initialization

	make (v: like item1; u: like item2) is
			-- Make `v' and `u' the cell's items.
		do
			item1 := v;
			item2 := u
		ensure
			item1_inserted: item1 = v;
			item2_inserted: item2 = u
		end;

feature -- Access

	item2: H;
			-- Second item of the cell

feature -- Element change

	put2, replace2 (u: like item2) is
			-- Make `u' the second cell's item.
		do
			item2 := u
		ensure
			item2_inserted: item2 = u
		end;

end -- class CELL2
