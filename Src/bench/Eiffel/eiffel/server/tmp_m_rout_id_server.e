
class TMP_M_ROUT_ID_SERVER

inherit

	DELAY_SERVER [MELTED_ROUTID_ARRAY, CLASS_ID]

creation

	make

feature

	id (t: MELTED_ROUTID_ARRAY): CLASS_ID is
			-- Id associated with `t'
		do
			Result := t.class_id
		end

	Cache: M_ROUT_ID_CACHE is
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

	Size_limit: INTEGER is 2;

end
