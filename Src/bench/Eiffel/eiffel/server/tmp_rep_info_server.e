-- Server for class information on temporary file. This server is
-- used during the compilation and is not stored to disk at the
-- end of a successful compilation. 

class TMP_REP_INFO_SERVER 

inherit
	DELAY_SERVER [REP_CLASS_INFO, CLASS_ID]
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

	id (t: REP_CLASS_INFO): CLASS_ID is
			-- Id associated with `t'
		do
			Result := t.id
		end

	cache: REP_INFO_CACHE 
			-- Cache for routine tables

	Delayed: SEARCH_TABLE [CLASS_ID] is
			-- Cache for delayed items
			-- Cache for delayed items
		once
			!!Result.make ((3 * Cache.cache_size) // 2)
		end

	Size_limit: INTEGER is 50
			-- Size of the TMP_REP_INFO_SERVER file (50 Ko)

	Chunk: INTEGER is 150
			-- Size of a HASH_TABLE block

end
