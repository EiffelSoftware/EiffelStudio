-- Server of class dependances for incremental type check 
-- used during the compilation. The goal is to merge the file Tmp_depend_file
-- and Depend_file if the compilation is successful.

class TMP_REP_DEPEND_SERVER 

inherit

	DELAY_SERVER [REP_CLASS_DEPEND, CLASS_ID]

creation

	make
	
feature 

	id (t: REP_CLASS_DEPEND): CLASS_ID is
			-- Id associated with `t'
		do
			Result := t.id
		end

	Cache: REP_DEPEND_CACHE is
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

	update (table: EXTEND_TABLE [REP_CLASS_DEPEND, CLASS_ID]) is
			-- Update server using `table'
		do
			from 
				table.start
			until
				table.after
			loop
				put (table.item_for_iteration);
				table.forth
			end
		end;

	Size_limit: INTEGER is 10;

end
