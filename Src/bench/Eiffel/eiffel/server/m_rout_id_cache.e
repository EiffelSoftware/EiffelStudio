indexing
	description: "Cache for melted routine IDs indexed by class id."
	date: "$Date$"
	revision: "$Revision$"

class M_ROUT_ID_CACHE

inherit
	CACHE [MELTED_ROUTID_ARRAY]

creation
	make

feature

	Default_size: INTEGER is 20;
			-- Size of cache

end
