-- Server feature table on temporary file. This server is
-- used during the compilation. The goal is to merge the file Tmp_feat_tbl_file
-- and Feat_tbl_file if the compilation is successfull.

class TMP_FEAT_TBL_SERVER 

inherit

	DELAY_SERVER [FEATURE_TABLE]

creation

	make
	
feature 

	Cache: FEAT_TBL_CACHE is
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

	Size_limit: INTEGER is 2000000;

end
