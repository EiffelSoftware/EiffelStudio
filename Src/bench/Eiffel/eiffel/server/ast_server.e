-- Server for routine tables

class AST_SERVER 

inherit
	COMPILER_SERVER [CLASS_AS_B, CLASS_ID]

creation
	make
	
feature 

	id (t: CLASS_AS_B): CLASS_ID is
			-- Id associated with `t'
		do
			Result := t.id
		end

	Cache: AST_CACHE is
			-- Cache for routine tables
		once
			!! Result.make
		end

	Size_limit: INTEGER is 100
			-- Size of the AST_SERVER file (100 Ko)

	Chunk: INTEGER is 150
			-- Size of a HASH_TABLE block

end
