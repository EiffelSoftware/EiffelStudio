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
	io.put_string ("Putting element of id: ");
	io.put_integer (t.id);
	io.put_string ("(");
	io.put_integer (id (t))
	io.put_string (") into");
	io.put_string (generator);
	io.put_new_line;
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
	io.put_string (generator)
	if Result = Void then
		io.put_string ("On the disk...%N")
	else
		io.put_string ("In the cache...%N")
	end
end
			if Result = Void then
					-- Id not avaible in memory
				info := tbl_item (an_id);
				if info /= Void then
					server_file := Server_controler.file_of_id (info.file_id);
					check
							-- At this stage the compilation is not finished, and therefore
							-- the file of id `info.file_id' should still exists on disk.
						server_file_not_void: server_file /= Void
					end
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
		do
			Precursor {COMPILER_SERVER} (an_id)
			delayed.remove (an_id);
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

invariant
	cache_not_void: cache /= Void

end -- class DELAY_SERVER
