-- Temporary server for melted feature byte code associated to file ".TMP_MLT2"

class TMP_M_FEATURE_SERVER 

inherit

	DELAY_SERVER [MELT_FEATURE, REAL_BODY_ID]
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

	id (t: MELT_FEATURE): REAL_BODY_ID is
			-- Id associated with `t'
		do
			Result := t.real_body_id
		end

	cache: M_FEATURE_CACHE 
			-- Cache for routine tables

	Delayed: SEARCH_TABLE [REAL_BODY_ID] is
			-- Cache for delayed items
		once
			!!Result.make ((3 * Cache.cache_size) // 2)
		end

	Size_limit: INTEGER is 50
			-- Size of the TMP_M_FEATURE_SERVER file (50 Ko)

	Chunk: INTEGER is 50
			-- Size of a HASH_TABLE block

end
