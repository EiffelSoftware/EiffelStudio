indexing

	description:
		"Temporary comment server for a class.";
	date: "$Date$";
	revision: "$Revision $"

class TMP_CLASS_COMMENTS_SERVER 

inherit

	SERVER [CLASS_COMMENTS]
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
	io.putint (t.class_id.id);
	io.putstring (" into");
	io.putstring (generator);
	io.new_line;
end;
				-- Write item to disk right away.
			write (t);
		end;

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
			real_id: INTEGER
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

	Cache: CACHE [CLASS_COMMENTS] is
			-- No caching machanism
			-- (Returns void)
		do
		end;

	Delayed: SEARCH_TABLE [INTEGER] is
			-- Cache for delayed items
		local
			csize: INTEGER
		once
			csize := Cache.cache_size;
			!!Result.make ((3 * csize) // 2);
		end;

	Size_limit: INTEGER is 10;

end -- class TMP_CLASS_COMMENTS_SERVER
