-- Cache for dependances tables

class REP_DEPEND_CACHE 

inherit

	CACHE [REP_CLASS_DEPEND]

creation

	make
	
feature 

	Cache_size: INTEGER is 20;
			-- Size of cache

end
