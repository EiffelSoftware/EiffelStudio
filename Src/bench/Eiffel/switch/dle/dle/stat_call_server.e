-- Servers for statically bound feature calls in the DR-system.
-- The servers are indexed on type_id and contains linked set
-- of rout_id.

class STAT_CALL_SERVER inherit

	DELAY_SERVER [DLE_STATIC_CALLS]
		redefine
			clear
		end

creation

	make
	
feature -- Element change

	mark_static (rout_id: ROUTINE_ID; type_id: INTEGER) is
			-- Mark the feature call identified by `rout_id' and applied
			-- on an object of type `type_id' as statically bound.
		require
			rout_id_not_void: rout_id /= Void
		local
			static_calls: DLE_STATIC_CALLS
		do
			if has (type_id) then
				static_calls := item (type_id)
			else
				!! static_calls.make (type_id)
			end;
			static_calls.extend (rout_id);
			put (static_calls)
		end;

feature -- Status report

	is_polymorphic (rout_id: ROUTINE_ID; type_id: INTEGER): BOOLEAN is
			-- Is the feature call identified by `rout_id' and applied
			-- on an object of type `type_id' dynamically bound?
		require
			rout_id_not_void: rout_id /= Void
		do
			Result := not has (type_id) or else not item (type_id).has (rout_id)
		end;

feature -- Server

	Cache: STAT_CALL_CACHE is
			-- Cache for statically bound feature calls
		once
			!!Result.make
		end;

	Delayed: SEARCH_TABLE [INTEGER] is
			-- Cache for delayed items
		local
			csize: INTEGER
		once
			csize := Cache.cache_size;
			!!Result.make ((3 * csize) // 2)
		end;

	Size_limit: INTEGER is 40;

	clear is
			-- Clear deletes the files in the server.
		local
			server_file: SERVER_FILE
		do
			from
				file_ids.start
			until
				file_ids.after
			loop
				server_file := Server_controler.file_of_id (file_ids.item);
				Server_controler.remove_file (server_file);
				file_ids.forth
			end;
			clear_all;
			file_ids.wipe_out;
			cache.wipe_out;
			set_current_id
		end;

end -- class STAT_CALL_SERVER
