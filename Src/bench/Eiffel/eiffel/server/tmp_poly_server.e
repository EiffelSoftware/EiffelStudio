-- Temporary server of polymorphic unit tables

class TMP_POLY_SERVER

inherit
	DELAY_SERVER [POLY_UNIT_TABLE [POLY_UNIT], ROUTINE_ID]
		redefine
			clear
		end

creation
	make

feature

	id (t: POLY_UNIT_TABLE [POLY_UNIT]): ROUTINE_ID is
			-- Id associated with `t'
		do
			Result := t.rout_id
		end

	Cache: POLY_CACHE is
			-- Cache for routine tables
		once
			!!Result.make;
		end;

	Delayed: SEARCH_TABLE [ROUTINE_ID] is
			-- Cache for delayed items
		once
			!!Result.make ((3 * Cache.cache_size) // 2)
		end

	clear is
			-- Clear deletes the files in tmp_poly_server
		local
			server_file: SERVER_FILE
		do
				-- Nothing is stored after a finalization
				-- so we do NOT have to update all the objects
				-- (server_control, caches, ...)
				-- Wrong assumption above!!!!
				-- We can finalize several times in the same session!!!
			from
				file_ids.start
			until
				file_ids.after
			loop
				server_file := Server_controler.file_of_id (file_ids.item);
				Server_controler.remove_file (server_file)
				file_ids.forth
			end;
			clear_all;
			file_ids.wipe_out;
			cache.wipe_out;
			set_current_id;
		end;

feature -- Server parameters

	Size_limit: INTEGER is 300
			-- Size of the TMP_POLY_SERVER file (300 Ko)

	Chunk: INTEGER is 3000
			-- Size of a HASH_TABLE block

end
