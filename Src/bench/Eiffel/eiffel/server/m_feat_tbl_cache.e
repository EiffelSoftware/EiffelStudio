-- Cache for melted feature tables

class M_FEAT_TBL_CACHE 

inherit

	CACHE [MELTED_FEATURE_TABLE, TYPE_ID]

creation

	make
	
feature 

	Default_size: INTEGER is 20;
			-- Size of cache

end 
