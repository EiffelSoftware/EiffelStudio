class STAT_CALL_SERVER inherit

	DELAY_SERVER [DLE_STATIC_CALLS, INTEGER_ID]

creation

	make
	
feature -- Server

	Cache: STAT_CALL_CACHE is
		once
			!!Result.make
		end;

	Delayed: SEARCH_TABLE [INTEGER_ID] is
			-- Cache for delayed items
		local
			csize: INTEGER
		once
			csize := Cache.cache_size;
			!!Result.make ((3 * csize) // 2)
		end;

	Size_limit: INTEGER is 40;

end -- class STAT_CALL_SERVER
