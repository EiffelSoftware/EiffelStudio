note
	description: "Storage backends for files."
	date: "$Date$"
	revision: "$Revision$"

class
	FILE_STORAGE_BACKEND

inherit
	STORAGE_BACKEND
		redefine
			default_create
		end

create
	make_from_file,
	make_from_path,
	make_from_filename

feature {NONE} -- Initialization

	default_create
			-- Used to initialize internal status.
		do
			create block_buffer.make ({TAR_CONST}.tar_block_size)
			create {ARRAYED_CIRCULAR [MANAGED_POINTER]} buffer.make (2)

			Precursor
		end

	make_from_file (a_file: FILE)
			-- Create new instance for `a_file'.
			-- note: a clone of `a_file' is created to prevent interference with client-side changes.
		do
			make_from_path (a_file.path)
		end

	make_from_filename (a_filename: READABLE_STRING_GENERAL)
			-- Create new instance for `a_filename'.
		do
			create {RAW_FILE} backend.make_with_name (a_filename)
			default_create
		ensure
			backend_closed: backend.is_closed
		end

	make_from_path (a_path: PATH)
			-- Create new instance for `a_path'.
		do
			create {RAW_FILE} backend.make_with_path (a_path)
			default_create
		ensure
			backend_closed: backend.is_closed
		end

feature -- Status setting

	open_read
			-- Open for reading.
		do
			if not has_error then
				if backend.exists then
					if backend.is_access_readable then
						backend.open_read
					else
						report_new_error ("File is not readable!")
					end
				else
					report_new_error ("File does not exist!")
				end
			end
		end

	open_write
			-- Open for writing.
		local
			retried: BOOLEAN
		do
			if not retried then
				if backend.exists then
					if backend.is_writable then
						backend.open_write
					else
						report_new_error ("File is not writable!")
					end
				else
					backend.open_write
				end
			end
		rescue
			report_new_error ("Error occurred!")
			retried := True
			retry
		end

	close
			-- Close backend.
		do
			if not backend.is_closed then
				backend.flush
				backend.close
			end
		end

feature -- Status

	archive_finished: BOOLEAN
			-- Do the next two blocks contain only NUL bytes or file has not enough characters to read?
		do
			Result := backend.is_closed
			if not Result then
				from
				until
					buffer.count >= 2 or has_error
				loop
					read_block_to_buffer
				end
			end

			Result := has_error or else (only_nul_bytes (buffer.at (1)) and only_nul_bytes (buffer.at (2)))
		end

	block_ready: BOOLEAN
			-- Is there a block ready to read with last_block?
		do
			Result := not has_error and then has_valid_block
		end

	readable: BOOLEAN
			-- Is Current open and readable?
		do
			Result := not has_error and then backend.is_open_read
		end

	writable: BOOLEAN
			-- Is Current created and writable?
		do
			Result := not has_error and then backend.is_open_write
		end

	closed: BOOLEAN
			-- Is Current closed?
		do
			Result := backend.is_closed
		end

feature -- Reading

	last_block: MANAGED_POINTER
			-- Return last block that was read.
		do
			Result := block_buffer
		end

	read_block
			-- Read next block.
		do
			if not buffer.is_empty then
					-- There are buffered items, use them
				block_buffer := buffer.item
				buffer.remove

				has_valid_block := True
			else
				read_block_to_managed_pointer (block_buffer, 0)
				has_valid_block := not has_error
			end
		end

feature -- Writing

	write_block (a_block: MANAGED_POINTER; a_pos: INTEGER)
			-- Write `a_block', starting from `a_pos'.
		do
			backend.put_managed_pointer (a_block, a_pos, a_block.count)
		end

	finalize
			-- Finalize archive (write two 0 blocks).
		local
			l_block: MANAGED_POINTER
			l_template: STRING_8
		do
			l_template := "%U"
			l_template.multiply ({TAR_CONST}.tar_block_size)
			create l_block.make_from_pointer (l_template.area.base_address, {TAR_CONST}.tar_block_size)
			write_block (l_block, 0)
			write_block (l_block, 0)
			backend.flush
			close
		end

feature {NONE} -- Implementation

	backend: FILE
			-- file backend.

	buffer: DYNAMIC_CIRCULAR [MANAGED_POINTER]
			-- buffers blocks that were read ahead.

	block_buffer: MANAGED_POINTER
			-- buffer to use for next read operation.

	has_valid_block: BOOLEAN
			-- Boolean flag for `block_ready'.

	read_block_to_buffer
			-- Read block and add it to the buffer.
		local
			l_buffer: MANAGED_POINTER
		do
			create l_buffer.make (block_buffer.count)
			read_block_to_managed_pointer (l_buffer, 0)
			if not has_error then
				buffer.force (l_buffer)
			end
		ensure
			error_or_one_more_entry: has_error or else buffer.count = old buffer.count + 1
		end

	only_nul_bytes (a_block: MANAGED_POINTER): BOOLEAN
			-- Does `a_block' contain only NUL bytes?
		do
			Result := a_block.read_special_character_8 (0, a_block.count).for_all_in_bounds (
				agent (c: CHARACTER_8): BOOLEAN
					do
						Result := c = '%U'
					end, 0, a_block.count - 1)
		end

	read_block_to_managed_pointer (p: MANAGED_POINTER; a_pos: INTEGER)
			-- Read block from backend to `p' (starting at `a_pos').
		require
			non_negative_pos: a_pos >= 0
			enough_space: p.count >= a_pos + {TAR_CONST}.tar_block_size
		do
			if backend.file_readable then
				backend.read_to_managed_pointer (p, a_pos, {TAR_CONST}.tar_block_size)
				if backend.bytes_read /= {TAR_CONST}.tar_block_size then
					report_new_error ("Not enough bytes to read full block")
					close
				end
			else
				report_new_error ("No more bytes available to read")
				close
			end
		end

invariant
	buffer_size: block_buffer.count = {TAR_CONST}.tar_block_size
	buffer_entries_size: across buffer as ic all ic.item.count = {TAR_CONST}.tar_block_size end

note
	copyright: "2015-2017, Nicolas Truessel, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
