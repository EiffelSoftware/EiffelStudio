-- Cache for melted feature byte code

class M_FEATURE_CACHE 

inherit

	CACHE [MELT_FEATURE, REAL_BODY_ID]

creation

	make

feature 

	Default_size: INTEGER is 20;
			-- Size of cache

end
