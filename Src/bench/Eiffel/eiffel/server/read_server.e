-- Class for description of a read-only server

deferred class
	READ_SERVER [T -> IDABLE, H -> COMPILER_ID]

inherit
	SERVER [READ_INFO, T, H]

feature -- Access

	item, frozen server_item (an_id: H): T is
			-- Object of id `an_id'
		local
			info: READ_INFO
			server_info: SERVER_INFO
			server_file: SERVER_FILE
			offset: INTEGER
			real_id: H
		do
			real_id := updated_id(an_id)
			Result := cache.item_id (real_id)
			if Result = Void then
					-- Id not avaible in memory
				info := tbl_item (real_id)
				server_info := offsets.item (info.class_id)
				server_file := Server_controler.file_of_id (server_info.id)
				if not server_file.is_open then
					Server_controler.open_file (server_file)
				end
				offset := info.offset + server_info.position
				Result := partial_retrieve (server_file.descriptor, server_file.count, offset, info.object_count)
					-- Insert it in the queue
				if cache.is_full then
						-- If cache is full, oldest is removed
					cache.remove
				end
				Result.set_id (real_id)
				cache.put (Result)
			end
		end

	disk_item (an_id: H): T is
			-- Object of id `an_id'
		local
			info: READ_INFO
			server_info: SERVER_INFO
			server_file: SERVER_FILE
			offset: INTEGER
			real_id: H
		do
			real_id := updated_id(an_id)
			info := tbl_item (real_id)
			server_info := offsets.item (info.class_id)
			server_file := Server_controler.file_of_id (server_info.id)
			if not server_file.is_open then
				Server_controler.open_file (server_file)
			end
			offset := info.offset + server_info.position
			Result := partial_retrieve (server_file.descriptor, server_file.count, offset, info.object_count)
			Result.set_id (real_id)
		end

	remove (an_id: H) is
			-- Simply remove element from server structures
			-- This is as read server, nothing id removed from disk.
			--|Note: the O_N_TABLE table should also be updated but
			--|we are sick and tired of this problem
		local
			real_id: H
		do
			real_id := updated_id (an_id)
			tbl_remove (real_id)
			cache.remove_id (real_id)
		end

	offsets: EXTEND_TABLE [SERVER_INFO, CLASS_ID] is
			-- Class offsets in the corresponding server
		deferred
		end

feature -- Size

	Chunk: INTEGER is 500
			-- Chunk size when updating the READ_SERVER

feature -- Trace

	trace is
		do
		end

end
