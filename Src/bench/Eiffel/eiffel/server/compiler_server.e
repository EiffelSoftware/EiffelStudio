indexing
	description: "Offset table associated to a cache"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	set_current_file_id is
			-- Set `current_file_id' to a new value.
		do
debug ("SERVER")
	io.error.put_string (generator)
	io.error.put_string (" set_current_file_id%N")
end
			Server_controler.compute_new_id
			current_file_id := Server_controler.last_computed_id
		end

	put_precompiled (fid: INTEGER; item_id: INTEGER; sinf: SERVER_INFO) is
		do
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
	io.put_string ("Putting element of id: ")
	io.put_integer (t.id)
	io.put_string ("(")
	io.put_integer (id (t))
	io.put_string (") into")
	io.put_string (generator)
	io.put_new_line
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
			create info.make (pos, server_file.file_id)
			server_file.add_occurrence

			old_info := tbl_item (an_id)
			if old_info /= Void then
				old_server_file := Server_controler.file_of_id (old_info.file_id)
				check
						-- Server file should exist since we are getting it from a SERVER_INFO.
					old_server_file_not_void: old_server_file /= Void
				end
				old_server_file.remove_occurrence
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
			l_cache: like cache
		do
			l_cache := cache
			if l_cache /= Void then
				l_cache.remove_id (an_id)
			end
			old_info := tbl_item (an_id)
			if old_info /= Void then
				old_server_file := Server_controler.file_of_id (old_info.file_id)
				check
						-- Server file should exist since we are getting it from a SERVER_INFO.
					old_server_file_not_void: old_server_file /= Void
				end
				old_server_file.remove_occurrence
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
					check
							-- Server file should exist since we are getting it from a SERVER_INFO.
						server_file_not_void: server_file /= Void
					end
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
				check
						-- Server file should exist since we are getting it from a SERVER_INFO.
					server_file_not_void: server_file /= Void
				end
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
				check
						-- Server file should exist since we are getting it from a SERVER_INFO.
					server_file_not_void: server_file /= Void
				end
				server_file.remove_occurrence
				forth
			end
			Precursor {ISE_SERVER}
		end

	take_control (other: COMPILER_SERVER [T]) is
			-- Take control of `other'.
		require
			good_argument: other /= Void
		local
			info, old_info: SERVER_INFO
			an_id: INTEGER
			other_cache: like cache
			l_server_file: SERVER_FILE
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
					l_server_file := Server_controler.file_of_id (old_info.file_id)
					check
							-- Server file should exist since we are getting it from a SERVER_INFO.
						l_server_file_not_void: l_server_file /= Void
					end
					l_server_file.remove_occurrence
				end
				force (info, an_id)
				other.forth
			end
			other.clear_all

			other_cache ?= other.cache
			if other_cache /= Void then
				cache.copy (other_cache)
				other_cache.make
			end
			
			l_server_file := server_controler.file_of_id (other.current_file_id)
			if l_server_file /= Void and then l_server_file.occurrence > 0 then
					-- If there are no objects in the server file for `other', then
					-- preserve the current file_id.
				current_file_id := other.current_file_id
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
			set_keys (other.keys.twin)
				-- `content' should be deep cloned since we don't want to
				-- share the server_info which are a kind of secondary keys
				-- (key to access the data on the disk).
			set_content (other.content.deep_twin)
			set_deleted_marks (other.deleted_marks.twin)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Does server contain the same information as `other'?
		do
			Result :=
				deep_equal (keys, other.keys) and
				deep_equal (content, other.content) and
				equal (deleted_marks, other.deleted_marks) and
				current_file_id = other.current_file_id
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class COMPILER_SERVER
