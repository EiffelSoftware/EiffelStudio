-- Server for class information on temporary file. This server is
-- used during the compilation and is not stored to disk at the
-- end of a successful compilation. 

class TMP_REP_INFO_SERVER 

inherit

	DELAY_SERVER [REP_CLASS_INFO]

creation

	make
	
feature 

	Cache: REP_INFO_CACHE is
			-- Cache for routine tables
		once
			!!Result.make;
		end;

	Delayed: SEARCH_TABLE [INTEGER] is
			-- Cache for delayed items
		local
			csize: INTEGER
		once
			csize := Cache.cache_size;
			!!Result.make ((3 * csize) // 2);
		end;

	Size_limit: INTEGER is 500000;

end
