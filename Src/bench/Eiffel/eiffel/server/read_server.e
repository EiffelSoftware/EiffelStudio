indexing
	description: "Class for description of a read-only server"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	READ_SERVER [T -> IDABLE]

inherit
	ISE_SERVER [READ_INFO, T]

feature -- Access

	item, frozen server_item (an_id: INTEGER): T is
			-- Object of id `an_id'
		do
			Result := cache.item_id (an_id)
			if Result = Void then
				Result := disk_item (an_id)
				if Result /= Void then
					cache.force (Result)
				end
			end
		end

	disk_item (an_id: INTEGER): T is
			-- Object of id `an_id'
		local
			info: READ_INFO
			server_file: SERVER_FILE
		do
			info := tbl_item (an_id)
			if info /= Void then
				server_file := Server_controler.file_of_id (info.file_id)
				check
						-- Server file should exist since we are getting it from a READ_INFO.
					server_file_not_void: server_file /= Void
				end
				if not server_file.is_open then
					Server_controler.open_file (server_file)
				end
				Result := partial_retrieve (server_file.descriptor, info.position, info.object_count)
				Result.set_id (an_id)
			end
		end

	remove (an_id: INTEGER) is
			-- Simply remove element from server structures
			-- This is as read server, nothing id removed from disk.
			--|Note: the O_N_TABLE table should also be updated but
			--|we are sick and tired of this problem
		do
			tbl_remove (an_id)
			cache.remove_id (an_id)
		end

	offsets: HASH_TABLE [SERVER_INFO, INTEGER] is
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

invariant
	cache_not_void: cache /= Void

end
