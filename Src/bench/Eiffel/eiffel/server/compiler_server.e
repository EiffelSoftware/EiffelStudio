-- Offset table associated to a cache

deferred class SERVER [T -> IDABLE]

inherit

	SHARED_SCONTROL
		export
			{NONE} all
		undefine
			twin
		end;
	SHARED_SERVER
		export
			{NONE} all
		undefine
			twin
		end;
	EXTEND_TABLE [SERVER_INFO, INTEGER]
		rename
			make as tbl_make,
			position as tbl_position,
			item as tbl_item,
			put as tbl_put,
			remove as tbl_remove,
			change_key as tbl_change_key,
			has as tbl_has
		end;
	SHARED_DIALOG
		export
			{NONE} all
		undefine
			twin
		end;

feature

	updated_id (i: INTEGER): INTEGER is
		do
			Result := i	
		end;

	ontable: O_N_TABLE is
			-- Mapping table between old id s and new ids.
			-- Used by `change_id'
			-- By default, this mechanism is disables, hence the
			-- `False' precondition
		require
			False
		do
		end;

	change_id (new_value, old_value: INTEGER) is
		require
			Has_old: has (old_value)
		local
			sf: SERVER_INFO;
			temp: T;
			real_id: INTEGER
		do
			real_id := updated_id (old_value);

			temp := cache.item_id (real_id);
			if temp /= Void then
				temp.set_id (new_value);
			end;

			sf := tbl_item (real_id);
			tbl_remove (real_id);
			tbl_put (sf, new_value);
		end;

	current_id: INTEGER;
			-- Current server file id used by primitive `put'.

	file_ids: LINKED_SET [INTEGER];
			-- Set of server file ids under the control of the
			-- current server

	make is
			-- Initialization
		do
			!!file_ids.make;
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

	put_precompiled (fid: INTEGER; item_id: INTEGER; sinf: SERVER_INFO) is
		local
			server_file: SERVER_FILE;
			info: SERVER_INFO
		do
			file_ids.add (fid);
			force (sinf, updated_id(item_id));
		end;

	Size_limit: INTEGER is
			-- Limit of the size of one file under the control	
			-- of the current server
		deferred
		end;

	put (t: T) is
			-- Put object `t' in server.
		local
			old_item: T;
		do
debug ("SERVER")
	io.putstring ("Putting element of id: ");
	io.putint (t.id);
	io.putstring ("/");
	io.putint (updated_id (t.id));
	io.putstring (" into");
	io.putstring (generator);
	io.new_line;
end;
				-- Update id of element
			t.set_id (updated_id (t.id));

				-- Write item to disk right away.
			write (t);
		
				-- Put `t' in cache if not full.
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
		--rescue
		--	Dialog_window.display ("Cannot write compilation information to disk");
		--	retry;
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
			-- NO precondition, the feature will check if the
			-- server has the element to remove.
			--|Note: the element will actually be removed from
			--|disk at the end of a succesful compilation
		local
			old_info: SERVER_INFO;
			old_server_file: SERVER_FILE;
			real_id: INTEGER
		do
			real_id := updated_id (an_id);
			cache.remove_id (real_id);
			old_info := tbl_item (real_id);
			if old_info /= Void then
				old_server_file := Server_controler.file_of_id (old_info.id);
				old_server_file.remove_occurence;
				if old_server_file.occurence = 0 then
					file_ids.remove_item (old_server_file.id);
				end;
				tbl_remove (real_id);
			end;
		end;

	has (i: INTEGER): BOOLEAN is
			-- Does the server contain an element of
			-- id `i'?
		do
			Result := tbl_has (updated_id(i))
		end;

	item (an_id: INTEGER): T is
			-- Object of id `an_id'.
		require
			an_id_in_table: has (an_id);
		local
			info: SERVER_INFO;
			server_file: SERVER_FILE;
			real_id: INTEGER
		do
			real_id := updated_id (an_id);
			Result := cache.item_id (real_id);
			if Result = Void then
					-- Id not avaible in memory
				info := tbl_item (real_id);
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
				Result.set_id (real_id);
				cache.put (Result);
			end;
		--rescue
		--	Dialog_window.display ("Cannot read compilation information from disk");
		--	retry;
		end;

	disk_item (an_id: INTEGER): T is
			-- Object of id `an_id' on disk.
		require
			an_id_in_table: has (an_id);
		local
			info: SERVER_INFO;
			server_file: SERVER_FILE;
			real_id: INTEGER
		do
			real_id := updated_id (an_id);
			info := tbl_item (real_id);
			server_file := Server_controler.file_of_id (info.id);
			if not server_file.is_open then
				Server_controler.open_file (server_file);
			end;
				-- Id not avaible in memory
			Result := retrieve_all
						(server_file.file_pointer, info.position);
			Result.set_id (real_id);
		end;

	cache: CACHE [T] is
			-- Cache disk
		deferred
		end;

	clear is
			-- Clear the server.
			-- Clears the server entirely.
			-- Must not be used in conjunction with 
			-- `take_control' since that routine relies
			-- on shallow copy semantics!
		local
			info: SERVER_INFO;
			server_file: SERVER_FILE;
		do
				-- Flush the cache
				--|Does not do anything for default servers.
			flush;

				-- Empty the files
			from
				start
			until
				after
			loop
				info := item_for_iteration;
				server_file := Server_controler.file_of_id (info.id);
				server_file.remove_occurence;
				forth;
			end;
			clear_all;
			file_ids.wipe_out;
			cache.wipe_out;
				-- Take a new file
			set_current_id;
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
			flush;
			other.flush;
			from
				other.start
			until
				other.after
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
debug ("SERVER")
	io.putstring ("===== Purging: ");
	io.putstring (generator);
	io.putstring (" =====%N");
end;
			from
					-- Iterate on items sorted by file ids so the purge
					-- will be smooth regarding the disk space
				order := file_ids;
				order.start
			until
				order.after
			loop
				file_id := order.item;
debug ("SERVER")
	io.putstring ("File: E");
	io.putint (file_id);
	io.new_line;
end;
				from
					start
				until
					after
				loop
					old_info := item_for_iteration;
					old_server_file :=
						Server_controler.file_of_id (old_info.id);
					an_id := key_for_iteration;
					if old_info.id = file_id then
						if old_server_file.precompiled then
							new.put_precompiled (file_id, an_id, old_info);
						else
debug ("SERVER")
	io.putstring ("%TTransferring one element");
end;
								-- Put in purged server alive item	
							new.write (item (an_id));
	
								-- Remove occurence from file where item was stored
							old_server_file.remove_occurence;
debug ("SERVER")
	io.putstring (". Occurrences are now: ");
	io.putint (old_server_file.occurence);
	io.new_line;
end;
						end;
					end;
					forth
				end;
				old_server_file := Server_controler.file_of_id (file_id);
				if old_server_file /= Void then
debug ("SERVER")
	io.putstring ("--> Removing the file%N");
end;
				if not old_server_file.precompiled then
					Server_controler.remove_file (old_server_file);
				end;
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
