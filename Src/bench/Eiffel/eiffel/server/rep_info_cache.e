-- Cache for class information

class REP_INFO_CACHE 

inherit

	CACHE [REP_CLASS_INFO, CLASS_ID]

creation

	make

	
feature 

	Default_size: INTEGER is 20;
			-- Size of cache

end
