-- Server feature table on temporary file. This server is
-- used during the compilation. The goal is to merge the file Tmp_feat_tbl_file
-- and Feat_tbl_file if the compilation is successful.

class TMP_FEAT_TBL_SERVER 

inherit

	DELAY_SERVER [FEATURE_TABLE, CLASS_ID]

creation

	make
	
feature 

	id (t: FEATURE_TABLE): CLASS_ID is
			-- Id associated with `t'
		do
			Result := t.feat_tbl_id
		end

	Cache: FEAT_TBL_CACHE is
			-- Cache for routine tables
		once
			!!Result.make;
		end;

	Delayed: SEARCH_TABLE [CLASS_ID] is
			-- Cache for delayed items
		local
			csize: INTEGER
		once
			csize := Cache.cache_size;
			!!Result.make ((3 * csize) // 2);
		end;

	Size_limit: INTEGER is 40;

end
