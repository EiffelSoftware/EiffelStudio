-- Cache for dependances tables

class DEPEND_CACHE 

inherit

	CACHE [CLASS_DEPENDANCE, CLASS_ID]

creation

	make
	
feature 

	Cache_size: INTEGER is 20;
			-- Size of cache

end
