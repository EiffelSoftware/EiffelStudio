-- Cache for replicated routines

class REP_CACHE 

inherit

	CACHE [REP_FEATURES, CLASS_ID]

creation

	make

	
feature 

	Default_size: INTEGER is 50;
			-- Size of cache

end
