note
	description: "[
			Simple directory unarchiver that creates a new directory on disk (if it does not exist)
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	DIRECTORY_UNARCHIVER

inherit
	UNARCHIVER
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- Create new instance.
		do
			name := "directory to disk unarchiver"

			Precursor
		end

feature -- Status

	unarchivable (a_header: TAR_HEADER): BOOLEAN
			-- Can the payload that belongs to `a_header' be unarchived using this DIRECTORY_UNARCHIVER?
			-- note: Instances of this class can unarchive every header that belongs to a directory.
		do
			Result := a_header.typeflag = {TAR_CONST}.tar_typeflag_directory
		end

	required_blocks: INTEGER
			-- Number of blocks required to unarchive payload belonging `active_header'.
		do
			--| Result := 0			-- Is automatically initialized to 0
		end

feature -- Output

	unarchive_block (p: MANAGED_POINTER; a_pos: INTEGER)
			-- Unarchive block `p' starting at `a_pos'.
			-- Since directories are header only entries, there is nothing to do.
		do
			--| do_nothing
		end

feature {NONE} -- Implementation

	do_internal_initialization
			-- Setup internal structures after initialize has run.
		local
			l_directory: DIRECTORY
		do
			if attached active_header as l_header then
				if l_header.filename.is_empty then
					create l_directory.make_with_path (create {PATH}.make_current)
				else
					create l_directory.make_with_path (l_header.filename)
				end
				if not l_directory.exists then
					l_directory.recursive_create_dir
				end
				file_set_metadata (create {RAW_FILE} .make_with_path (l_directory.path), l_header)
			end
		end

note
	copyright: "2015-2017, Nicolas Truessel, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
