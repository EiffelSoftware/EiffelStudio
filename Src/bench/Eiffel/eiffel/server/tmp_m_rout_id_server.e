indexing
	description: "Temporary server for melted routine indexed by class id."
	date: "$Date$"
	revision: "$Revision$"

class TMP_M_ROUT_ID_SERVER

inherit
	DELAY_SERVER [MELTED_ROUTID_ARRAY]

creation
	make

feature

	id (t: MELTED_ROUTID_ARRAY): INTEGER is
			-- Id associated with `t'
		do
			Result := t.class_id
		end

	cache: M_ROUT_ID_CACHE is
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
			-- Size of the TMP_M_ROUT_ID_SERVER file (50 Ko)

	Chunk: INTEGER is 50
			-- Size of a HASH_TABLE block

end
