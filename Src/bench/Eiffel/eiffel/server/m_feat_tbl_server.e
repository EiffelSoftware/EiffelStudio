-- Server for melted feature tables associated to file ".MLT1"

class M_FEAT_TBL_SERVER 

inherit
	COMPILER_SERVER [MELTED_FEATURE_TABLE, TYPE_ID]
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

	id (t: MELTED_FEATURE_TABLE): TYPE_ID is
			-- Id associated with `t'
		do
			Result := t.type_id
		end

	cache: M_FEAT_TBL_CACHE
			-- Cache for routine tables
		
feature -- Server size configuration

	Size_limit: INTEGER is 50
			-- Size of the M_FEAT_TBL_SERVER file (50 Ko)

	Chunk: INTEGER is 50
			-- Size of a HASH_TABLE block

end
