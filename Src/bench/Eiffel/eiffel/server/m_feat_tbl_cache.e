indexing
	description: "Cache for melted feature tables indexed by static type id."
	date: "$Date$"
	revision: "$Revision$"

class M_FEAT_TBL_CACHE 

inherit
	CACHE [MELTED_FEATURE_TABLE]

creation
	make
	
feature 

	Default_size: INTEGER is 20;
			-- Size of cache

end 
