-- Class for description of a read-only server

deferred class READ_SERVER [T -> IDABLE, H -> COMPILER_ID]

inherit
	EXTEND_TABLE [READ_INFO, H]
		rename
			make as tbl_make,
			item as tbl_item,
			has as tbl_has,
			remove as tbl_remove,
			put as tbl_put
		end

	COMPILER_EXPORTER
		undefine
			copy, is_equal
		end

	SHARED_SERVER
		export
			{ANY} all
		undefine
			copy, is_equal
		end

	SHARED_SCONTROL
		undefine
			copy, is_equal
		end

feature

	updated_id (i: H): H is
		do
			Result := i
		end;
 
	ontable: O_N_TABLE [H] is
			-- Mapping table between old id s and new ids.
			-- Used by `change_id'
			-- By default, this mechanism is disabled, hence the
			-- `False' precondition
		require
			False
		do
		end;

	change_id (new_value, old_value: H) is
		require
			Has_old: has (old_value)
		local
			rf: READ_INFO;
			temp: T;
			real_id: H
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

	has (i: H): BOOLEAN is
		do
			Result := tbl_has (updated_id(i))
		end;

	item (an_id: H): T is
			-- Object of id `an_id'
		require
			an_id_in_table: has (an_id);
		local
			info: READ_INFO;
			server_info: SERVER_INFO;
			server_file: SERVER_FILE;
			offset: INTEGER;
			real_id: H
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
					(server_file.descriptor, offset, info.object_count);
					-- Insert it in the queue
				if cache.is_full then
						-- If cache is full, oldest is removed
					cache.remove;
				end;
				Result.set_id (real_id);
				cache.put (Result);
			end;
		end;

	disk_item (an_id: H): T is
			-- Object of id `an_id'
		require
			an_id_in_table: has (an_id);
		local
			info: READ_INFO;
			server_info: SERVER_INFO;
			server_file: SERVER_FILE;
			offset: INTEGER;
			real_id: H
		do
			real_id := updated_id(an_id);
			info := tbl_item (real_id);
			server_info := offsets.item (info.class_id);
			server_file := Server_controler.file_of_id (server_info.id);
			if not server_file.is_open then
				Server_controler.open_file (server_file);
			end;
			offset := info.offset + server_info.position;
			Result := partial_retrieve
				(server_file.descriptor, offset, info.object_count);
			Result.set_id (real_id);
		end;

	remove (an_id: H) is
			-- Simply remove element from server structures
			-- This is as read server, nothing id removed from disk.
			--|Note: the O_N_TABLE table should also be updated but
			--|we are sick and tired of this problem
		local
			real_id: H
		do
			real_id := updated_id (an_id);
			tbl_remove (real_id);
			cache.remove_id (real_id);
		end;

	offsets: EXTEND_TABLE [SERVER_INFO, CLASS_ID] is
		deferred
		end;

	cache: CACHE [T, H] is
			-- Cache disk
		deferred
		end;

	clear is
			-- Clear the server.
		do
			cache.wipe_out;
			clear_all;
		end;

	trace is do end;

feature {NONE}

	partial_retrieve (file_desc: INTEGER; pos, nb_obj: INTEGER): T is
		external
			"C"
		end;

end
