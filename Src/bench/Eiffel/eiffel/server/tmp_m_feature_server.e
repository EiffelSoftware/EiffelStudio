-- Temporary server for melted feature byte code associated to file ".TMP_MLT2"

class TMP_M_FEATURE_SERVER 

inherit

	DELAY_SERVER [MELT_FEATURE]

creation

	make

feature 

	Cache: M_FEATURE_CACHE is
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

	Size_limit: INTEGER is 2;

end
