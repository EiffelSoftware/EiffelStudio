-- Server of class dependances for incremental type check

class DEPEND_SERVER 

inherit
	COMPILER_SERVER [CLASS_DEPENDANCE, CLASS_ID]
		redefine
			make
		end

creation
	make

feature -- Initialisation

	make is
		-- Creation
		do
			{COMPILER_SERVER}Precursor
			!! cache.make
		end

	
feature -- Access

	id (t: CLASS_DEPENDANCE): CLASS_ID is
			-- Id associated with `t'
		do
			Result := t.id
		end

	cache: DEPEND_CACHE 
			-- Cache for routine tables
		
feature -- Server size configuration

	Size_limit: INTEGER is 100
			-- Size of the DEPEND_SERVER file (100 Ko)

	Chunk: INTEGER is 150
			-- Size of a HASH_TABLE block

end
