indexing

	description:
		"Temporary comment server for a class.";
	date: "$Date$";
	revision: "$Revision $"

class TMP_CLASS_COMMENTS_SERVER 

inherit
	COMPILER_SERVER [CLASS_COMMENTS, CLASS_ID]
		export
			{NONE} all;
			{ANY} put, flush, start, after, forth,
			item_for_iteration, key_for_iteration,
			clear_all, file_ids, current_id,
			set_current_id, remove, has
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
	io.putstring (t.class_id.dump);
	io.putstring (" into");
	io.putstring (generator);
	io.new_line;
end;
				-- Write item to disk right away.
			write (t);
		end;

feature -- Access

	id (t: CLASS_COMMENTS): CLASS_ID is
			-- Id associated with `t'
		do
			Result := t.class_id
		end

feature -- Removal

	remove (an_id: CLASS_ID) is
			-- Remove information of id `an_id'.
			-- NO precondition, the feature will check if the
			-- server has the element to remove.
			--|Note: the element will actually be removed from
			--|disk at the end of a succesful compilation
		local
			old_info: SERVER_INFO;
			old_server_file: SERVER_FILE;
			real_id: CLASS_ID
		do
			real_id := updated_id (an_id);
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
	
feature {NONE} -- Implementation

	Cache: CACHE [CLASS_COMMENTS, CLASS_ID] is
			-- No caching machanism
			-- (Returns void)
		do
		end

	Delayed: SEARCH_TABLE [CLASS_ID] is
			-- Cache for delayed items
		once
			!!Result.make ((3 * Cache.cache_size) // 2)
		end

	Size_limit: INTEGER is 200
			-- Size of the TMP_CLASS_COMMENTS_SERVER file (200 Ko)

	Chunk: INTEGER is 500
			-- Size of a HASH_TABLE block

end -- class TMP_CLASS_COMMENTS_SERVER
