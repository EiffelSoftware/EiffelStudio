indexing
	description: "Temporary server of polymorphic unit tables indexed by routine id."
	date: "$Date$"
	revision: "$Revision$"

class TMP_POLY_SERVER

inherit
	DELAY_SERVER [POLY_TABLE [ENTRY]]

create
	make

feature

	id (t: POLY_TABLE [ENTRY]): INTEGER is
			-- Id associated with `t'
		do
			Result := t.rout_id
		end

	cache: POLY_CACHE is
			-- Cache for routine tables
		once
			create Result.make
		end

	Delayed: SEARCH_TABLE [INTEGER] is
			-- Cache for delayed items
		once
			create Result.make ((3 * Cache.cache_size) // 2)
		end

feature -- Server parameters

	Size_limit: INTEGER is 200
			-- Size of the TMP_POLY_SERVER file (200 Ko)

	Chunk: INTEGER is 3000
			-- Size of a HASH_TABLE block

end
