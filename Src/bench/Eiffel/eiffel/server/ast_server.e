indexing
	description: "Server for storing AST indexed by class id"
	date: "$Date$"
	revision: "$Revision$"

class AST_SERVER 

inherit
	COMPILER_SERVER [CLASS_AS]

creation
	make
	
feature -- Access

	id (t: CLASS_AS): INTEGER is
			-- Id associated with `t'
		do
			Result := t.class_id
		end

	cache: AST_CACHE is
		-- Cache for routine tables
		once
			!! Result.make
		end
		
feature -- Server size configuration

	Size_limit: INTEGER is 400
			-- Size of the AST_SERVER file (400 Ko)

	Chunk: INTEGER is 500
			-- Size of a HASH_TABLE block

end
