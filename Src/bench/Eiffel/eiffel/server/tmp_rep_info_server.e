-- Server for class information on temporary file. This server is
-- used during the compilation and is not stored to disk at the
-- end of a successful compilation. 

class TMP_REP_INFO_SERVER 

inherit

	DELAY_SERVER [REP_CLASS_INFO, CLASS_ID]

creation

	make
	
feature 

	id (t: REP_CLASS_INFO): CLASS_ID is
			-- Id associated with `t'
		do
			Result := t.id
		end

	Cache: REP_INFO_CACHE is
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
