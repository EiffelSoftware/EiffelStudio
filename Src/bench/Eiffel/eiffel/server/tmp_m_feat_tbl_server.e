-- Temporary server for melted feature tables associated to file ".TMP_MLT1"

class TMP_M_FEAT_TBL_SERVER 

inherit
	DELAY_SERVER [MELTED_FEATURE_TABLE, TYPE_ID]
		redefine
			make
		end

creation
	make

feature -- Initialisation

	make is
		-- Creation
		do
			{DELAY_SERVER}Precursor
			!! cache.make
		end


	
feature 

	id (t: MELTED_FEATURE_TABLE): TYPE_ID is
			-- Id associated with `t'
		do
			Result := t.type_id
		end

	cache: M_FEAT_TBL_CACHE 
			-- Cache for routine tables

	Delayed: SEARCH_TABLE [TYPE_ID] is
			-- Cache for delayed items
		once
			!!Result.make ((3 * Cache.cache_size) // 2)
		end

	Size_limit: INTEGER is 50
			-- Size of the TMP_M_FEAT_TBL_SERVER file (50 Ko)

	Chunk: INTEGER is 50
			-- Size of a HASH_TABLE block

end
