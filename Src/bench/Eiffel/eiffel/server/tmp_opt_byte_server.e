indexing
	description: "Temporary server of optimized byte code indexed by body id."
	date: "$Date$"
	revision: "$Revision$"

class TMP_OPT_BYTE_SERVER

inherit
	DELAY_SERVER [BYTE_CODE]

create
	make

feature

	id (t: BYTE_CODE): INTEGER is
			-- Id associated with `t'
		do
			Result := t.body_index
		end

	cache: BYTE_CACHE is
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

	Size_limit: INTEGER is 100
			-- Size of the TMP_OPT_BYTE_SERVER file (100 Ko)

	Chunk: INTEGER is 300
			-- Size of a HASH_TABLE block

end
