indexing
	description: "Cache for melted feature byte code indexed by real body id"
	date: "$Date$"
	revision: "$Revision$"

class M_FEATURE_CACHE 

inherit
	CACHE [MELT_FEATURE]

creation
	make

feature 

	Default_size: INTEGER is 20;
			-- Size of cache

end
