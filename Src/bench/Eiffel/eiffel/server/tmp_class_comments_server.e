indexing
	description: "Temporary comment server for a class indexed by class id.";
	date: "$Date$";
	revision: "$Revision$"

class TMP_CLASS_COMMENTS_SERVER 

inherit
	COMPILER_SERVER [CLASS_COMMENTS]
		export
			{NONE} all;
			{ANY} put, flush, start, after, forth,
			item_for_iteration, key_for_iteration,
			clear_all, file_ids, current_file_id,
			set_current_file_id, remove, has
		redefine
			put, remove
		end

creation
	make


feature -- Element change

	put (t: CLASS_COMMENTS) is
			-- Put object `t' in server.
		do
debug ("SERVER")
	io.putstring ("Putting element of id: ");
	io.putint (t.class_id);
	io.putstring (" into");
	io.putstring (generator);
	io.new_line;
end;
				-- Write item to disk right away.
			write (t);
		end;

feature -- Access

	id (t: CLASS_COMMENTS): INTEGER is
			-- Id associated with `t'
		do
			Result := t.class_id
		end

feature -- Removal

	remove (an_id: INTEGER) is
			-- Remove information of id `an_id'.
			-- NO precondition, the feature will check if the
			-- server has the element to remove.
			--|Note: the element will actually be removed from
			--|disk at the end of a succesful compilation
		local
			old_info: SERVER_INFO;
			old_server_file: SERVER_FILE;
		do
			old_info := tbl_item (an_id);
			if old_info /= Void then
				old_server_file := Server_controler.file_of_id (old_info.file_id);
				old_server_file.remove_occurence;
				if old_server_file.occurence = 0 then
					file_ids.prune (old_server_file.file_id);
				end;
				tbl_remove (an_id);
			end;
		end;
	
feature {NONE} -- Implementation

	Cache: CACHE [CLASS_COMMENTS] is
			-- No caching machanism
			-- (Returns void)
		do
		end

	Delayed: SEARCH_TABLE [INTEGER] is
			-- Cache for delayed items
		once
			!!Result.make ((3 * Cache.cache_size) // 2)
		end

	Size_limit: INTEGER is 200
			-- Size of the TMP_CLASS_COMMENTS_SERVER file (200 Ko)

	Chunk: INTEGER is 500
			-- Size of a HASH_TABLE block

end -- class TMP_CLASS_COMMENTS_SERVER
