indexing
	description: "Temporary server of optimized byte code indexed by body id."
	date: "$Date$"
	revision: "$Revision$"

class TMP_OPT_BYTE_SERVER

inherit
	DELAY_SERVER [BYTE_CODE]
		redefine
			clear
		end

create
	make

feature

	id (t: BYTE_CODE): INTEGER is
			-- Id associated with `t'
		do
			Result := t.body_index
		end

	cache: BYTE_CACHE is
			-- Cache for routine tables
		once
			create Result.make
		end

	Delayed: SEARCH_TABLE [INTEGER] is
			-- Cache for delayed items
		once
			create Result.make ((3 * Cache.cache_size) // 2)
		end

	clear is
			-- Clear deletes the files in tmp_opt_byte_server
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
				Server_controler.forget_file (server_file);
				file_ids.forth
			end;
			clear_all;
			file_ids.wipe_out;
			cache.wipe_out;
		end;

feature -- Server parameters

	Size_limit: INTEGER is 100
			-- Size of the TMP_OPT_BYTE_SERVER file (100 Ko)

	Chunk: INTEGER is 300
			-- Size of a HASH_TABLE block

end
