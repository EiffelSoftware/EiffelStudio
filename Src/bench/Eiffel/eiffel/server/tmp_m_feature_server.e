indexing
	description: "Temporary server for melted feature byte code indexed by real body id."
	date: "$Date$"
	revision: "$Revision$"

class TMP_M_FEATURE_SERVER 

inherit
	DELAY_SERVER [MELT_FEATURE]

creation
	make

feature 

	id (t: MELT_FEATURE): INTEGER is
			-- Id associated with `t'
		do
			Result := t.real_body_id
		end

	cache: M_FEATURE_CACHE is
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
			-- Size of the TMP_M_FEATURE_SERVER file (50 Ko)

	Chunk: INTEGER is 50
			-- Size of a HASH_TABLE block

end
