indexing
	description: "Temporary server for melted feature tables indexed by static type id."
	date: "$Date$"
	revision: "$Revision$"

class TMP_M_FEAT_TBL_SERVER 

inherit
	DELAY_SERVER [MELTED_FEATURE_TABLE]

creation
	make
	
feature 

	id (t: MELTED_FEATURE_TABLE): INTEGER is
			-- Id associated with `t'
		do
			Result := t.type_id
		end

	cache: M_FEAT_TBL_CACHE is
			-- Cache for routine tables
		once
			!! Result.make
		end

	Delayed: SEARCH_TABLE [INTEGER] is
			-- Cache for delayed items
		once
			!!Result.make ((3 * Cache.cache_size) // 2)
		end

	Size_limit: INTEGER is 50
			-- Size of the TMP_M_FEAT_TBL_SERVER file (50 Ko)

	Chunk: INTEGER is 50
			-- Size of a HASH_TABLE block

end
