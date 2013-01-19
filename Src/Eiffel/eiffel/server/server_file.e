note
	description: "File for server."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class SERVER_FILE

inherit
	IDABLE
		rename
			id as file_id,
			set_id as set_file_id
		end

	PROJECT_CONTEXT

	SHARED_SCONTROL

	SHARED_EIFFEL_PROJECT

create
	make

feature -- Initialization

	make (i: INTEGER)
			-- Initialization
		require
			positive_argument: i /= 0
		local
			d_name: PATH
			temp: STRING_32
			d: DIRECTORY
		do
			create temp.make (5)
			temp.extend ('S')
			temp.append_integer (packet_number (i))
			d_name := project_location.compilation_path.extended (temp)
			create d.make_with_path (d_name)
			if not d.exists then
				d.create_dir
			end
			create file.make_with_path (d_name.extended (file_name (i)))
			if not Eiffel_project.is_read_only then
					--| Re-finalization after a crash: the COMP
					--| directory doesn't grow and grow and grow
				clear_content
			end
			file_id := i
debug ("SERVER")
	io.error.put_string ("Creating file ")
	io.error.put_string (file_name (i))
	io.error.put_new_line
end
		end

feature -- Access

	name: READABLE_STRING_GENERAL
			-- File name.
		do
			Result := file.path.name
		end

	occurrence: INTEGER
			-- Occurrence of the file in the server control

	is_open: BOOLEAN
			-- Is the current file open ?
		do
			Result := file.is_open_read or else file.is_open_write or else file.is_open_append
		end

	descriptor: INTEGER
			-- File descriptor as used by the operating system.
		require
			file_opened: is_open
		do
			Result := file.descriptor
		end

	add_occurrence
			-- Add one occurrence.
		do
			occurrence := occurrence + 1
		end

	remove_occurrence
			-- Remove one occurrence and remove current file from
			-- the server controler if null occurrence
			--|Note: If occurrence goes down to 0 the file
			--|is not removed from disk straight away, since that
			--|might render a Project irretrievable after an interrupted
			--|compilation. Instead, the file will be removed at the end of a succesful
			--|compilation by the server controller.
		require
			positive_occurrence: occurrence > 0
		do
			occurrence := occurrence - 1
			if occurrence = 0 and is_open then
				server_controler.close_file (Current)
			end
		ensure
			occurrence = 0 implies (not is_open)
		end

feature -- Status setting

	open
			-- Open file in read mode if precompiled
			-- in read-write otherwise.
		require
			is_closed: not is_open
		local
			l_open_write: BOOLEAN
			is_retried: BOOLEAN
		do
			if Eiffel_project.is_read_only or else precompiled or else l_open_write then
					-- Open the file in `Read' mode only.
				file.open_read
			else
					-- Open the file in `Read-Write' mode.
				l_open_write := True
				file.open_read_write
			end
debug ("SERVER")
	io.error.put_string ("Opening file ")
	io.error.put_string (file_name (file_id))
	io.error.put_new_line
end
		ensure
			opened: is_open
		rescue
				-- `is_writable' is True on Windows when current user (not the owner)
				-- does not have the actual permission.
				-- So we have to rescue and retry to reopen it in read mode. See bug#13251.
			if l_open_write then
				if not is_retried then
					is_retried := True
					retry
				end
			end
		end

	server_open_write
			-- Open file in append mode only for doing `store_append' in
			-- COMPILER_SERVER
		require
			is_closed: not is_open
		do
			file.open_read_append
		ensure
			opened: is_open
		end

	last_offset: INTEGER
			-- Return the size of the file without checking it exists.
		require
			file_exists: is_open or else exists
		do
			Result := file.count
		end

	close
			-- Close server file
		require
			is_open: is_open
		do
			file.close
		ensure
			is_closed: not is_open
		end

	clear_content
			-- Clear the content of a file by opening it
			-- in write-only mode and closing it.
		local
			retried: BOOLEAN
		do
			if not retried then
				file.open_write
				close
			end
		rescue
			retried := True
			retry
		end

	update_path
			-- Update the file path of Current
			-- server file. (It might have changed
			-- between compilations)
		local
			temp: STRING
		do
			create temp.make (5)
			temp.extend ('S')
			temp.append_integer (packet_number (file_id))
			create file.make_with_path (directory_path (file_id).extended (temp).extended (file_name (file_id)))
		end

feature -- Status report

	exists: BOOLEAN
			-- Does physical file exist?
			-- (Uses effective UID.)
		do
			Result := file.exists
		end

	is_readable: BOOLEAN
			-- Is file readable?
			-- (Checks permission for effective UID.)
		do
			Result := file.is_readable
		end

	is_writable: BOOLEAN
			-- Is file writable?
			-- (Checks write permission for effective UID.)
		do
			Result := file.is_writable
		end

	is_readable_and_writable: BOOLEAN
			-- Is file readable and writable?
			-- (Checks permission for effective UID.)
		do
			Result := file.is_readable and then file.is_writable
		end

	precompiled: BOOLEAN
			-- Does the Current server file contain
			-- precompiled information?
		do
			Result := file_counter.is_precompiled (file_id)
		end

feature -- Removal

	delete
			-- Remove link with physical file.
			-- File does not physically disappear from the disk
			-- until no more processes reference it.
			-- I/O operations on it are still possible.
			-- A directory must be empty to be deleted.
		require
			exists: exists
		local
			retried: BOOLEAN
		do
			if not retried then
				file.delete
			end
		rescue
			retried := True
			retry
		end

feature {SERVER_CONTROL, SERVER_FILE} -- File access

	packet_number (an_id: INTEGER): INTEGER
			-- Packet in which the file will be stored (100 is the default_size)
		do
			Result := (an_id // 100) + 1
		end

	file_name (an_id: INTEGER): STRING
			-- Server file basename
		do
			create Result.make (7)
			Result.extend ('E')
			Result.append_integer (an_id)
		end

	directory_path (an_id: INTEGER): PATH
			-- Server file directory path
		local
			l_precomp_id: INTEGER
			l_dev: DEVELOPER_EXCEPTION
		do
			if an_id > file_counter.precompiled_offset then
				Result := project_location.compilation_path
			else
				l_precomp_id := file_counter.compilation_id (an_id)
				if attached precompilation_directories.item (l_precomp_id) as l_project then
					Result := l_project.compilation_path
				else
					create l_dev
					l_dev.set_description ("Mapping ID(" + an_id.out + ") to precompilation ID(" + l_precomp_id.out + ") not found.")
					l_dev.raise
				end
			end
		ensure
			directory_path_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	file: RAW_FILE
			-- Associated file.

	file_counter: FILE_COUNTER
			-- File counter
		once
			Result := server_controler.file_counter
		end

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class SERVER_FILE
