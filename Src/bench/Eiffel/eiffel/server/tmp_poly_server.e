-- Temporary server of polymorphic unit tables

class TMP_POLY_SERVER

inherit

	DELAY_SERVER [POLY_UNIT_TABLE [POLY_UNIT]]
		redefine
			clear
		end

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

	clear is
			-- Clear deletes the files in tmp_poly_server
		do
				-- Nothing is stored after a finalization
				-- so we do NOT have to update all the objects
				-- (server_control, caches, ...)
			from
				file_ids.start
			until
				file_ids.after
			loop
				Server_controler.file_of_id (file_ids.item).delete;
				file_ids.forth
			end;
		end;

end
