-- Cache for routine tables

class AST_CACHE 

inherit

	CACHE [CLASS_AS_B, CLASS_ID]

creation

	make

feature

	Default_size: INTEGER is 20;
			-- Size of cache

end
