indexing
	description: "Delay server"
	date: "$Date$"
	revision: "$Revision$"

deferred class DELAY_SERVER [T -> IDABLE]

inherit
	COMPILER_SERVER [T]
		redefine
			put, flush, item, has, remove
		end

feature
	
	delayed: SEARCH_TABLE [INTEGER] is
			-- Table of delayed ids
		deferred
		end;

	put (t: T) is
			-- Append object `t' in file `file'.
		local
			old_item, to_remove: T;
			an_id, id_to_remove: INTEGER;
		do
debug ("SERVER")
	io.putstring ("Putting element of id: ");
	io.putint (t.id);
	io.putstring ("(");
	io.putint (id (t))
	io.putstring (") into");
	io.putstring (generator);
	io.new_line;
end;
			an_id := id (t)
			t.set_id (an_id);

				-- Put `t' in cache if not full
			old_item := cache.item_id (an_id);
			if old_item = Void then
					-- No previous item of id `t'
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

	item (an_id: INTEGER): T is
			-- Object of id `an_id'.
		local
			info: SERVER_INFO;
			server_file: SERVER_FILE;
			id_to_remove: INTEGER;
			to_remove: T;
		do
			Result := cache.item_id (an_id);
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
				info := tbl_item (an_id);
				if info /= Void then
					server_file := Server_controler.file_of_id (info.file_id);
					if not server_file.is_open then
						Server_controler.open_file (server_file);
					end;
					Result := retrieve_all (server_file.descriptor, info.position);
						-- Insert it in the queue
					Result.set_id (an_id);
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

	remove (an_id: INTEGER) is
			-- Remove information of id `an_id'.
			-- NO precondition, the feature will check if the
			-- server has the element to remove.
		local
			old_info: SERVER_INFO;
			old_server_file: SERVER_FILE;
		do
			cache.remove_id (an_id);

			delayed.remove (an_id);

			old_info := tbl_item (an_id);
			if old_info /= Void then
				old_server_file := Server_controler.file_of_id (old_info.file_id);
				old_server_file.remove_occurrence;
				if old_server_file.occurrence = 0 then
					file_ids.prune (old_server_file.file_id);
				end;
				tbl_remove (an_id);
			end;
		end;

	flush is
			-- Flush server
		local
			c: CACHE [T]	
			to_remove: T
			id_to_remove: INTEGER
		do
			c := cache
			if not c.is_empty then
				from
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
		end

	has (an_id: INTEGER): BOOLEAN is
			-- Has the server an item of id `an_id' ?
		do
			Result := cache.has_id (an_id) or else tbl_has (an_id)
		end;

end -- class DELAY_SERVER
