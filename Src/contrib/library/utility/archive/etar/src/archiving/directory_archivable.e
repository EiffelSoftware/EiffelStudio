note
	description: "[
			ARCHIVABLE wrapper for DIRECTORY
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	DIRECTORY_ARCHIVABLE

inherit
	ARCHIVABLE

create
	make

feature {NONE} -- Initialization

	make (a_directory: FILE)
			-- Create new DIRECTORY_ARCHIVABLE for `a_directory'.
		require
			directory_exists: a_directory.exists
			is_directory: a_directory.is_directory
		do
			create {RAW_FILE} directory.make_with_path (a_directory.path)
		end

feature -- Status

	required_blocks: INTEGER
			-- How many blocks are required to store this DIRECTORY_ARCHIVABLE?
		do
			Result := 0
		end

	header: TAR_HEADER
			-- Header that belongs to the payload.
		local
			f: like directory
		do
			f := directory

			create Result
			Result.set_filename (f.path)
			Result.set_typeflag ({TAR_CONST}.tar_typeflag_directory)
			Result.set_mode (f.protection.to_natural_16)
			Result.set_user_id (f.user_id.to_natural_32)
			Result.set_group_id (f.group_id.to_natural_32)
			Result.set_mtime (f.date.to_natural_64)
			Result.set_user_name (f.owner_name)
			Result.set_group_name (f.file_info.group_name)
		end

feature -- Output

	write_block_to_managed_pointer (p: MANAGED_POINTER; a_pos: INTEGER)
			-- Write the next block to `p', starting at `a_pos'.
		do
			-- do_nothing (impossible to call)
		end

feature {NONE} -- Implementation

	directory: FILE
			-- The directory this instance represents/wraps.
			-- To get directory metadata, use the FILE interface (the interface {DIRECTORY} is mostly used to get child information).

invariant
	no_payload: required_blocks = 0

note
	copyright: "2015-2016, Nicolas Truessel, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
