-- Class for description of a read-only server

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
			make as int_table_make,
			item as int_tbl_item
		export
			{ANY} all
		end

feature

	make is
			-- Initialization
		do
			int_table_make (500)
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
		do
			Result := cache.item_id (an_id);
			if Result = Void then
					-- Id not avaible in memory
				info := int_tbl_item (an_id);
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
				cache.put (Result);
			end;
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
