indexing
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

	DISPOSABLE

create
	make

feature -- Initialization

	make (i: INTEGER) is
			-- Initialization
		require
			positive_argument: i /= 0
		local
			f_name: FILE_NAME
			d_name: DIRECTORY_NAME
			temp: STRING
			d: DIRECTORY
		do
			create d_name.make_from_string (Compilation_path)
			create temp.make (5)
			temp.extend ('S')
			temp.append_integer (packet_number (i))
			d_name.extend (temp)
			create d.make (d_name)
			if not d.exists then
				d.create_dir
			end
			create f_name.make_from_string (d_name)
			f_name.set_file_name (file_name (i))
			file_make (f_name)
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

feature -- Initialization

	file_make (fn: STRING) is
			-- Create file object with `fn' as file name.
		require
			string_exists: fn /= Void
			string_not_empty: not fn.is_empty
		do
			name := fn
		ensure
			file_named: name.is_equal (fn)
			file_closed: not is_open
		end

feature -- Access

	name: STRING
			-- File name

	file_pointer: POINTER
			-- File pointer as required in C

	occurrence: INTEGER
			-- Occurrence of the file in the server control

	is_open: BOOLEAN
			-- Is the current file open ?

	descriptor: INTEGER is
			-- File descriptor as used by the operating system.
		require
			file_opened: is_open
		do
			Result := file_fd (file_pointer)
		end

	add_occurrence is
			-- Add one occurrence.
		do
			occurrence := occurrence + 1
		end

	remove_occurrence is
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
		
	open is
			-- Open file in read mode if precompiled
			-- in read-write otherwise.
		require
			is_closed: not is_open
		local
			external_name: ANY
		do
			external_name := name.to_c
			if Eiffel_project.is_read_only or else precompiled then
					-- Open the file in `Read' mode only.
				file_pointer := file_open ($external_name, 0)
			else
					-- Open the file in `Read-Write' mode.
				file_pointer := file_open ($external_name, 3)
			end
			is_open := True
debug ("SERVER")
	io.error.put_string ("Opening file ")
	io.error.put_string (file_name (file_id))
	io.error.put_new_line
end
		ensure
			opened: is_open
		end

	server_open_write is
			-- Open file in append mode only for doing `store_append' in
			-- COMPILER_SERVER
		require
			is_closed: not is_open
		local
			external_name: ANY
		do
			external_name := name.to_c
			file_pointer := file_open ($external_name, 5)
			is_open := True
		ensure
			opened: is_open
		end

	last_offset: INTEGER is
			-- Return the size of the file without checking it exists.
		require
			file_exists: is_open or else exists
		do
			if not is_open then
				set_buffer
				Result := buffered_file_info.size
			else
				Result := file_size (file_pointer)
			end
		end

	close is
			-- Close server file
		require
			is_open: is_open
		do
			file_close (file_pointer)
			file_pointer := default_pointer
			is_open := False
		ensure
			is_closed: not is_open
		end

	clear_content is
			-- Clear the content of a file by opening it
			-- in write-only mode and closing it.
		local
			external_name: ANY
		do
			external_name := name.to_c
			file_pointer := file_open ($external_name, 1)
			is_open := True
			close
		end

	update_path is
			-- Update the file path of Current 
			-- server file. (It might have changed 
			-- between compilations)
		local
			fname: FILE_NAME
			temp: STRING
		do
			create fname.make_from_string (directory_path (file_id))
			create temp.make (5)
			temp.extend ('S')
			temp.append_integer (packet_number (file_id))
			fname.extend (temp)
			fname.set_file_name (file_name (file_id))
			name := fname
		end

feature -- Status report

	exists: BOOLEAN is
			-- Does physical file exist?
			-- (Uses effective UID.)
		local
			external_name: ANY
		do
			external_name := name.to_c
			Result := file_exists ($external_name)
		end

	is_readable: BOOLEAN is
			-- Is file readable?
			-- (Checks permission for effective UID.)
		do
			set_buffer
			Result := buffered_file_info.is_readable
		end

	is_writable: BOOLEAN is
			-- Is file writable?
			-- (Checks write permission for effective UID.)
		do
			set_buffer
			Result := buffered_file_info.is_writable
		end

	is_readable_and_writable: BOOLEAN is
			-- Is file readable?
			-- (Checks permission for effective UID.)
		do
			set_buffer
			Result := buffered_file_info.is_readable and buffered_file_info.is_writable
		end

	precompiled: BOOLEAN is
			-- Does the Current server file contain
			-- precompiled information?
		do
			Result := file_counter.is_precompiled (file_id)
		end

feature -- Removal

	delete is
			-- Remove link with physical file.
			-- File does not physically disappear from the disk
			-- until no more processes reference it.
			-- I/O operations on it are still possible.
			-- A directory must be empty to be deleted.
		require
			exists: exists
		local
			external_name: ANY
			retried: BOOLEAN
		do
			if not retried then
				external_name := name.to_c
				file_unlink ($external_name)
			end
		rescue
			retried := True
			retry
		end

feature -- Disposal

	dispose is
			-- Close file if not yet closed
		do
			if file_pointer /= default_pointer then
				close
			end
		ensure then
			file_pointer_set: file_pointer = default_pointer
			not_is_open: not is_open
		end

feature {SERVER_CONTROL, SERVER_FILE} -- File access

	packet_number (an_id: INTEGER): INTEGER is
			-- Packet in which the file will be stored (100 is the default_size)
		do
			Result := (an_id // 100) + 1
		end

	file_name (an_id: INTEGER): STRING is
			-- Server file basename
		do
			create Result.make (7)
			Result.extend ('E')
			Result.append_integer (an_id)
		end

	directory_path (an_id: INTEGER): STRING is
			-- Server file directory path
		do
			if an_id > file_counter.precompiled_offset then
				Result := Compilation_path
			else
				Result := Precompilation_directories.item
						(file_counter.compilation_id (an_id)).compilation_path
			end
		end

feature {NONE} -- Implementation

	file_counter: FILE_COUNTER is
			-- File counter
		once
			Result := server_controler.file_counter
		end

	buffered_file_info: UNIX_FILE_INFO is
			-- Information about the file.
		once
			create Result.make
		end

	set_buffer is
			-- Resynchronizes information on file
		require
			file_exists: exists
		do
			buffered_file_info.update (name)
		end

	file_open (f_name: POINTER; how: INTEGER): POINTER is
			-- File pointer for file `f_name', in mode `how'.
		external
			"C use %"eif_file.h%""
		alias
			"file_binary_open"
		end

	file_close (file: POINTER) is
			-- Close `file'.
		external
			"C signature (FILE *) use %"eif_file.h%""
		end

	file_unlink (fname: POINTER) is
			-- Delete file `fname'.
		external
			"C use %"eif_file.h%""
		end

	file_fd (file: POINTER): INTEGER is
			-- Operating system's file descriptor
		external
			"C signature (FILE *): EIF_INTEGER use %"eif_file.h%""
		end

	file_exists (f_name: POINTER): BOOLEAN is
			-- Does `f_name' exist.
		external
			"C use %"eif_file.h%""
		end

	file_size (file: POINTER): INTEGER is
			-- Size of `file'
		external
			"C signature (FILE *): EIF_INTEGER use %"eif_file.h%""
		alias
			"eif_file_size"
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

end -- class SERVER_FILE
