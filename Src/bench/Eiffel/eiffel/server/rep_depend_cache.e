-- Cache for dependances tables

class REP_DEPEND_CACHE 

inherit

	CACHE [REP_CLASS_DEPEND, CLASS_ID]

creation

	make
	
feature 

	Default_size: INTEGER is 20;
			-- Size of cache

end
