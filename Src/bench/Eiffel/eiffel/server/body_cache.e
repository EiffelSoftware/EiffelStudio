indexing
	description: "Cache for feature bodies indexed by body_index"
	date: "$Date$"
	revision: "$Revision$"

class BODY_CACHE 

inherit
	CACHE [FEATURE_AS]

creation
	make

feature 

	Default_size: INTEGER is 50;
			-- Size of cache

end
