indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NON_CONFORMING_PARENT_C

inherit
	PARENT_C
		redefine
			is_non_conforming
		end

feature -- Status

	is_non_conforming: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

end
