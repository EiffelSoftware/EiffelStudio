-- Server of class dependances for incremental type check 
-- used during the compilation. The goal is to merge the file Tmp_depend_file
-- and Depend_file if the compilation is successful.

class TMP_DEPEND_SERVER 

inherit

	DELAY_SERVER [CLASS_DEPENDANCE, CLASS_ID]

creation

	make
	
feature 

	id (t: CLASS_DEPENDANCE): CLASS_ID is
			-- Id associated with `t'
		do
			Result := t.id
		end

	Cache: DEPEND_CACHE is
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
