-- Cache of horizontal tables for final mode generation

class EIFFEL_HISTORY


inherit
	CACHE [POLY_TABLE [ENTRY], ROUTINE_ID]
		rename
			item_id as poly_table
		redefine
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
			{CACHE} Precursor;
			!!used.make (1);
		end;

feature 

	poly_table (rout_id: ROUTINE_ID): POLY_TABLE [ENTRY] is
			-- Routine table of id `rout_id'
		do
			Result := {CACHE} Precursor (rout_id);
			if Result = Void and then Tmp_poly_server.has (rout_id) then
					-- Not in cache and the routine id is not associated
					-- to a routine table of deferred features only.
				Result := Tmp_poly_server.item (rout_id);
				if is_full then
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
			{CACHE} Precursor;
			!!used.make (1);
		end;

feature {EIFFEL_HISTORY} -- Implementation

	used: SEARCH_TABLE [ROUTINE_ID];
			-- Used routine table ids

	default_size: INTEGER is 200;
			-- Cache size

invariant

	used_not_void: used /= Void

end
