-- Server of class dependances for incremental type check

class DEPEND_SERVER 

inherit
	COMPILER_SERVER [CLASS_DEPENDANCE, CLASS_ID]

creation
	make
	
feature -- Access

	id (t: CLASS_DEPENDANCE): CLASS_ID is
			-- Id associated with `t'
		do
			Result := t.id
		end

	Cache: DEPEND_CACHE is
			-- Cache for routine tables
		once
			!!Result.make;
		end;

feature -- Server size configuration

	Size_limit: INTEGER is 100
			-- Size of the DEPEND_SERVER file (100 Ko)

	Chunk: INTEGER is 150
			-- Size of a HASH_TABLE block

end
