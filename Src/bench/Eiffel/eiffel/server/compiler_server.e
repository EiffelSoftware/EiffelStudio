indexing
	description: "Offset table associated to a cache"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COMPILER_SERVER [T -> IDABLE]

inherit
	ISE_SERVER [SERVER_INFO, T]
		redefine
			make,
			clear,
			copy,
			is_equal
		end

feature -- Initialization

	make is
		do
			create file_ids.make
			file_ids.compare_objects
			set_current_file_id
			tbl_make (Chunk)
		end

feature

	id (t: T): INTEGER is
			-- Id associated with `t'
		require
			t_not_void: t /= Void
		deferred
		end

	current_file_id: INTEGER
			-- Current server file id used by primitive `put'.

	file_ids: LINKED_SET [INTEGER]
			-- Set of server file ids under the control of the
			-- current server

	set_current_file_id is
			-- Set `current_file_id' to a new value.
		do
debug ("SERVER")
	io.error.putstring (generator)
	io.error.putstring (" set_current_file_id%N")
end
			Server_controler.compute_new_id
			current_file_id := Server_controler.last_computed_id
			file_ids.extend (current_file_id)
		end

	put_precompiled (fid: INTEGER; item_id: INTEGER; sinf: SERVER_INFO) is
		do
			file_ids.extend (fid)
			force (sinf, item_id)
		end

	Size_limit: INTEGER is
			-- Limit of the size of one file under the control	
			-- of the current server
		deferred
		end

	put (t: T) is
			-- Put object `t' in server.
		local
			old_item: T
		do
debug ("SERVER")
	io.putstring ("Putting element of id: ")
	io.putint (t.id)
	io.putstring ("(")
	io.putint (id (t))
	io.putstring (") into")
	io.putstring (generator)
	io.new_line
end
				-- Update id of element
			t.set_id (id (t))

				-- Write item to disk right away.
			write (t)
		
				-- Put `t' in cache if not full.
			old_item := cache.item_id (id (t))
			if old_item = Void then
					-- No previous item of id `t'
				cache.force (t)
			else
					-- There is a previous item and routine `item_id' 
					-- reorganized the cache
				cache.change_last_item (t)
			end
		end

	write (t: T) is
			-- Write item `t' on disk
		local
			an_id: INTEGER
			pos: INTEGER
			server_file, old_server_file: SERVER_FILE
			info, old_info: SERVER_INFO
		do
			server_file := Server_controler.file_of_id (current_file_id)
			if
				server_file = Void
				or else server_file.last_offset > Size_limit * Server_controler.block_size
				or else server_file.precompiled
			then 
				set_current_file_id
				server_file := Server_controler.file_of_id (current_file_id)
			end
			if not server_file.is_open then
				Server_controler.open_file (server_file)
			end

			an_id := id (t)

debug ("SERVER")
	print ("%N%Nitem in ")
	print (generator)
	print (" writing ID ")
	print (an_id)
end

			pos := store_append (server_file.descriptor, $t, $make_index, $need_index, $Current)
			!! info.make (pos, server_file.file_id)
			server_file.add_occurence

			old_info := tbl_item (an_id)
			if old_info /= Void then
				old_server_file := Server_controler.file_of_id (old_info.file_id)
				old_server_file.remove_occurence
				if old_server_file.occurence = 0 then
					file_ids.prune (old_server_file.file_id)
				end
			end
			force (info, an_id)
		end

	remove (an_id: INTEGER) is
			-- Remove information of id `an_id'.
			-- NO precondition, the feature will check if the
			-- server has the element to remove.
			--|Note: the element will actually be removed from
			--|disk at the end of a succesful compilation
		local
			old_info: SERVER_INFO
			old_server_file: SERVER_FILE
		do
			cache.remove_id (an_id)
			old_info := tbl_item (an_id)
			if old_info /= Void then
				old_server_file := Server_controler.file_of_id (old_info.file_id)
				old_server_file.remove_occurence
				if old_server_file.occurence = 0 then
					file_ids.prune (old_server_file.file_id)
				end
				tbl_remove (an_id)
			end
		end

	item, frozen server_item (an_id: INTEGER): T is
			-- Object of id `an_id'.
		local
			info: SERVER_INFO
			server_file: SERVER_FILE
		do

debug ("SERVER")
	print ("%N%Nitem in ")
	print (generator)
	print (" looking for ")
	print (an_id)
end

			Result := cache.item_id (an_id)
			if Result = Void then

debug ("SERVER")
	print ("ID was not found in cache.")
end

					-- Id not avaible in memory
				info := tbl_item (an_id)
				if info /= Void then
					server_file := Server_controler.file_of_id (info.file_id)
					if not server_file.is_open then
						Server_controler.open_file (server_file)
					end
					Result := retrieve_all (server_file.descriptor, info.position)
						-- Insert it in the queue
					Result.set_id (an_id)
					cache.force (Result)
				end
			end
		end

	disk_item (an_id: INTEGER): T is
			-- Object of id `an_id' on disk.
		local
			info: SERVER_INFO
			server_file: SERVER_FILE
		do

debug ("SERVER")
	print ("%N%Nitem in ")
	print (generator)
	print (" looking on the DISK for ")
	print (an_id)
end

			info := tbl_item (an_id)
			if info /= Void then
				server_file := Server_controler.file_of_id (info.file_id)
				if not server_file.is_open then
					Server_controler.open_file (server_file)
				end
					-- Id not avaible in memory
				Result := retrieve_all (server_file.descriptor, info.position)
				Result.set_id (an_id)
			end
		end

	clear is
			-- Clear the server.
			-- Clears the server entirely.
			-- Must not be used in conjunction with 
			-- `take_control' since that routine relies
			-- on shallow copy semantics!
		local
			info: SERVER_INFO
			server_file: SERVER_FILE
		do
				-- Flush the cache
				--|Does not do anything for default servers.
			flush

				-- Empty the files
			from
				start
			until
				after
			loop
				info := item_for_iteration
				server_file := Server_controler.file_of_id (info.file_id)
				server_file.remove_occurence
				forth
			end
			file_ids.wipe_out
			{ISE_SERVER} Precursor
				-- Take a new file
			set_current_file_id
		end

	take_control (other: COMPILER_SERVER [T]) is
			-- Take control of `other'.
		require
			good_argument: other /= Void
		local
			info, old_info: SERVER_INFO
			an_id: INTEGER
			other_file_ids: LINKED_SET [INTEGER]
			other_cache: CACHE [T]
			old_server_file: SERVER_FILE
		do
			flush
			other.flush
			from
				other.start
			until
				other.after
			loop
				info := other.item_for_iteration
				an_id := other.key_for_iteration
				old_info := tbl_item (an_id)
				if old_info /= Void then
					old_server_file := Server_controler.file_of_id (old_info.file_id)
					old_server_file.remove_occurence
					if old_server_file.occurence = 0 then
						file_ids.prune (old_server_file.file_id)
					end
				end
				force (info, an_id)
				other.forth
			end
			other.clear_all

				-- Merge the file under the control of the Current server
				-- Remove useless files from other so that we don't encumber
				-- the current server.
			other_file_ids := other.file_ids
			other.files_purge
			file_ids.merge (other_file_ids)
			other_file_ids.wipe_out

			other_cache := other.cache
			cache.copy (other_cache)
			other_cache.make

			current_file_id := other.current_file_id
			other.set_current_file_id

			--partial_purge
		end;			

	files_purge is
			-- Purge the files, i.e. removed non used files from the disk
		local
			file_list: LINKED_LIST [INTEGER]
			server_file: SERVER_FILE
		do
			from
				file_list := file_ids
				file_list.start
			until
				file_list.after
			loop
				server_file := Server_controler.file_of_id (file_list.item)
				if server_file.occurence = 0 then
					Server_controler.forget_file (server_file)
					file_list.remove
				else
					file_list.forth
				end
			end
		end

	purge is
			-- Purge useless datas from current server
		local
			new: like Current
			old_count: INTEGER
			file_id: INTEGER
			old_info: SERVER_INFO
			old_server_file: SERVER_FILE
			order: LINKED_LIST [INTEGER]
			an_id: INTEGER
		do
				-- Clean first
			flush
			cache.wipe_out
			old_count := count
			count := 0

				-- Create a new server which will be copied in Current
			new := clone (Current)
			new.make
debug ("SERVER")
	io.putstring ("===== Purging: ")
	io.putstring (generator)
	io.putstring (" =====%N")
end
			from
					-- Iterate on items sorted by file ids so the purge
					-- will be smooth regarding the disk space
				order := file_ids
				order.start
			until
				order.after
			loop
				file_id := order.item
debug ("SERVER")
	io.put_string ("File: ")
	print (file_id)
	io.new_line
end
				from
					start
				until
					after
				loop
					old_info := item_for_iteration
					old_server_file := Server_controler.file_of_id (old_info.file_id)
					an_id := key_for_iteration
					if old_info.file_id = file_id then
						if old_server_file.precompiled then
							new.put_precompiled (file_id, an_id, old_info)
						else
debug ("SERVER")
	io.putstring ("%TTransferring one element")
end
								-- Put in purged server alive item	
							new.write (item (an_id))
	
								-- Remove occurence from file where item was stored
							old_server_file.remove_occurence
debug ("SERVER")
	io.putstring (". Occurrences are now: ")
	io.putint (old_server_file.occurence)
	io.new_line
end
						end
					end
					forth
				end
				old_server_file := Server_controler.file_of_id (file_id)
				if old_server_file /= Void then
debug ("SERVER")
	io.putstring ("==> Removing the file%N")
end
				if not old_server_file.precompiled then
					Server_controler.remove_file (old_server_file)
				end
end
				order.forth
			end
			check
				same_count: new.count = old_count
			end
			copy (new)
		end

	partial_purge is
			-- Perform a partial purge on the server
		local
			old_info: SERVER_INFO
			old_server_file: SERVER_FILE
			an_id: INTEGER
			live_ids: LINKED_LIST [INTEGER]
			dead_files: LINKED_SET [SERVER_FILE]
		do
debug ("SERVER")
	io.error.putstring ("partial_purge")
	io.error.new_line
end
			flush

			from
				!! live_ids.make
				!! dead_files.make
				start
			until
				after
			loop
				old_info := item_for_iteration
				an_id := key_for_iteration
				old_server_file := Server_controler.file_of_id (old_info.file_id)
				if old_server_file.need_purging then
						-- Avoid side effects on the iteration
debug ("SERVER")
	io.error.putstring ("Marking id ")
	io.error.putint (an_id)
	io.error.putstring (" from ")
	io.error.putint (old_server_file.file_id)
	io.error.new_line
end
					live_ids.extend (an_id)
					live_ids.forth
					dead_files.extend (old_server_file)
				end
				forth
			end

			from
				live_ids.start
			until
				live_ids.after
			loop
debug ("SERVER")
	io.error.putstring ("Rewritting id ")
	io.error.putint (live_ids.item)
	io.error.new_line
end
				write (item (live_ids.item))
				live_ids.forth
			end
			from
				dead_files.start
			until
				dead_files.after
			loop
				old_server_file := dead_files.item
debug ("SERVER")
	io.error.putstring ("Deleting file ")
	io.error.putint (old_server_file.file_id)
	io.error.new_line
	old_server_file.trace
end
				check
					is_dead: old_server_file.occurence = 0
				end
				old_server_file.delete
				dead_files.forth
			end
		end

	flush is
			-- Flush server
		do
			-- Do nothing
		end

	make_index (obj: ANY; file_position, object_count: INTEGER) is
			-- Index building
		require
			need_index (obj)
		do
		end

	need_index (obj: ANY): BOOLEAN is
			-- Is an index needed for `obj'?
		do
		end

feature -- Duplication

	copy (other: like Current) is
			-- Re-initialize from `other'.
		do
			standard_copy (other)
			set_keys (clone (other.keys))
				-- `content' should be deep cloned since we don't want to
				-- share the server_info which are a kind of secondary keys
				-- (key to access the data on the disk).
			set_content (deep_clone (other.content))
			set_deleted_marks (clone (other.deleted_marks))
				-- `file_ids' is deep cloned as well for the same reason:
				-- we don't want it to be shared.
			file_ids := deep_clone (other.file_ids)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Does server contain the same information as `other'?
		do
			Result :=
				deep_equal (keys, other.keys) and
				deep_equal (content, other.content) and
				equal (deleted_marks, other.deleted_marks) and
				current_file_id = other.current_file_id and
				deep_equal (file_ids, other.file_ids)
		end

end -- class COMPILER_SERVER
