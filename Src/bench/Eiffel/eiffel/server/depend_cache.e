indexing
	description: "Cache for dependances tables indexed by class id."
	date: "$Date$"
	revision: "$Revision$"

class DEPEND_CACHE 

inherit
	CACHE [CLASS_DEPENDANCE]

create
	make
	
feature 

	Default_size: INTEGER is 20;
			-- Size of cache

end
