note
	description: "[
			Header writer for the ustar format

			Everything that is too large will be truncated
		]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Further information about the USTAR format", "src=http://pubs.opengroup.org/onlinepubs/9699919799/utilities/pax.html#tag_20_92_13_06", "tag=ustar"

class
	USTAR_HEADER_WRITER

inherit
	TAR_HEADER_WRITER

	TAR_UTILS
		export
			{NONE} all
		end

	OCTAL_UTILS
		export
			{NONE} all
		end

feature -- Status

	required_blocks: INTEGER
			-- How many blocks are required to store `active_header'?
		once
			Result := 1
		end

	writable (a_header: TAR_HEADER): BOOLEAN
			-- Can `a_header' be written?
		do
			Result := filename_fits (a_header) and
						user_id_fits (a_header) and
						group_id_fits (a_header) and
						size_fits (a_header) and
						linkname_fits (a_header) and
						user_name_fits (a_header) and
						group_name_fits (a_header)
		end

feature -- Output

	write_block_to_managed_pointer (p: MANAGED_POINTER; a_pos: INTEGER)
			-- Write next block to `p' starting at `a_pos'.
		local
			l_split_filename: TUPLE [filename_prefix: STRING_8; filename: STRING_8]
		do
			if attached active_header as header then
					-- Fill with all '%U'
				p.put_special_character_8 (
						create {SPECIAL [CHARACTER_8]}.make_filled ('%U', {TAR_CONST}.tar_block_size),
						0, a_pos, {TAR_CONST}.tar_block_size)

				l_split_filename := unify_and_split_filename (header.filename)

					-- Put filename
				put_string (l_split_filename.filename,
						p, a_pos + {TAR_HEADER_CONST}.name_offset);

					-- Put prefix
				put_string (l_split_filename.filename_prefix,
						p, a_pos + {TAR_HEADER_CONST}.prefix_offset);

					-- Put mode
					-- MASK ISVTX flag: tar does not support it (reserved)
				put_natural (header.mode & 0c6777,
						{TAR_HEADER_CONST}.mode_length,
						p, a_pos + {TAR_HEADER_CONST}.mode_offset)

					-- Put userid
				put_natural (header.user_id,
						{TAR_HEADER_CONST}.uid_length,
						p, a_pos + {TAR_HEADER_CONST}.uid_offset)

					-- Put groupid
				put_natural (header.group_id,
						{TAR_HEADER_CONST}.gid_length,
						p, a_pos + {TAR_HEADER_CONST}.gid_offset)

					-- Put size
				put_natural (header.size,
						{TAR_HEADER_CONST}.size_length,
						p, a_pos + {TAR_HEADER_CONST}.size_offset)

					-- Put mtime
				put_natural (header.mtime,
						{TAR_HEADER_CONST}.mtime_length,
						p, a_pos + {TAR_HEADER_CONST}.mtime_offset)

					-- Put typeflag
				p.put_character (header.typeflag,
						a_pos + {TAR_HEADER_CONST}.typeflag_offset)

					-- Put linkname
				put_string (unify_utf_8_path (header.linkname),
						p, a_pos + {TAR_HEADER_CONST}.linkname_offset)

					-- Put magic
				put_string ({TAR_CONST}.ustar_magic, p, a_pos + {TAR_HEADER_CONST}.magic_offset)

					-- Put version
				put_string ({TAR_CONST}.ustar_version, p, a_pos + {TAR_HEADER_CONST}.version_offset)

					-- Put username
				put_string (header.user_name.as_string_8,				-- No conversion problem, since user_name is IMMUTABLE_STRING_8.
						p, a_pos + {TAR_HEADER_CONST}.uname_offset)

					-- Put groupname
				put_string (header.group_name.as_string_8,				-- No conversion problem, since group_name is IMMUTABLE_STRING_8.
						p, a_pos + {TAR_HEADER_CONST}.gname_offset)

					-- Put devmajor
				put_natural (header.device_major,
						{TAR_HEADER_CONST}.devmajor_length,
						p, a_pos + {TAR_HEADER_CONST}.devmajor_offset)

					-- Put devminor
				put_natural (header.device_minor,
						{TAR_HEADER_CONST}.devminor_length,
						p, a_pos + {TAR_HEADER_CONST}.devminor_offset)

					-- Put checksum
				put_natural (checksum (p, a_pos),
						{TAR_HEADER_CONST}.chksum_length,
						p, a_pos + {TAR_HEADER_CONST}.chksum_offset)
			else
				check false end -- Unreachable (see precondition)
			end
			written_blocks := written_blocks + 1
		end

feature -- Fitting

	filename_fits (a_header: TAR_HEADER): BOOLEAN
			-- Does `a_header.filename' fit in a ustar header?
		local
			l_split_filename: TUPLE [filename_prefix: STRING_8; filename: STRING_8]
		do
				-- No need for terminating '%U'
			l_split_filename := unify_and_split_filename (a_header.filename)
			Result := l_split_filename.filename_prefix.count <= {TAR_HEADER_CONST}.prefix_length and (l_split_filename.filename.is_empty implies l_split_filename.filename_prefix.is_empty)
		end

	user_id_fits (a_header: TAR_HEADER): BOOLEAN
			-- Does `a_header.user_id' fit in a ustar header?
		do
				-- Strictly less: terminating '%U'
			Result := natural_32_to_octal_string (a_header.user_id).count < {TAR_HEADER_CONST}.uid_length
		end

	group_id_fits (a_header: TAR_HEADER): BOOLEAN
			-- Does `a_header.group_id' fit in a ustar header?
		do
				-- Strictly less: terminating '%U'
			Result := natural_32_to_octal_string (a_header.group_id).count < {TAR_HEADER_CONST}.gid_length
		end

	size_fits (a_header: TAR_HEADER): BOOLEAN
			-- Does `a_header.size' fit in a ustar header?
		do
				-- Strictly less: terminating '%U'
			Result := natural_64_to_octal_string (a_header.size).count < {TAR_HEADER_CONST}.size_length
		end

	mtime_fits (a_header: TAR_HEADER): BOOLEAN
			-- Does `a_header.mtime' fit in a ustar header?
		do
				-- Strictly less: terminating '%U'
			Result := natural_64_to_octal_string (a_header.mtime).count < {TAR_HEADER_CONST}.mtime_length
		end

	linkname_fits (a_header: TAR_HEADER): BOOLEAN
			-- Does `a_header.linkname' fit in a ustar header?
		do
				-- No need for terminating '%U'
			Result := unify_utf_8_path (a_header.linkname).count <= {TAR_HEADER_CONST}.linkname_length
		end

	user_name_fits (a_header: TAR_HEADER): BOOLEAN
			-- Does `a_header.user_name' fit in a ustar header?
		do
				-- No need for terminating '%U'
			Result := a_header.user_name.count <= {TAR_HEADER_CONST}.uname_length
		end

	group_name_fits (a_header: TAR_HEADER): BOOLEAN
			-- Does `a_header.group_name' fit in a ustar header?
		do
				-- No need for terminating '%U'
			Result := a_header.group_name.count <= {TAR_HEADER_CONST}.gname_length
		end

feature {NONE} -- Utilities

	prepare_header
			-- Prepare `active_header' after it was set.
		do
			-- do_nothing
		end

	put_string (s: STRING_8; p: MANAGED_POINTER; a_pos: INTEGER)
			-- Write `s' to `p' at `a_pos'.
		do
			p.put_special_character_8 (s.area, 0, a_pos, s.count)
		end

	put_natural (n: NATURAL_64; a_length: INTEGER; p: MANAGED_POINTER; a_pos: INTEGER)
			-- Write the octal representation of `n' padded to `a_length' - 1 to `p' at `a_pos'
			-- `a_length' - 1 because tar requires a terminating '%U' for numeric values.
		local
			s: STRING_8
		do
			s := natural_64_to_octal_string (n)
			pad (s, a_length - s.count - 1)
			p.put_special_character_8 (s.area, 0, a_pos, s.count)
		end

note
	copyright: "2015-2016, Nicolas Truessel, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
