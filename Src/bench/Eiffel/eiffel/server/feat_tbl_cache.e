-- Cache for routine tables

class FEAT_TBL_CACHE 

inherit

	CACHE [FEATURE_TABLE]

creation

	make
	
feature 

	Cache_size: INTEGER is 20;
			-- Size of cache

end
