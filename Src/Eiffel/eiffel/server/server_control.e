note
	description: "Server file controler."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class SERVER_CONTROL

create
	make

feature {NONE} -- Initialization

	make
		do
			create cache.make
			create files.make (0, Chunk)
			create removed_files.make (Chunk)
			create file_counter.make
		end

feature {SERVER_CONTROL} -- Status report

	files: ARRAY [SERVER_FILE]
			-- Table of all the files under the control of the
			-- current object

feature {NONE} -- Status report

	removed_files: HASH_TABLE [SERVER_FILE, INTEGER]
			-- Table of all the removed files

	remove_right_away: BOOLEAN
			-- Should we remove the file as soon as we don't need them?
			--| i.e. only in final mode were we don't need to preserve files
			--| since there is no incrementality here

	Chunk: INTEGER = 50
			-- Array chunk

feature -- Status report

	file_counter: FILE_COUNTER
			-- Server file id counter

	last_computed_id: INTEGER
			-- Last new computed server file id

	cache: CACHE [SERVER_FILE]
			-- Cache for files.

feature -- Update

	set_remove_right_away (v: BOOLEAN)
			-- Set `v' to `remove_right_away'
		do
			remove_right_away := v
		ensure
			remove_right_away_set: remove_right_away = v
		end

feature -- Ids creation

	compute_new_id
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
			files.force (new_file, id)
			last_computed_id := id

debug ("SERVER")
	io.error.put_string ("Creating new file: ")
	io.error.put_string (new_file.file_name (id))
	io.error.put_new_line
end
		end

feature -- File operations

	remove_file (f: SERVER_FILE)
			-- Remove file from Current
		require
			good_argument: f /= Void
			not_precompiled: not f.precompiled
		do
			if f.is_open then
				close_file (f)
			end

				-- Remove `f' from the controler
			files.put (Void, f.file_id)
			removed_files.put (f, f.file_id)

				-- Remove file from the disk if not already deleted
			if f.exists then
				f.delete
			end
		end

	remove_useless_files
			-- Remove all empty files from disk
		do
				-- Delete files from disk which are already not used
			files.do_all (agent (a_file: SERVER_FILE)
				do
					if
						a_file /= Void and then a_file.exists and then
						not a_file.precompiled and a_file.occurrence = 0
					then
						remove_file (a_file)
					end
				end)
		end

	file_of_id (i: INTEGER): SERVER_FILE
			-- File of id `i'.
		require
			i_positive: i > 0
		local
			l_files: like files
		do
			l_files := files
			if l_files.upper >= i then
				Result := l_files.item (i)
			end
		end

	open_file (f: SERVER_FILE)
			-- Open file `f'.
		require
			good_argument: f /= Void
			is_closed: not f.is_open
			not_in_cache: not cache.has_id (f.file_id)
		do
			f.open
			cache.force (f)
			if cache.last_removed_item /= Void then
				cache.last_removed_item.close
				check
					not_in_cache: not cache.has_id (cache.last_removed_item.file_id)
				end
			end
		ensure
			is_open: f.is_open
		end

	close_file (f: SERVER_FILE)
			-- Close file `f'
		require
			f_not_void: f /= Void
			is_open: f.is_open
			has_id: cache.has_id (f.file_id)
		do
			f.close
			cache.remove_id (f.file_id)
		ensure
			f_closed: not f.is_open
			not_in_cache: not cache.has_id (f.file_id)
		end

	wipe_out
			-- Empty the cache
		do
			from
				cache.start
			until
				cache.after
			loop
				cache.item_for_iteration.close
				cache.forth
			end
			cache.wipe_out
		end

feature -- Status report

	is_readable: BOOLEAN
			-- Are the server files readable?
		do
			Result := files.for_all (agent (a_file: SERVER_FILE): BOOLEAN
				do
					Result := a_file = Void or else
						(a_file.exists and then a_file.is_readable)
				end)
		end

	is_writable: BOOLEAN
			-- Are the server files readable and writable?
		do
			Result := files.for_all (agent (a_file: SERVER_FILE): BOOLEAN
				do
					if a_file /= Void and then a_file.exists then
						if a_file.precompiled then
							Result := a_file.is_readable
						else
							Result := a_file.is_readable and a_file.is_writable
						end
					else
						Result := True
					end
				end)
		end

	exists: BOOLEAN
			-- Do the server files exist?
		do
			Result := files.for_all (agent (a_file: SERVER_FILE): BOOLEAN
				do
					Result := a_file = Void or else a_file.exists
				end)
		end

feature -- Initialization

	init
			-- Update the path names of the various server files.
		do
			files.do_all (agent (a_file: SERVER_FILE)
				do
					if a_file /= Void then
						a_file.update_path
					end
				end)
		end

feature -- Merging

	append (other: like Current)
			-- Append `other' to `Current'.
			-- Used when merging precompilations.
		require
			other_not_void: other /= Void
		do
			file_counter.append (other.file_counter)
			other.files.do_all_with_index (agent (a_file: SERVER_FILE; a_index: INTEGER)
				do
					if a_file /= Void then
						files.force (a_file, a_index)
					end
				end)
		end

feature -- SERVER_FILE sizes

	block_size: INTEGER

	set_block_size (s: INTEGER)
		do
			block_size := s
		end

invariant
	files_not_void: files /= Void
	removed_files_not_void: removed_files /= Void
	file_counter_not_void: file_counter /= Void

note
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

end -- class SERVER_CONTROL
