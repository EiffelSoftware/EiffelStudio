indexing
	description: "Stones that represent client links."
	date: "$Date$"
	revision: "$Revision$"

class
	CLIENT_STONE

inherit
	LINK_STONE
		redefine
			source
		end

create
	make

feature {NONE} -- Initialization

	make (a_figure: CLIENT_SUPPLIER_FIGURE) is
		do
			source := a_figure
		end

feature -- Access

	source: CLIENT_SUPPLIER_FIGURE
			-- Source this stone was picked from.

end -- class CLIENT_STONE
