indexing
	description: "Cache for melted description indexed by class id."
	date: "$Date$"
	revision: "$Revision$"

class M_DESC_CACHE

inherit
	CACHE [MELTED_DESC]

creation
	make

feature

	Default_size: INTEGER is 20;
			-- Size of cache

end
