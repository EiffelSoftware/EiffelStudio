-- Cache for DLE servers of statically bound feature calls.

class STAT_CALL_CACHE inherit

	CACHE [DLE_STATIC_CALLS, INTEGER_ID]

creation

	make
	
feature 

	default_size: INTEGER is 20;
			-- Size of cache

end -- class STAT_CALL_CACHE
