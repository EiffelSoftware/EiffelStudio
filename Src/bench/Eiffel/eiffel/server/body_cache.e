-- Cache for feature bodies

class BODY_CACHE 

inherit

	CACHE [FEATURE_AS, BODY_ID]

creation

	make

feature 

	Default_size: INTEGER is 50;
			-- Size of cache

end
