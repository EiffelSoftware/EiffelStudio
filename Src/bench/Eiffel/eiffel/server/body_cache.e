-- Cache for feature bodies

class BODY_CACHE 

inherit

	CACHE [FEATURE_AS_B, BODY_ID]

creation

	make

feature 

	Cache_size: INTEGER is 50;
			-- Size of cache

end
