class TMP_M_DESC_SERVER

inherit
	DELAY_SERVER [MELTED_DESC, CLASS_ID]
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

	id (t: MELTED_DESC): CLASS_ID is
			-- Id associated with `t'
		do
			Result := t.class_id
		end

	cache: M_DESC_CACHE 

	Delayed: SEARCH_TABLE [CLASS_ID] is
			-- Cache for delayed items
		once
			!!Result.make ((3 * Cache.cache_size) // 2)
		end

	Size_limit: INTEGER is 50
			-- Size of the TMP_M_DESC_SERVER file (50 Ko)

	Chunk: INTEGER is 50
			-- Size of a HASH_TABLE block

end
