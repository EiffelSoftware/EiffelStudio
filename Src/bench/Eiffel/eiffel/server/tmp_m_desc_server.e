indexing
	description: "Temporary server for melted description indexed by class id."
	date: "$Date$"
	revision: "$Revision$"

class TMP_M_DESC_SERVER

inherit
	DELAY_SERVER [MELTED_DESC]

creation
	make

feature

	id (t: MELTED_DESC): INTEGER is
			-- Id associated with `t'
		do
			Result := t.class_id
		end

	cache: M_DESC_CACHE is
		once
			!! Result.make
		end

	Delayed: SEARCH_TABLE [INTEGER] is
			-- Cache for delayed items
		once
			!!Result.make ((3 * Cache.cache_size) // 2)
		end

	Size_limit: INTEGER is 50
			-- Size of the TMP_M_DESC_SERVER file (50 Ko)

	Chunk: INTEGER is 50
			-- Size of a HASH_TABLE block

end
