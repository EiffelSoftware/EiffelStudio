indexing
	description: "Comment server for a class indexed by class id.";
	date: "$Date$";
	revision: "$Revision$"

class
	CLASS_COMMENTS_SERVER 

inherit
	COMPILER_SERVER [CLASS_COMMENTS]
		export
			{NONE} all;
			{ANY} has, disk_item, clear, take_control
		redefine
			clear, take_control, remove
		end

creation
	make


feature -- Update

	take_control (other: COMPILER_SERVER [CLASS_COMMENTS]) is
			-- Take control of `other'.
		local
			info, old_info: SERVER_INFO;
			an_id: INTEGER;
			other_file_ids: LINKED_SET [INTEGER];
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
				an_id := other.key_for_iteration;
				old_info := tbl_item (an_id);
				if old_info /= Void then
					old_server_file := Server_controler.file_of_id (old_info.file_id);
					old_server_file.remove_occurrence;
					if old_server_file.occurrence = 0 then
						file_ids.prune (old_server_file.file_id);
					end;
				end;
				force (info, an_id);
				other.forth;
			end;
			other.clear_all;

			other_file_ids := other.file_ids;
			file_ids.merge (other_file_ids);
			other_file_ids.wipe_out;

			current_file_id := other.current_file_id;
			other.set_current_file_id;
		end;   

feature -- Removal

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
				--|Does not do anything for default servers.
			flush;

				-- Empty the files
			from
				start
			until
				after
			loop
				info := item_for_iteration;
				server_file := Server_controler.file_of_id (info.file_id);
				server_file.remove_occurrence;
				forth;
			end;
			clear_all;
			file_ids.wipe_out;
				-- Take a new file
			set_current_file_id;
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
		do
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

feature -- Access

	id (t: CLASS_COMMENTS): INTEGER is
			-- Id associated with `t'
		do
			Result := t.class_id
		end

feature {NONE} -- Implementation

	Cache: CACHE [CLASS_COMMENTS] is
			-- No caching machanism 
			-- (Returns void)
		do
		end;

	Size_limit: INTEGER is 200
			-- Size of the CLASS_COMMENTS_SERVER file (200 Ko)

	Chunk: INTEGER is 500
			-- Size of a HASH_TABLE block

end
