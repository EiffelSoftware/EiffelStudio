indexing
	description: "Cache for invariant byte code indexed by class id."
	date: "$Date$"
	revision: "$Revision$"

class INV_BYTE_CACHE 

inherit
	CACHE [INVARIANT_B]

creation
	make
	
feature 

	Default_size: INTEGER is 20;
			-- Size of cache

end
