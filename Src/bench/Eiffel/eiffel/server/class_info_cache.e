-- Cache for class information

class CLASS_INFO_CACHE 

inherit

	CACHE [CLASS_INFO, CLASS_ID]

creation

	make

	
feature 

	Default_size: INTEGER is 20;
			-- Size of cache

end
