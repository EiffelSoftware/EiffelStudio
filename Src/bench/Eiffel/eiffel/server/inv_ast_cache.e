indexing
	description: "Cache for abstract syntax description of invariants indexed by class id"
	date: "$Date$"
	revision: "$Revision$"

class INV_AST_CACHE 

inherit
	CACHE [INVARIANT_AS]

creation
	make
	
feature 

	Default_size: INTEGER is 20;
			-- Size of cache

end
