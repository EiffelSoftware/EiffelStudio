note
	description: "[
			Simple file unarchiver that creates a new file on disk or overwrites an existing file.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	FILE_UNARCHIVER

inherit
	UNARCHIVER
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- Create new instance.
		do
			name := "file to disk unarchiver"

			Precursor
		end

feature -- Status

	unarchivable (a_header: TAR_HEADER): BOOLEAN
			-- Can the payload that belongs to `a_header' be unarchived using this FILE_UNARCHIVER?
			-- note: Instances of this class can unarchive every header belonging to a basic file.
		do
			Result :=  a_header.typeflag = {TAR_CONST}.tar_typeflag_regular_file
					or a_header.typeflag = {TAR_CONST}.tar_typeflag_regular_file_old
		end

	required_blocks: INTEGER
			-- Number of blocks required to unarchive the payload that belongs to `active_header'.
		do
			if attached active_header as l_header then
				Result := needed_blocks (l_header.size).as_integer_32
			else
				-- Unreachable (precondition)
			end
		end

feature -- Output

	unarchive_block (p: MANAGED_POINTER; a_pos: INTEGER)
			-- Unarchive block `p' starting at `a_pos'.
		local
			remaining_bytes: NATURAL_64
		do
			if not skip then
				if attached active_file as l_file and attached active_header as l_header then
					-- Check whether this is the last block
					remaining_bytes := l_header.size - (unarchived_blocks * {TAR_CONST}.tar_block_size).as_natural_64
					if remaining_bytes <= {TAR_CONST}.tar_block_size.as_natural_64 then
							-- Last block
						l_file.put_managed_pointer (p, a_pos, remaining_bytes.as_integer_32)

							-- finalize
						l_file.flush
						l_file.close

						file_set_metadata (l_file, l_header)
					else
							-- Standard block
						l_file.put_managed_pointer (p, a_pos, {TAR_CONST}.tar_block_size)
					end
				else
					check False end -- Unreachable (invariant)
				end
			else
					-- silently ignore
			end
			unarchived_blocks := unarchived_blocks + 1
		end

feature {NONE} -- Implementation

	do_internal_initialization
			-- Setup internal structures after initialize has run.
		local
			l_file: FILE
		do
			skip := False
			if attached active_header as l_header then
				if l_header.filename.is_empty then
					report_new_error ("Can't unarchive file to current working directory")
				else
					create {RAW_FILE} l_file.make_with_path (l_header.filename)
					if l_file.exists then
						file_safe_delete (l_file)
					end

					if l_file.exists then
						skip := True
					else
						l_file.open_write
						active_file := l_file
					end
				end
			else
				check false end -- Unreachable, when do_internal_initialization is called, active_header references an attached TAR_HEADER object
			end
		end

	active_file: detachable FILE
			-- File that is currently unarchived.

	skip: BOOLEAN
			-- skip payload?

	file_safe_delete (a_file: FILE)
			-- Safe delete file (or ignore).
		local
			l_failed: BOOLEAN
		do
			if a_file.path_exists and not l_failed then
				a_file.delete
			end
		rescue
			l_failed := True
			retry
		end

invariant
	header_and_file: (attached active_header = attached active_file) or skip

note
	copyright: "2015-2016, Nicolas Truessel, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
