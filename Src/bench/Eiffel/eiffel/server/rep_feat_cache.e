-- Cache for replicated routines

class REP_FEAT_CACHE 

inherit

	CACHE [FEATURE_AS_B, BODY_ID]

creation

	make

	
feature 

	Default_size: INTEGER is 50;
			-- Size of cache

end
