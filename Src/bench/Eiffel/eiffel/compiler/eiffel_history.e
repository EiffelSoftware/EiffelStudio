-- Cache of horizontal tables for final mode generation

class EIFFEL_HISTORY


inherit

	CACHE [POLY_TABLE [ENTRY], ROUTINE_ID]
		rename
			item_id as cache_item_id,
			wipe_out as cache_wipe_out,
			make as cache_make
		end;
	CACHE [POLY_TABLE [ENTRY], ROUTINE_ID]
		rename
			item_id as poly_table
		redefine
			poly_table, wipe_out, make
		select
			poly_table, wipe_out, make
		end;
	SHARED_SERVER
		undefine
			copy, setup, consistent, is_equal
		end;
	COMPILER_EXPORTER
		undefine
			copy, setup, consistent, is_equal
		end

creation

	make

feature {NONE} -- Initialization

	make is
			-- Initialization
		do
			cache_make;
			!!used.make (1);
		end;

feature 

	poly_table (rout_id: ROUTINE_ID): POLY_TABLE [ENTRY] is
			-- Routine table of id `rout_id'
		do
			Result := cache_item_id (rout_id);
			if Result = Void and then Tmp_poly_server.has (rout_id) then
					-- Not in cache and the routine id is not associated
					-- to a routine table of deferred features only.
				Result := Tmp_poly_server.item (rout_id).poly_table;
				if full then
					remove;
				end;
				put (Result);
			end;
		end;

	is_used (rout_id: ROUTINE_ID): BOOLEAN is
			-- Is the table of routine id `rout_id' used ?
		require
			rout_id_not_void: rout_id /= Void
		do
			Result := used.has (rout_id)
		end;

	mark_used (rout_id: ROUTINE_ID) is
			-- Mark routine table of routine id `rout_id' used.
		require
			rout_id_not_void: rout_id /= Void
		do
			used.force (rout_id)
		end;

	wipe_out is
			-- Wipe out the structure
		do
			cache_wipe_out;
			!!used.make (1);
		end;

feature -- DLE

	init_dle (other: EIFFEL_HISTORY) is
			-- Initialization of `used' with information of `other'.
		require
			dynamic_system: System.is_dynamic;
			other_exists: other /= Void
		do
			used := clone (other.used)
		end;

feature {EIFFEL_HISTORY} -- Implementation

	used: SEARCH_TABLE [ROUTINE_ID];
			-- Used routine table ids

	default_size: INTEGER is 200;
			-- Cache size

invariant

	used_not_void: used /= Void

end
