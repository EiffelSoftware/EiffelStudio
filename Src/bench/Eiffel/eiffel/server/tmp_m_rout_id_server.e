
class TMP_M_ROUT_ID_SERVER

inherit

	DELAY_SERVER [MELTED_ROUTID_ARRAY]

creation

	make

feature

	Cache: M_ROUT_ID_CACHE is
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

	Size_limit: INTEGER is 100000;

end
