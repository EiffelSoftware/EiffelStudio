-- Cache of horizontal tables for final mode generation
-- of the extendible system when compiling a Dynamic Class Set

class 

	DLE_EIFFEL_HISTORY


inherit

	EIFFEL_HISTORY
		rename
			is_used as was_used,
			make as eh_make
		export
			{NONE} eh_make
		redefine
			wipe_out, was_used
		end
	
creation

	make

feature

	was_used (rout_id: INTEGER): BOOLEAN is
			-- Was the table of routine id `rout_id' used in the
			-- static system?
		do
			Result := used.valid_index (rout_id) and then used.item (rout_id)
		end;

	make (static: EIFFEL_HISTORY) is
			-- Initialization for the static system 
		require
			static_exists: static /= Void
		do
			cache_make;
			used := clone (static.used)
		end;

	wipe_out is
			-- Wipe out the cache.
		do
			cache_wipe_out
		end;

invariant

	dynamic_system: System.is_dynamic

end -- class DLE_EIFFEL_HISTORY
