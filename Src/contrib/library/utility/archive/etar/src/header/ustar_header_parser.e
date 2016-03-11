note
	description: "[
			Header parser for the ustar header format
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Further information about the USTAR format", "src=http://pubs.opengroup.org/onlinepubs/9699919799/utilities/pax.html#tag_20_92_13_06", "tag=ustar"

class
	USTAR_HEADER_PARSER

inherit
	TAR_HEADER_PARSER

	TAR_UTILS
		export
			{NONE} all
		undefine
			default_create
		end

	OCTAL_UTILS
		export
			{NONE} all
		undefine
			default_create
		end

feature -- Parsing

	parse_block (a_block: MANAGED_POINTER; a_pos: INTEGER)
			-- Parse ustar-header in `a_block' starting at position `a_pos'.
		local
			l_field: detachable STRING_8
			l_filename: STRING_8
			l_header: like last_parsed_header
			utf: UTF_CONVERTER
		do
				-- Reset parsing
			parsing_finished := False
			last_parsed_header := Void
			reset_error

				-- Read field from `a_block'.
			if attached a_block.read_array (a_pos, a_block.count - a_pos) as arr then
				create l_field.make (arr.count)
				across
					arr as ic
				loop
					l_field.extend (ic.item.to_character_8)
				end
			end

				-- Parse `a_block'.
			create l_header

				-- parse "filename"
			if not has_error then
				l_filename := next_block_string (a_block, a_pos + {TAR_HEADER_CONST}.name_offset, {TAR_HEADER_CONST}.name_length)
				if l_filename.is_whitespace then
					l_filename := "."
				end
					-- prefix
				l_field := next_block_string (a_block, a_pos + {TAR_HEADER_CONST}.prefix_offset, {TAR_HEADER_CONST}.prefix_length)
				if not l_field.is_whitespace then
					l_filename := l_field + "/" + l_filename
				end
				l_header.set_filename (create {PATH}.make_from_string (utf.utf_8_string_8_to_escaped_string_32 (l_filename)))
			end

				-- parse mode
			if not has_error then
				l_field := next_block_octal_natural_16_string (a_block, a_pos + {TAR_HEADER_CONST}.mode_offset, {TAR_HEADER_CONST}.mode_length)
				if l_field /= Void then
					l_header.set_mode (octal_string_to_natural_16 (l_field))
				else
					report_new_error ("Missing mode")
				end
			end

				-- parse uid
			if not has_error then
				l_field := next_block_octal_natural_32_string (a_block, a_pos + {TAR_HEADER_CONST}.uid_offset, {TAR_HEADER_CONST}.uid_length)
				if l_field /= Void then
					l_header.set_user_id (octal_string_to_natural_32 (l_field))
				else
					report_new_error ("Missing uid")
				end
			end

				-- parse gid
			if not has_error then
				l_field := next_block_octal_natural_32_string (a_block, a_pos + {TAR_HEADER_CONST}.gid_offset, {TAR_HEADER_CONST}.gid_length)
				if l_field /= Void then
					l_header.set_group_id (octal_string_to_natural_32 (l_field))
				else
					report_new_error ("Missing gid")
				end
			end

				-- parse size
			if not has_error then
				l_field := next_block_octal_natural_64_string (a_block, a_pos + {TAR_HEADER_CONST}.size_offset, {TAR_HEADER_CONST}.size_length)
				if l_field /= Void then
					l_header.set_size (octal_string_to_natural_64 (l_field))
				else
					report_new_error ("Missing size")
				end
			end

				-- parse mtime
			if not has_error then
				l_field := next_block_octal_natural_64_string (a_block, a_pos + {TAR_HEADER_CONST}.mtime_offset, {TAR_HEADER_CONST}.mtime_length)
				if l_field /= Void then
					l_header.set_mtime (octal_string_to_natural_64 (l_field))
				else
					report_new_error ("Missing mtime")
				end
			end

				-- verify checksum
			if
				not has_error and then
				not is_checksum_verified (a_block, a_pos)
			then
				report_new_error ("Checksum not verified")
			end

				-- parse typeflag
			if not has_error then
				l_header.set_typeflag (a_block.read_character (a_pos + {TAR_HEADER_CONST}.typeflag_offset))
			end

				-- parse and check magic
			if not has_error then
				l_field := next_block_string (a_block, a_pos + {TAR_HEADER_CONST}.magic_offset, {TAR_HEADER_CONST}.magic_length)
				if l_field /~ {TAR_CONST}.ustar_magic then
					report_new_error ("Missing magic")
				end
			end

				-- parse and check version
			if not has_error then
				l_field := next_block_string (a_block, a_pos + {TAR_HEADER_CONST}.version_offset, {TAR_HEADER_CONST}.version_length)
				if l_field /~ {TAR_CONST}.ustar_version then
					report_new_error ("Missing version")
				end
			end

			if not has_error then
					-- parse uname
				l_field := next_block_string (a_block, a_pos + {TAR_HEADER_CONST}.uname_offset, {TAR_HEADER_CONST}.uname_length)
				if not l_field.is_whitespace then
					l_header.set_user_name (l_field)
				else
--					report_new_error ("Missing uname")		-- optional
				end

					-- parse gname
				l_field := next_block_string (a_block, a_pos + {TAR_HEADER_CONST}.gname_offset, {TAR_HEADER_CONST}.gname_length)
				if not l_field.is_whitespace then
					l_header.set_group_name (l_field)
				else
--					report_new_error ("Missing gname")		-- optional
				end

					-- parse linkname
				l_field := next_block_string (a_block, a_pos + {TAR_HEADER_CONST}.linkname_offset, {TAR_HEADER_CONST}.linkname_length)
				if not l_field.is_whitespace then
					l_header.set_linkname (create {PATH}.make_from_string (utf.utf_8_string_8_to_escaped_string_32 (l_field)))
				else
--					report_new_error ("Missing linkname")		-- linkname only needed if typeflag is {TAR_CONST}.tar_typeflag_symlink, {TAR_CONST}.tar_typeflag_hardling, or custom
				end

					-- parse devmajor
				l_field := next_block_octal_natural_32_string (a_block, a_pos + {TAR_HEADER_CONST}.devmajor_offset, {TAR_HEADER_CONST}.devmajor_length)
				if l_field /= Void then
					l_header.set_device_major (octal_string_to_natural_32 (l_field))
				else
--					report_new_error ("Missing devmajor")		-- only for typeflags of special files (character/block device)
				end

					-- parse devminor
				l_field := next_block_octal_natural_32_string (a_block, a_pos + {TAR_HEADER_CONST}.devminor_offset, {TAR_HEADER_CONST}.devminor_length)
				if l_field /= Void then
					l_header.set_device_minor (octal_string_to_natural_32 (l_field))
				else
--					report_new_error ("Missing devminor")		-- only for typeflags of special files (character/block device)
				end
			end

			if not has_error then
				last_parsed_header := l_header
			else
				last_parsed_header := Void
			end
			parsing_finished := True
		end

feature {NONE} -- Implementation

	next_block_octal_natural_16_string (a_block: MANAGED_POINTER; a_pos, a_length: INTEGER): detachable STRING
			-- Next block octal string in `a_block' at position `a_pos' with at most `a_length' characters.
		do
			Result := next_block_string (a_block, a_pos, a_length)
			Result.adjust
			if not is_octal_natural_16_string (Result) then
				Result := Void
			end
		ensure
			is_octal_natural_16_string: Result /= Void implies is_octal_natural_16_string (Result)
		end

	next_block_octal_natural_32_string (a_block: MANAGED_POINTER; a_pos, a_length: INTEGER): detachable STRING
			-- Next block octal string in `a_block' at position `a_pos' with at most `a_length' characters.
		do
			Result := next_block_string (a_block, a_pos, a_length)
			Result.adjust
			if not is_octal_natural_32_string (Result) then
				Result := Void
			end
		ensure
			is_octal_natural_32_string: Result /= Void implies is_octal_natural_32_string (Result)
		end

	next_block_octal_natural_64_string (a_block: MANAGED_POINTER; a_pos, a_length: INTEGER): detachable STRING
			-- Next block octal string in `a_block' at position `a_pos' with at most `a_length' characters.
		do
			Result := next_block_string (a_block, a_pos, a_length)
			Result.adjust
			if not is_octal_natural_64_string (Result) then
				Result := Void
			end
		ensure
			is_octal_natural_64_string: Result /= Void implies is_octal_natural_64_string (Result)
		end

	is_checksum_verified (a_block: MANAGED_POINTER; a_pos: INTEGER): BOOLEAN
			-- Does the calculated checksum of `a_block' (block starting at `a_pos') match the value of the checksum field?
		do
				--| Parse checksum
			Result := attached next_block_octal_natural_64_string (a_block, a_pos + {TAR_HEADER_CONST}.chksum_offset, {TAR_HEADER_CONST}.chksum_length) as checksum_string and then
					octal_string_to_natural_64 (checksum_string) = checksum (a_block, a_pos)
		end
note
	copyright: "2015-2016, Nicolas Truessel, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
