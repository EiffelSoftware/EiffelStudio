-- Server for routine tables

class AST_SERVER 

inherit
	COMPILER_SERVER [CLASS_AS, CLASS_ID]

creation
	make
	
feature -- Access

	id (t: CLASS_AS): CLASS_ID is
			-- Id associated with `t'
		do
			Result := t.id
		end

	Cache: AST_CACHE is
			-- Cache for routine tables
		once
			!! Result.make
		end

feature -- Server size configuration

	Size_limit: INTEGER is 200
			-- Size of the AST_SERVER file (200 Ko)

	Chunk: INTEGER is 150
			-- Size of a HASH_TABLE block

end
