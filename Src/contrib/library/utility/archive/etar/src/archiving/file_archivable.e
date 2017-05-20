note
	description: "[
			ARCHIVABLE wrapper for files
			
			This version only accepts plain files.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	FILE_ARCHIVABLE

inherit
	ARCHIVABLE

create
	make

feature {NONE} -- Initialization

	make (a_file: FILE)
			-- Create a new FILE_ARCHIVABLE for `a_file'.
		require
			file_exists: a_file.exists
			file_is_readable: a_file.is_readable
			file_is_plain: a_file.is_plain
		do
			create {RAW_FILE} file.make_with_path (a_file.path)
			file.open_read
		end

feature -- Status

	required_blocks: INTEGER
			-- How many blocks are required to store this FILE_ARCHIVABLE?
		do
			Result := needed_blocks (file.file_info.size.as_natural_64).as_integer_32
		end

	header: TAR_HEADER
			-- Header belonging to the payload.
		do
			create Result

			Result.set_filename (file.path)
			Result.set_mode (file.protection.as_natural_16)
			Result.set_user_id (file.user_id.as_natural_32)
			Result.set_group_id (file.group_id.as_natural_32)
			Result.set_size (file.file_info.size.as_natural_64)
			Result.set_mtime (file.date.as_natural_64)
			Result.set_typeflag ({TAR_CONST}.tar_typeflag_regular_file)
			Result.set_user_name (file.owner_name)
			Result.set_group_name (file.file_info.group_name)
		end

feature -- Output

	write_block_to_managed_pointer (p: MANAGED_POINTER; a_pos: INTEGER)
			-- Write the next block to `p' starting at `a_pos'.
		do
				-- Write next block
			file.read_to_managed_pointer (p, a_pos, {TAR_CONST}.tar_block_size)
			if file.end_of_file then
					-- Fill with '%U'
				pad_block (p, a_pos + file.bytes_read, {TAR_CONST}.tar_block_size - file.bytes_read)

					-- Close file
				file.close
			end
			written_blocks := written_blocks + 1
		end

feature {NONE} -- Implementation

	file: FILE
			-- The file this ARCHIVABLE represents.

;note
	copyright: "2015-2017, Nicolas Truessel, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
