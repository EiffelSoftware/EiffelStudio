
deferred class DELAY_SERVER [T -> IDABLE]

inherit

	SERVER [T]
		redefine
			put , flush, item, has, remove,
			change_id
		end

feature

	change_id (new_value, old_value: INTEGER) is
		local
			sf: SERVER_INFO;
			temp: T;
			real_id: INTEGER
		do
			real_id := updated_id (old_value);

			if delayed.has (real_id) then
				delayed.remove (real_id);
				delayed.force (new_value);
			end;

			temp := cache.item_id (real_id);
			if temp /= Void then
				temp.set_id (new_value);
			end;

			sf := tbl_item (real_id);
			if sf /= Void then
				tbl_remove (real_id);
				tbl_put (sf, new_value);
			end;
		end;
 
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
debug ("SERVER")
	io.putstring ("Putting element of id: ");
	io.putint (t.id);
	io.putstring ("/");
	io.putint (updated_id (t.id));
	io.putstring (" into");
	io.putstring (generator);
	io.new_line;
end;

			t.set_id (updated_id(t.id));

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
			delayed.force (id);
		end;

	item (an_id: INTEGER): T is
			-- Object of id `an_id'.
		local
			info: SERVER_INFO;
			server_file: SERVER_FILE;
			id_to_remove: INTEGER;
			to_remove: T;
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
					to_remove := cache.item;
					id_to_remove := to_remove.id;
					if delayed.has (id_to_remove) then
						write (to_remove);
						delayed.remove (id_to_remove);
					end;
					cache.remove;
				end;
				Result.set_id (real_id);
				cache.put (Result);
			end;
		end;

	remove (an_id: INTEGER) is
			-- Remove information of id `an_id'.
			-- NO precondition, the feature will check if the
			-- server has the element to remove.
		local
			old_info: SERVER_INFO;
			old_server_file: SERVER_FILE;
			real_id: INTEGER
		do
			real_id := updated_id (an_id);

			cache.remove_id (real_id);

			delayed.remove (real_id);

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
		local
			real_id: INTEGER
		do
			real_id := updated_id (id);
			Result := cache.has_id (real_id) or else tbl_has (real_id)
		end;

end
