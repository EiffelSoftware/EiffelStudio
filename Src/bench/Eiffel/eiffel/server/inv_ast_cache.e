-- Cache for abstract syntax description of invariants

class INV_AST_CACHE 

inherit

	CACHE [INVARIANT_AS, CLASS_ID]

creation

	make
	
feature 

	Default_size: INTEGER is 20;
			-- Size of cache

end
