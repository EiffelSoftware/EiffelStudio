indexing
	description: "Cache for byte code routine indexed by body_index"
	date: "$Date: "
	revision: "$Revision$"

class BYTE_CACHE 

inherit
	CACHE [BYTE_CODE]

creation
	make
	
feature 

	Default_size: INTEGER is 50;
			-- Size of cache

end
