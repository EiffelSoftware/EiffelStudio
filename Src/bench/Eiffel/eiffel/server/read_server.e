-- Class for description of a read-only server
-- Note: read servers are only used in the systems
-- for elements indexed by body ids, we can therefore
-- introduce the old/new body id table here (not very
-- nice for a class that should be more abstract)

deferred class READ_SERVER [T -> IDABLE]

inherit

	SHARED_SERVER
		undefine
			twin
		end;
	SHARED_SCONTROL
		undefine
			twin
		end;
	EXTEND_TABLE [READ_INFO, INTEGER]
		rename
			make as tbl_make,
			item as tbl_item,
			change_key as tbl_change_key,
			has as tbl_has,
			remove as tbl_remove,
			put as tbl_put
		end

feature

	updated_id (i: INTEGER): INTEGER is
		do
			Result := i
		end;
 
	ontable: O_N_TABLE is
			-- Mapping table between old id s and new ids.
			-- Used by `change_id'
			-- By default, this mechanism is disabled, hence the
			-- `False' precondition
		require
			False
		do
		end;

	change_id (new_value, old_value: INTEGER) is
		require
			Has_old: has (old_value)
		local
			rf: READ_INFO;
			temp: T;
			real_id: INTEGER
		do
            real_id := updated_id (old_value);
 
            temp := cache.item_id (real_id);
            if temp /= Void then
                temp.set_id (new_value);
            end;
 
            rf := tbl_item (real_id);
            tbl_remove (real_id);
            tbl_put (rf, new_value);
		end;

	make is
			-- Initialization
		do
			tbl_make (500)
		end;

	has (i: INTEGER): BOOLEAN is
		do
			Result := tbl_has (updated_id(i))
		end;

	item (an_id: INTEGER): T is
			-- Object of id `an_id'
		require
			an_id_in_table: has (an_id);
		local
			info: READ_INFO;
			server_info: SERVER_INFO;
			server_file: SERVER_FILE;
			offset: INTEGER;
			real_id: INTEGER
		do
			real_id := updated_id(an_id);
			Result := cache.item_id (real_id);
			if Result = Void then
					-- Id not avaible in memory
				info := tbl_item (real_id);
				server_info := offsets.item (info.class_id);
				server_file := Server_controler.file_of_id (server_info.id);
				if not server_file.is_open then
					Server_controler.open_file (server_file);
				end;
				offset := info.offset + server_info.position;
				Result := partial_retrieve
					(server_file.file_pointer, offset, info.object_count);
					-- Insert it in the queue
				if cache.full then
						-- If cache is full, oldest is removed
					cache.remove;
				end;
				Result.set_id (real_id);
				cache.put (Result);
			end;
		end;

	remove (an_id: INTEGER) is
			-- Simply remove element from server structures
			-- This is as read server, nothing id removed from disk.
			--|Note: the O_N_TABLE table should also be updated but
			--|we are sick and tired of this problem
		local
			real_id: INTEGER
		do
			real_id := updated_id (an_id);
			tbl_remove (real_id);
			cache.remove_id (real_id);
		end;

	offsets: EXTEND_TABLE [SERVER_INFO, INTEGER] is
		deferred
		end;

	cache: CACHE [T] is
			-- Cache disk
		deferred
		end;

	clear is
			-- Clear the server.
		do
			cache.wipe_out;
			clear_all;
		end;

feature {NONE}

	partial_retrieve (fil: POINTER; pos, nb_obj: INTEGER): T is
		external
			"C"
		end;

end
