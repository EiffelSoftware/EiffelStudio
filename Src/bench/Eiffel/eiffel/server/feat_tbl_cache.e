indexing
	description: "Cache for feature tables indexed by class id."
	date: "$Date$"
	revision: "$Revision$"

class FEAT_TBL_CACHE 

inherit
	CACHE [FEATURE_TABLE]

creation
	make
	
feature 

	Default_size: INTEGER is 20;
			-- Size of cache

end
