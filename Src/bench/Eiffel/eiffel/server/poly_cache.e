indexing
	description: "Cache for polymorphic unit tables indexed by routine id."
	date: "$Date$"
	revision: "$Revision$"

class POLY_CACHE

inherit
	CACHE [POLY_TABLE [ENTRY]]

creation
	make

feature

	Default_size: INTEGER is 200;
			-- Size of cache

end
