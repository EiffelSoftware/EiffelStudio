indexing
	description: "Cache for AST indexed by class id"
	date: "$Date$"
	revision: "$Revision$"

class AST_CACHE 

inherit
	CACHE [CLASS_AS]

creation

	make

feature

	Default_size: INTEGER is 20;
			-- Size of cache

end
