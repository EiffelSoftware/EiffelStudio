-- Server for class information on temporary file. This server is
-- used during the compilation. The goal is to merge the file
-- Tmp_class_info_file and Class_info_file if the compilation is successfull.

class TMP_CLASS_INFO_SERVER 

inherit

	DELAY_SERVER [CLASS_INFO]

creation

	make
	
feature 

	Cache: CLASS_INFO_CACHE is
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
