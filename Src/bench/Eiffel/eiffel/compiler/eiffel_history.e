-- Cache of horizontal tables for fianl mode generation

class EIFFEL_HISTORY


inherit

	CACHE [POLY_TABLE [ENTRY]]
		rename
			item_id as cache_item_id,
			wipe_out as cache_wipe_out,
			make as cache_make
		end;
	CACHE [POLY_TABLE [ENTRY]]
		redefine
			item_id, wipe_out, make
		select
			item_id, wipe_out, make
		end;
	SHARED_SERVER
		undefine
			twin
		end;

creation

	make

feature

	used: ARRAY [BOOLEAN];
			-- Used routine table ids

	make is
			-- Initialization
		do
			cache_make;
			!!used.make (1,1);
		end;

	Cache_size: INTEGER is 200;
			-- Cache size

	item_id (rout_id: INTEGER): POLY_TABLE [ENTRY] is
			-- Routine table of id `rout_id'
		do
			Result := cache_item_id (rout_id);
			if Result = Void and then Tmp_poly_server.has (rout_id) then
					-- Not in cache and the routine id is not associated to a routine
					-- table of deferred features only.
				Result := Tmp_poly_server.item (rout_id).poly_table;
				if full then
					remove;
				end;
				put (Result);
			end;
		end;

	init is
			-- Initialization of `used'.
		do
			used.resize (1, System.routine_id_counter.value)
		end;

	is_used (rout_id: INTEGER): BOOLEAN is
			-- Is the table of routine id `rout_id' used ?
		do
			Result := used.item (rout_id)
		end;

	mark_used (rout_id: INTEGER) is
			-- Mark routine table of routine id `rout_id' used.
		do
			used.put (True, rout_id)
		end;

	wipe_out is
			-- Wipe out the structure
		do
			cache_wipe_out;
			!!used.make (1,1);
		end;
end
