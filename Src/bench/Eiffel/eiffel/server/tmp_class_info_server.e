-- Server for class information on temporary file. This server is
-- used during the compilation. The goal is to merge the file
-- Tmp_class_info_file and Class_info_file if the compilation is successful.

class TMP_CLASS_INFO_SERVER 

inherit

	DELAY_SERVER [CLASS_INFO, CLASS_ID]

creation

	make
	
feature 

	id (t: CLASS_INFO): CLASS_ID is
			-- Id associated with `t'
		do
			Result := t.id
		end

	Cache: CLASS_INFO_CACHE is
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

	Size_limit: INTEGER is 10;

end
