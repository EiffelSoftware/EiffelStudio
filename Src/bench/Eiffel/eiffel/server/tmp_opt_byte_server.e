-- Temporary server of optimized byte code

class TMP_OPT_BYTE_SERVER

inherit

	DELAY_SERVER [BYTE_CODE]
		redefine
			clear
		end

creation

	make

feature

	Cache: BYTE_CACHE is
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
				server_file.delete;
				file_ids.forth
			end;
			clear_all;
			file_ids.wipe_out;
			cache.wipe_out;
			set_current_id;
		end;

end
