deferred class DELAY_SERVER [T -> IDABLE, H -> COMPILER_ID]

inherit
	COMPILER_SERVER [T, H]
		redefine
			put, flush, item, has, remove,
			change_id
		end

feature
	
	change_id (new_value, old_value: H) is
		local
			sf: SERVER_INFO;
			temp: T;
			real_id: H
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
 
	delayed: SEARCH_TABLE [H] is
			-- Table of delayed ids
		deferred
		end;

	put (t: T) is
			-- Append object `t' in file `file'.
		local
			old_item, to_remove: T;
			an_id, id_to_remove: H;
		do
debug ("SERVER")
	io.putstring ("Putting element of id: ");
	io.putstring (t.id.dump);
	io.putstring ("(");
	io.putstring (updated_id (id (t)).dump);
	io.putstring (") into");
	io.putstring (generator);
	io.new_line;
end;
			an_id := updated_id (id (t))
			t.set_id (an_id);

				-- Put `t' in cache if not full
			old_item := cache.item_id (an_id);
			if old_item = Void then
					-- No previous item of id `t.id'
				cache.force (t)
				to_remove := cache.last_removed_item
				if to_remove /= Void then 
					id_to_remove := id (to_remove)
					if delayed.has (id_to_remove) then
						write (to_remove)
						delayed.remove (id_to_remove)
					end
				end
			else
					-- There is a previous item and routine `item_id' 
					-- reorganized the cache
				cache.change_last_item (t);
			end;
			delayed.force (an_id);
		end;

	item (an_id: H): T is
			-- Object of id `an_id'.
		local
			info: SERVER_INFO;
			server_file: SERVER_FILE;
			id_to_remove: H;
			to_remove: T;
			real_id: H
		do
			real_id := updated_id (an_id);
			Result := cache.item_id (real_id);
Debug ("CACHE_COMPILER")
	io.putstring (generator)
	if Result = Void then
		io.putstring ("On the disk...%N")
	else
		io.putstring ("In the cache...%N")
	end
end
			if Result = Void then
					-- Id not avaible in memory
				info := tbl_item (real_id);
				if info /= Void then
					server_file := Server_controler.file_of_id (info.id);
					if not server_file.is_open then
						Server_controler.open_file (server_file);
					end;
					Result := retrieve_all (server_file.descriptor, info.position);
						-- Insert it in the queue
					Result.set_id (real_id);
					cache.force (Result)
					to_remove := cache.last_removed_item
					if to_remove /= Void then 
						id_to_remove := id (to_remove)
						if delayed.has (id_to_remove) then
							write (to_remove)
							delayed.remove (id_to_remove)
						end
					end				
				end
			end;
		end;

	remove (an_id: H) is
			-- Remove information of id `an_id'.
			-- NO precondition, the feature will check if the
			-- server has the element to remove.
		local
			old_info: SERVER_INFO;
			old_server_file: SERVER_FILE;
			real_id: H
		do
			real_id := updated_id (an_id);

			cache.remove_id (real_id);

			delayed.remove (real_id);

			old_info := tbl_item (real_id);
			if old_info /= Void then
				old_server_file := Server_controler.file_of_id (old_info.id);
				old_server_file.remove_occurence;
				if old_server_file.occurence = 0 then
					file_ids.prune (old_server_file.id);
				end;
				tbl_remove (real_id);
			end;
		end;

	flush is
			-- Flush server
		local
			c: cache [T, H]	
			to_remove: T
			id_to_remove: H
		do
			from
				c := cache
				c.start
			until
				c.after
			loop
				to_remove := c.item_for_iteration
				id_to_remove := id (to_remove)
				if delayed.has (id_to_remove) then
					write (to_remove)
					delayed.remove (id_to_remove)
				end
				c.forth
			end
		end

	has (an_id: H): BOOLEAN is
			-- Has the server an item of id `an_id' ?
		local
			real_id: H
		do
			real_id := updated_id (an_id);
			Result := cache.has_id (real_id) or else tbl_has (real_id)
		end;

end -- class DELAY_SERVER
