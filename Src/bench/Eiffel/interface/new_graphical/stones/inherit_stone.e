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

feature {NONE} -- Initialization

	make (a_figure: INHERITANCE_FIGURE) is
		do
			source := a_figure
		end

feature -- Access

	source: INHERITANCE_FIGURE
			-- Source this stone was picked from.

end -- class INHERIT_STONE
