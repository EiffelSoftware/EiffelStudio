-- Offset table associated to a cache

deferred class
	COMPILER_SERVER [T -> IDABLE, H -> COMPILER_ID]

inherit
	SERVER [SERVER_INFO, T, H]
		redefine
			make,
			clear,
			copy,
			is_equal
		end

feature -- Initialization

	make is
		do
			!! file_ids.make
			file_ids.compare_objects
			set_current_id
			tbl_make (Chunk)
		end

feature

	id (t: T): H is
			-- Id associated with `t'
		require
			t_not_void: t /= Void
		deferred
		end

	current_id: FILE_ID
			-- Current server file id used by primitive `put'.

	file_ids: LINKED_SET [FILE_ID]
			-- Set of server file ids under the control of the
			-- current server

	set_current_id is
			-- Set `current_id' to a new value.
		do
debug ("SERVER")
	io.error.putstring (generator)
	io.error.putstring (" set_current_id%N")
end
			Server_controler.compute_new_id
			current_id := Server_controler.last_computed_id
			file_ids.extend (current_id)
		end

	put_precompiled (fid: FILE_ID; item_id: H; sinf: SERVER_INFO) is
		local
			server_file: SERVER_FILE
			info: SERVER_INFO
		do
			file_ids.extend (fid)
			force (sinf, updated_id (item_id))
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
	io.putstring (t.id.dump)
	io.putstring ("(")
	io.putstring (updated_id (id (t)).dump)
	io.putstring (") into")
	io.putstring (generator)
	io.new_line
end
				-- Update id of element
			t.set_id (updated_id (id (t)))

				-- Write item to disk right away.
			write (t)
		
				-- Put `t' in cache if not full.
			old_item := cache.item_id (id (t))
			if old_item = Void then
					-- No previous item of id `t.id'
				if cache.is_full then
					cache.remove
				end
				cache.put (t)
			else
					-- There is a previous item and routine `item_id' 
					-- reorganized the cache
				cache.change_last_item (t)
			end
		end

	write (t: T) is
			-- Write item `t' on disk
		local
			an_id: H
			pos: INTEGER
			server_file, old_server_file: SERVER_FILE
			info, old_info: SERVER_INFO
		do
			server_file := Server_controler.file_of_id (current_id)
			if
				server_file.count > Size_limit * Server_controler.block_size
				or else server_file.precompiled
				or else server_file.is_static
			then 
				set_current_id
				server_file := Server_controler.file_of_id (current_id)
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
			!! info.make (pos, server_file.id)
			server_file.add_occurence

			old_info := tbl_item (an_id)
			if old_info /= Void then
				old_server_file := Server_controler.file_of_id (old_info.id)
				old_server_file.remove_occurence
				if old_server_file.occurence = 0 then
					file_ids.prune (old_server_file.id)
				end
			end
			force (info, an_id)
		end

	remove (an_id: H) is
			-- Remove information of id `an_id'.
			-- NO precondition, the feature will check if the
			-- server has the element to remove.
			--|Note: the element will actually be removed from
			--|disk at the end of a succesful compilation
		local
			old_info: SERVER_INFO
			old_server_file: SERVER_FILE
			real_id: H
		do
			real_id := updated_id (an_id)
			cache.remove_id (real_id)
			old_info := tbl_item (real_id)
			if old_info /= Void then
				old_server_file := Server_controler.file_of_id (old_info.id)
				old_server_file.remove_occurence
				if old_server_file.occurence = 0 then
					file_ids.prune (old_server_file.id)
				end
				tbl_remove (real_id)
			end
		end

	item, frozen server_item (an_id: H): T is
			-- Object of id `an_id'.
		local
			info: SERVER_INFO
			server_file: SERVER_FILE
			real_id: H
		do

debug ("SERVER")
	print ("%N%Nitem in ")
	print (generator)
	print (" looking for ")
	print (an_id)
end

			real_id := updated_id (an_id)
			Result := cache.item_id (real_id)
			if Result = Void then

debug ("SERVER")
	print ("ID was not found in cache.")
end

					-- Id not avaible in memory
				info := tbl_item (real_id)
				server_file := Server_controler.file_of_id (info.id)
				if not server_file.is_open then
					Server_controler.open_file (server_file)
				end
				Result := retrieve_all (server_file.descriptor, server_file.count, info.position)
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
			-- Object of id `an_id' on disk.
		local
			info: SERVER_INFO
			server_file: SERVER_FILE
			real_id: H
		do

debug ("SERVER")
	print ("%N%Nitem in ")
	print (generator)
	print (" looking on the DISK for ")
	print (an_id)
end

			real_id := updated_id (an_id)
			info := tbl_item (real_id)
			server_file := Server_controler.file_of_id (info.id)
			if not server_file.is_open then
				Server_controler.open_file (server_file)
			end
				-- Id not avaible in memory
			Result := retrieve_all (server_file.descriptor, server_file.count, info.position)
			Result.set_id (real_id)
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
				server_file := Server_controler.file_of_id (info.id)
				server_file.remove_occurence
				forth
			end
			file_ids.wipe_out
			{SERVER} Precursor
				-- Take a new file
			set_current_id
		end

	take_control (other: COMPILER_SERVER [T, H]) is
			-- Take control of `other'.
		require
			good_argument: other /= Void
		local
			info, old_info: SERVER_INFO
			an_id: H
			other_file_ids: LINKED_SET [FILE_ID]
			other_cache: CACHE [T, H]
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
					old_server_file := Server_controler.file_of_id
																(old_info.id)
					old_server_file.remove_occurence
					if old_server_file.occurence = 0 then
						file_ids.prune (old_server_file.id)
					end
				end
				force (info, an_id)
				other.forth
			end
			other.clear_all

			other_file_ids := other.file_ids
			file_ids.merge (other_file_ids)
			other_file_ids.wipe_out

			other_cache := other.cache
			cache.copy (other_cache)
			other_cache.make

			current_id := other.current_id
			other.set_current_id

			--partial_purge
		end;			

	purge is
			-- Purge useless datas from current server
		local
			new: like Current
			old_count: INTEGER
			file_id: FILE_ID
			old_info: SERVER_INFO
			old_server_file: SERVER_FILE
			order: LINKED_LIST [FILE_ID]
			an_id: H
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
	io.put_string (file_id.file_name)
	io.new_line
end
				from
					start
				until
					after
				loop
					old_info := item_for_iteration
					old_server_file :=
						Server_controler.file_of_id (old_info.id)
					an_id := key_for_iteration
					if equal (old_info.id, file_id) then
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
			an_id: H
			live_ids: LINKED_LIST [H]
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
				old_server_file := Server_controler.file_of_id (old_info.id)
				if old_server_file.need_purging then
						-- Avoid side effects on the iteration
debug ("SERVER")
	io.error.putstring ("Marking id ")
	io.error.putint (an_id.id)
	io.error.putstring (" from ")
	io.error.putint (old_server_file.id.id)
	io.error.new_line
end
					live_ids.extend (an_id)
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
	io.error.putint (live_ids.item.id)
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
	io.error.putint (old_server_file.id.id)
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
				equal (current_id, other.current_id) and
				deep_equal (file_ids, other.file_ids)
		end

end -- class COMPILER_SERVER
