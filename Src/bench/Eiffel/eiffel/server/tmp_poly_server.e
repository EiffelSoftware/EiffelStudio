-- Temporary server of polymorphic unit tables

class TMP_POLY_SERVER

inherit

	DELAY_SERVER [POLY_UNIT_TABLE [POLY_UNIT]]
		rename
			make as basic_make,
			flush as basic_flush
		end;
	DELAY_SERVER [POLY_UNIT_TABLE [POLY_UNIT]]
		redefine
			flush, make
		select
			flush, make
		end

creation

	make

feature

	useless_rout_ids: ARRAY [INTEGER];
			-- Set of useless routine ids

	nb_useless: INTEGER;
			-- Count of routine ids in `useless_rout_ids'.

	make is
			-- Hash table creation
		do
			basic_make;
			!!useless_rout_ids.make (1, 50);
		end;

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

	desactive (rout_id: INTEGER) is
			-- Put `rout_id' in `useless_rout_ids'.
		local
			nb: INTEGER;
		do
				-- Check if resizing is needed.
			nb_useless := nb_useless + 1;
			nb := useless_rout_ids.count;
			if nb_useless > nb then
				useless_rout_ids.resize (1, nb + 50);
			end;

			useless_rout_ids.put (rout_id, nb_useless);
		end;

	flush is
			-- Finalization after a successfull recompilation.
		local
			i: INTEGER
		do
			basic_flush;
			from
				i := 1;
			until
				i > nb_useless
			loop
				Tmp_poly_server.remove (useless_rout_ids.item (i));
				i := i + 1;
			end;
			nb_useless := 0;
		end;

	Size_limit: INTEGER is 1000000;

end
