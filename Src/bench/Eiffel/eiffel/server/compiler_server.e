-- Offset table associated to a cache

deferred class SERVER [T -> IDABLE]

inherit

	SHARED_SCONTROL
		undefine
			twin
		end;
	SHARED_SERVER
		undefine
			twin
		end;
	EXTEND_TABLE [SERVER_INFO, INTEGER]
		rename
			make as tbl_make,
			position as tbl_position,
			item as tbl_item,
			put as tbl_put,
			remove as tbl_remove
		export
			{ANY} all
		end;

feature

	current_id: INTEGER;
			-- Current server file id used by primitive `put'.

	file_ids: LINKED_SET [INTEGER];
			-- Set of server file ids under the control of the
			-- current server

	removed_ids: LINKED_SET [INTEGER];
			-- Set of item ids removed from the server

	make is
			-- Initialization
		do
			!!file_ids.make;
			!!removed_ids.make;
			set_current_id;
			tbl_make (Chunk);
		end;

	Chunk: INTEGER is 500;
			-- Hash table chunk

	set_current_id is
			-- Set `current_id' to a new value.
		do
			Server_controler.compute_new_id;
			current_id := Server_controler.last_computed_id;
			file_ids.add (current_id);
		end;

	Size_limit: INTEGER is
			-- Limit of the size of one file under the control	
			-- of the current server
		deferred
		end;

	put (t: T) is
			-- Append object `t' in file `file'.
		local
			old_item: T;
		do
			write (t);
				-- Put `t' in cache if not full
			old_item := cache.item_id (t.id);
			if old_item = Void then
					-- No previous item of id `t.id'
				if cache.full then
					cache.remove;
				end;
				cache.put (t);
			else
					-- There is a previous item and routine `item_id' 
					-- reorganized the cache
				cache.change_last_item (t);
			end;
		end;

	write (t: T) is
			-- Write item `t' on disk
		local
			id, position: INTEGER;
			server_file, old_server_file: SERVER_FILE;
			info, old_info: SERVER_INFO;
		do
			server_file := Server_controler.file_of_id (current_id);
			if (server_file.count > Size_limit) or else
				server_file.precompiled
			then 
				set_current_id;
				server_file := Server_controler.file_of_id (current_id);
			end;
			if not server_file.is_open then
				Server_controler.open_file (server_file);
			end;

			id := t.id;
			init_file (server_file);
			position := store_append
				(server_file.file_pointer, $t, $make_index, $Current);
			!!info.make (position, server_file.id);
			server_file.add_occurence;

			old_info := tbl_item (id);
			if old_info /= Void then
				old_server_file := Server_controler.file_of_id (old_info.id);
				old_server_file.remove_occurence;
				if old_server_file.occurence = 0 then
					file_ids.remove_item (old_server_file.id);
				end;
			end;
			force (info, id);
		end;

	init_file (server_file: SERVER_FILE) is
			-- Init server fileerver_file' before writing in it.
		require
			good_argument: server_file /= Void
		do
			c_sv_init (server_file.file_pointer);
		end;

	remove (an_id: INTEGER) is
			-- Remove information of id `an_id'.
			-- Actually, just put it in a list
		do
			removed_ids.add (an_id);
		end;

	remove_from_disk is
			-- Perform the real remove on disk
		local
			an_id: INTEGER;
			old_info: SERVER_INFO;
			old_server_file: SERVER_FILE;
		do
			from
				removed_ids.start
			until
				removed_ids.after
			loop
				an_id := removed_ids.item;
				old_info := tbl_item (an_id);
				if old_info /= Void then
					old_server_file := Server_controler.file_of_id (old_info.id);
					old_server_file.remove_occurence;
					if old_server_file.occurence = 0 then
						file_ids.remove_item (old_server_file.id);
					end;
					tbl_remove (an_id);
				end;
				removed_ids.forth
			end;
			removed_ids.wipe_out;
		end;

	item (an_id: INTEGER): T is
			-- Object of id `an_id'.
		require
			an_id_in_table: has (an_id);
		local
			info: SERVER_INFO;
			server_file: SERVER_FILE;
		do
			Result := cache.item_id (an_id);
			if Result = Void then
					-- Id not avaible in memory
				info := tbl_item (an_id);
				server_file := Server_controler.file_of_id (info.id);
				if not server_file.is_open then
					Server_controler.open_file (server_file);
				end;
				Result := retrieve_all
							(server_file.file_pointer, info.position);
					-- Insert it in the queue
				if cache.full then
						-- If cache is full, oldest is removed
					cache.remove;
				end;
				cache.put (Result);
			end;
		end;

	disk_item (an_id: INTEGER): T is
			-- Object of id `an_id' on disk.
		require
			an_id_in_table: has (an_id);
		local
			info: SERVER_INFO;
			server_file: SERVER_FILE;
		do
			info := tbl_item (an_id);
			server_file := Server_controler.file_of_id (info.id);
			if not server_file.is_open then
				Server_controler.open_file (server_file);
			end;
				-- Id not avaible in memory
			Result := retrieve_all
						(server_file.file_pointer, info.position);
		end;

	cache: CACHE [T] is
			-- Cache disk
		deferred
		end;

	clear is
			-- Clear the server.
		local
			info: SERVER_INFO;
			server_file: SERVER_FILE;
		do
				-- Flush the cache
			flush;

				-- Empty the files
			from
				start
			until
				offright
			loop
				info := item_for_iteration;
				server_file := Server_controler.file_of_id (info.id);
				server_file.remove_occurence;
				forth;
			end;
			clear_all;
			file_ids.wipe_out;

				-- Take a new file
			set_current_id;
		end;

	clear_cache is
			-- Clear the cache
		do
			cache.wipe_out;
		end;

	take_control (other: SERVER [T]) is
			-- Take control of `other'.
		require
			good_argument: other /= Void
		local
			info, old_info: SERVER_INFO;
			id: INTEGER;
			other_file_ids: LINKED_SET [INTEGER];
			other_cache: CACHE [T];
			old_server_file: SERVER_FILE;
		do
			other.flush;
			removed_ids.merge (other.removed_ids);
			remove_from_disk;
			other.remove_from_disk;
			from
				other.start
			until
				other.offright
			loop
				info := other.item_for_iteration;
				id := other.key_for_iteration;
				old_info := tbl_item (id);
				if old_info /= Void then
					old_server_file := Server_controler.file_of_id
																(old_info.id);
					old_server_file.remove_occurence;
					if old_server_file.occurence = 0 then
						file_ids.remove_item (old_server_file.id);
					end;
				end;
				force (info, id);
				other.forth;
			end;
			other.clear_all;

			other_file_ids := other.file_ids;
			file_ids.merge (other_file_ids);
			other_file_ids.wipe_out;

			other_cache := other.cache;
			cache.copy (other_cache);
			other_cache.make;

			current_id := other.current_id;
			other.set_current_id;
		end;			

	purge is
			-- Purge useless datas from current server
		local
			new: like Current;
			old_count, an_id, file_id: INTEGER;
			old_info: SERVER_INFO;
			old_server_file: SERVER_FILE;
			order: LINKED_LIST [INTEGER];
		do
				-- Clean first
			flush;
			cache.wipe_out;
			old_count := count;
			count := 0;

				-- Create a new server which will be copied in Current
			new := standard_twin;
			new.make;
			from
					-- Iterate on items sorted by file ids so the purge
					-- will be smooth regarding the disk space
				order := file_ids;
				order.start
			until
				order.offright
			loop
				file_id := order.item;
				from
					start
				until
					offright
				loop
					old_info := item_for_iteration;
					if old_info.id = file_id then
						an_id := key_for_iteration;
							-- Put in purged server alive item	
						new.write (item (an_id));
	
							-- Remove occurence from file where item was stored
						old_server_file :=
							Server_controler.file_of_id (old_info.id);
						old_server_file.remove_occurence;
					end;
					forth
				end;
				order.forth;
			end;
			check
				same_count: new.count = old_count
			end;
			copy (new);
		end;
		
	flush is
			-- Flush server
		do
			-- Do nothing
		end;

	 make_index (obj: ANY; file_position, object_count: INTEGER) is
			-- Index building
		do
		end;

feature {NONE} -- External features

	store_append (f: POINTER; o: T; r: POINTER; s: like Current): INTEGER is
		external
			"C"
		end;

	retrieve_all (s: POINTER; pos: INTEGER): T is
		external
			"C"
		end;

	c_sv_init (ptr: POINTER) is
		external
			"C"
		end;

end
