indexing
	description: "Cache for dependances tables of replicated features indexed by class id."
	date: "$Date$"
	revision: "$Revision$"

class REP_DEPEND_CACHE 

inherit
	CACHE [REP_CLASS_DEPEND]

creation
	make
	
feature 

	Default_size: INTEGER is 20;
			-- Size of cache

end
