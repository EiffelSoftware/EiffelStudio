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

feature -- Access

	source: EIFFEL_CLIENT_SUPPLIER_FIGURE
			-- Source this stone was picked from.

end -- class CLIENT_STONE
