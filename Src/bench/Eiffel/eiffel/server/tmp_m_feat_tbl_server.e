-- Temporary server for melted feature tables associated to file ".TMP_MLT1"

class TMP_M_FEAT_TBL_SERVER 

inherit

	DELAY_SERVER [MELTED_FEATURE_TABLE]

creation

	make
	
feature 

	Cache: M_FEAT_TBL_CACHE is
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

	Size_limit: INTEGER is 50000;

end
