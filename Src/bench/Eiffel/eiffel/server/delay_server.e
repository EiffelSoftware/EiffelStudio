
deferred class DELAY_SERVER [T -> IDABLE]

inherit

	SERVER [T]
		rename
			has as basic_has
		redefine
			put , flush, item
		end;
	SERVER [T]
		redefine
			put, flush, has, item
		select
			has
		end;

feature

	delayed: SEARCH_TABLE [INTEGER] is
			-- Table of delayed ids
		deferred
		end;

	put (t: T) is
			-- Append object `t' in file `file'.
		local
			old_item, to_remove: T;
			id, id_to_remove: INTEGER;
		do
			id := t.id;
				-- Put `t' in cache if not full
			old_item := cache.item_id (id);
			if old_item = Void then
					-- No previous item of id `t.id'
				if cache.full then
					to_remove := cache.item;
					id_to_remove := to_remove.id;
					if delayed.has (id_to_remove) then
						write (to_remove);
						delayed.remove (id_to_remove);
					end;
					cache.remove;
				end;
				cache.put (t);
			else
					-- There is a previous item and routine `item_id' 
					-- reorganized the cache
				cache.change_last_item (t);
			end;
			delayed.put (id);
		end;

	item (an_id: INTEGER): T is
			-- Object of id `an_id'.
		local
			info: SERVER_INFO;
			server_file: SERVER_FILE;
			id_to_remove: INTEGER;
			to_remove: T;
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
					to_remove := cache.item;
					id_to_remove := to_remove.id;
					if delayed.has (id_to_remove) then
						write (to_remove);
						delayed.remove (id_to_remove);
					end;
					cache.remove;
				end;
				cache.put (Result);
			end;
		end;

	flush is
			-- Flush server
		local
			nb_iter, nb, id_to_remove: INTEGER;
			to_remove: T;
		do
			from
				nb := cache.count;
				nb_iter := 1;
			until
				nb_iter > nb
			loop
				to_remove := cache.item;
				id_to_remove := to_remove.id;
				cache.remove;
				if delayed.has (id_to_remove) then
					write (to_remove);
					delayed.remove (id_to_remove);
				end;
				cache.put (to_remove);
				nb_iter := nb_iter + 1;
			end;
		end;

	has (id: INTEGER): BOOLEAN is
			-- Has the server an item of id `id' ?
		do
			Result := cache.has_id (id) or else basic_has (id)
		end;

end
