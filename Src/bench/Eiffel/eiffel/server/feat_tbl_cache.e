-- Cache for routine tables

class FEAT_TBL_CACHE 

inherit

	CACHE [FEATURE_TABLE, CLASS_ID]

creation

	make
	
feature 

	Cache_size: INTEGER is 20;
			-- Size of cache

end
