indexing
	description: "Server file controler."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class SERVER_CONTROL

inherit
	CACHE [SERVER_FILE]
		redefine
			make, wipe_out
		end

create
	make

feature -- Initialization

	make is
		do
			Precursor {CACHE}
			create files.make (Chunk)
			create removed_files.make (Chunk)
			create file_counter.make
		end

feature -- Status

	files: HASH_TABLE [SERVER_FILE, INTEGER]
			-- Table of all the files under the control of the
			-- current object

	removed_files: HASH_TABLE [SERVER_FILE, INTEGER]
			-- Table of all the removed files

	remove_right_away: BOOLEAN
			-- Should we remove the file as soon as we don't need them?
			--| i.e. only in final mode were we don't need to preserve files
			--| since there is no incrementality here

	file_counter: FILE_COUNTER
			-- Server file id counter

	last_computed_id: INTEGER
			-- Last new computed server file id

	Chunk: INTEGER is 50
			-- Array chunk

feature -- Update

	set_remove_right_away (v: BOOLEAN) is
			-- Set `v' to `remove_right_away'
		do
			remove_right_away := v
		ensure
			remove_right_away_set: remove_right_away = v
		end

feature -- Ids creation

	compute_new_id is
			-- Compute a new server file id and assign it to `last_computed_id'.
		local
			local_files: like removed_files
			new_file: SERVER_FILE
			id: INTEGER
		do
				-- Get a new ID.
			local_files := removed_files
			if local_files.count > 0 then
				local_files.start
				id := local_files.key_for_iteration
				local_files.remove (id)
			else
				id := file_counter.next_id
			end

			create new_file.make (id)
			files.put (new_file, id)
			last_computed_id := id
			
debug ("SERVER")
	io.error.put_string ("Creating new file: ")
	io.error.put_string (new_file.file_name (id))
	io.error.put_new_line
end
		end

feature -- File operations

	remove_file (f: SERVER_FILE) is
			-- Remove file from Current
		require
			good_argument: f /= Void
			not_precompiled: not f.precompiled
		do
			if f.is_open then
				close_file (f)
			end

				-- Remove `f' from the controler
			files.remove (f.file_id)
			removed_files.put (f, f.file_id)

				-- Remove file from the disk if not already deleted
			if f.exists then
				f.delete
			end
		end

	remove_useless_files is
			-- Remove all empty files from disk
		local
			file: SERVER_FILE
			local_files: HASH_TABLE [SERVER_FILE, INTEGER]
		do
				-- Delete files from disk which are already not used
			from
				local_files := files
				local_files.start
			until
				local_files.after
			loop
				file := local_files.item_for_iteration
				if file.exists and then not file.precompiled and file.occurrence = 0 then
					remove_file (file)
				end
				local_files.forth
			end
		end

	file_of_id (i: INTEGER): SERVER_FILE is
			-- File of id `i'.
		require
			id_not_void: i > 0
		do
			Result := files.item (i)
		end

	open_file (f: SERVER_FILE) is
			-- Open file `f'.
		require
			good_argument: f /= Void
			is_closed: not f.is_open
		do
			f.open
			force (f)
			if last_removed_item /= Void then
				last_removed_item.close
				check 
					not_in_cache: not has_id (last_removed_item.file_id)
				end
			end
		ensure
			is_open: f.is_open
		end
		
	close_file (f: SERVER_FILE) is
			-- Close file `f'
		require
			f_not_void: f /= Void
			is_open: f.is_open
			has_id: has_id (f.file_id)
		do
			f.close
			remove_id (f.file_id)
		ensure
			f_closed: not f.is_open
			not_in_cache: not has_id (f.file_id)
		end

	Default_size: INTEGER is 20

	wipe_out is
			-- Empty the cache
		do
			from
				start
			until
				after
			loop
				item_for_iteration.close
				forth
			end
			Precursor {CACHE}
		end

feature -- Status report

	is_readable: BOOLEAN is
			-- Are the server files readable?
		local
			file: SERVER_FILE
			local_files: like files
		do
			from
				Result := True
				local_files := files
				local_files.start
			until
				not Result or local_files.after
			loop
				file:= local_files.item_for_iteration
				if file.exists then
					Result := file.is_readable
				end
				local_files.forth
			end
		end

	is_writable: BOOLEAN is
			-- Are the server files readable and writable?
		local
			file: SERVER_FILE
			local_files: like files
		do
			from
				Result := True
				local_files := files
				local_files.start
			until
				not Result or local_files.after
			loop
				file:= local_files.item_for_iteration
				if file.exists then
					if file.precompiled then
						Result := file.is_readable
					else
						Result := (file.is_readable and file.is_writable)
					end
				end
				local_files.forth
			end
		end

	exists: BOOLEAN is
			-- Do the server files exist?
		local
			local_files: like files
		do
			from
				Result := True
				local_files := files
				local_files.start
			until
				not Result or local_files.after
			loop
				Result := local_files.item_for_iteration.exists
				local_files.forth
			end
		end	

feature -- Initialization

	init is
			-- Update the path names of the various server files.
		local
			local_files: like files
		do
			from
				local_files := files
				local_files.start
			until
				local_files.after
			loop
				local_files.item_for_iteration.update_path
				local_files.forth
			end
		end

feature -- Merging

	append (other: like Current) is
			-- Append `other' to `Current'.
			-- Used when merging precompilations.
		require
			other_not_void: other /= Void
		do
			file_counter.append (other.file_counter)
			files.merge (other.files)
		end
			
feature -- SERVER_FILE sizes

	block_size: INTEGER

	set_block_size (s: INTEGER) is
		do
			block_size := s
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class SERVER_CONTROL
