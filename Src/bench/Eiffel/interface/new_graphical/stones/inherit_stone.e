indexing
	description: "Stones that represent inheritance links."
	date: "$Date$"
	revision: "$Revision$"

class
	INHERIT_STONE

inherit
	LINK_STONE
		redefine
			source
		end
	
create
	make

feature -- Access

	source: EIFFEL_INHERITANCE_FIGURE
			-- Source this stone was picked from.

end -- class INHERIT_STONE
