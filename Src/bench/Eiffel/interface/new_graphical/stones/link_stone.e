indexing
	description: "Stones that represent links."
	date: "$Date$"
	revision: "$Revision$"

class
	LINK_STONE
	
create
	make
	
feature {NONE} -- Initialization

	make (a_source: like source) is
			-- Create a link stone transporting `a_source'.
		require
			a_source_not_void: a_source /= Void
		do
			source := a_source
		ensure
			set: source = a_source
		end

feature -- Access

	source: EIFFEL_LINK_FIGURE
			-- Source this stone was picked from.

end -- class LINK_STONE
