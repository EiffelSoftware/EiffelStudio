-- Temporary server of polymorphic unit tables

class TMP_POLY_SERVER

inherit

	DELAY_SERVER [POLY_UNIT_TABLE [POLY_UNIT]]

creation

	make

feature

	Cache: POLY_CACHE is
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

	Size_limit: INTEGER is 1000000;

end
