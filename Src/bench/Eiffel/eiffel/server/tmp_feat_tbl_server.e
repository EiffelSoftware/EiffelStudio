indexing
	description: "Server feature table on temporary file. This server is used%
				%during the compilation. The goal is to merge the file Tmp_feat_tbl_file%
				%and Feat_tbl_file if the compilation is successful.%
				%Indexed by class id."
	date: "$Date$"
	revision: "$Revision$"

class TMP_FEAT_TBL_SERVER 

inherit
	DELAY_SERVER [FEATURE_TABLE]

creation
	make

feature 

	id (t: FEATURE_TABLE): INTEGER is
			-- Id associated with `t'
		do
			Result := t.feat_tbl_id
		end

	cache: FEAT_TBL_CACHE is
			-- Cache for routine tables
		once
			!! Result.make
		end			


	Delayed: SEARCH_TABLE [INTEGER] is
			-- Cache for delayed items
		once
			!!Result.make ((3 * Cache.cache_size) // 2)
		end

	Size_limit: INTEGER is 400
			-- Size of the TMP_FEAT_TBL_SERVER file (400 Ko)

	Chunk: INTEGER is 500
			-- Size of a HASH_TABLE block

end
