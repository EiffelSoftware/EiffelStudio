indexing
	description: "Cache for class information indexed by class id."
	date: "$Date$"
	revision: "$Revision$"

class CLASS_INFO_CACHE 

inherit
	CACHE [CLASS_INFO]

creation
	make

feature 

	Default_size: INTEGER is 20;
			-- Size of cache

end
