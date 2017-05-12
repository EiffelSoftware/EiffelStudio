note
	description: "Utility functions for tar archives."
	date: "$Date$"
	revision: "$Revision$"

class
	TAR_UTILS

feature -- Bytes to Blocks

	needed_blocks (n: NATURAL_64): NATURAL_64
			-- Number of blocks needed to store `n' bytes.
		do
			Result := (n + {TAR_CONST}.tar_block_size.as_natural_64 - 1) // {TAR_CONST}.tar_block_size.as_natural_64
		ensure
			bytes_fit: n <= Result * {TAR_CONST}.tar_block_size.as_natural_64
			smallest_fit: Result * {TAR_CONST}.tar_block_size.as_natural_64 < n + {TAR_CONST}.tar_block_size.as_natural_64
		end

feature -- Block Padding

	pad_block (p: MANAGED_POINTER; a_pos, n: INTEGER)
			-- pad `p' with `n' NUL-bytes starting at `a_pos'.
		require
			non_negative_position: a_pos >= 0
			non_negative_length: n >= 0
			enough_space: p.count >= a_pos + n
		do
			if n > 0 then
				p.put_special_character_8 (create {SPECIAL [CHARACTER_8]}.make_filled ('%U', n), 0, a_pos, n)
			end
		end

feature -- Header Checksum

	checksum (block: MANAGED_POINTER; a_pos: INTEGER): NATURAL_64
			-- Calcualte checksum of `block' (starting at `a_pos').
		require
			non_negative_pos: a_pos >= 0
			enough_space: block.count >= a_pos + {TAR_CONST}.tar_block_size
		local
			i: INTEGER
			l_space_code: NATURAL_8
			l_lower, l_upper: INTEGER
		do
				-- Sum all bytes
			l_space_code := (' ').natural_32_code.as_natural_8
			l_lower := {TAR_HEADER_CONST}.chksum_offset
			l_upper := l_lower + {TAR_HEADER_CONST}.chksum_length
			from
				i := 0
				Result := 0
			until
				i >= {TAR_CONST}.tar_block_size
			loop
				if
					i < l_lower or l_upper <= i
				then
					Result := Result + block.read_natural_8 (a_pos + i)
				else
					Result := Result + l_space_code
				end
				i := i + 1
			end
		end

feature -- Metadata manipulation

	file_set_metadata (a_file: FILE; a_header: TAR_HEADER)
			-- Set all of `a_file's metadata according to `a_header'.
		require
			file_exists: a_file.exists
		do
			file_set_mode (a_file, a_header.mode.as_integer_32)
			file_set_mtime (a_file, a_header.mtime.as_integer_32)

			if file_owner (a_header.user_id.as_integer_32) ~ a_header.user_name then
				file_set_uid (a_file, a_header.user_id.as_integer_32)
			end

			if file_group (a_header.group_id.as_integer_32) ~ a_header.group_name then
				file_set_gid (a_file, a_header.group_id.as_integer_32)
			end

		end

	file_set_mode (a_file: FILE; a_mode: INTEGER)
			-- Set `a_file's permissions ot `a_mode' or silently exit on error.
		require
			file_exists: a_file.exists
		local
			l_failed: BOOLEAN
		do
			if not l_failed then
				a_file.change_mode (a_mode)
			end
		rescue
			l_failed := true
			retry
		end

	file_set_mtime (a_file: FILE; a_mtime: INTEGER)
			-- Set `a_file's mtime to `a_mtime' or silently exit on error.
		require
			file_exists: a_file.exists
		local
			l_failed: BOOLEAN
		do
			if not l_failed then
				a_file.set_date (a_mtime)
			end
		rescue
			l_failed := true
			retry
		end

	file_set_uid (a_file: FILE; a_uid: INTEGER)
			-- Set `a_file's uid to `a_uid' or silently exit on error.
		require
			file_exists: a_file.exists
		local
			l_failed: BOOLEAN
		do
			if not l_failed then
				a_file.change_owner (a_uid)
			end
		rescue
			l_failed := true
			retry
		end

	file_set_gid (a_file: FILE; a_gid: INTEGER)
			-- Set `a_file's gid to `a_gid' or silently exit on error.
		require
			file_exists: a_file.exists
		local
			l_failed: BOOLEAN
		do
			if not l_failed then
				a_file.change_group (a_gid)
			end
		rescue
			l_failed := true
			retry
		end

feature -- Filename normalization

	unify_utf_8_path (a_path: PATH): STRING_8
			-- Turns `a_path' into a UTF-8 string using unix directory separators.
		do
			create Result.make (a_path.utf_8_name.count)
			across
				a_path.components as ic
			loop
				if not Result.is_empty and Result /~ "/" then
					Result.append_character ('/')
				end
				if Result.is_empty and ic.item.utf_8_name ~ "\" then
					Result.append ("/")						-- Workaround for windows root '\'
				else
					Result.append (ic.item.utf_8_name)
				end
			end
		end

	unify_and_split_filename (a_path: PATH): TUPLE [filename_prefix: STRING_8; filename: STRING_8]
			-- Split `a_path' into filename and prefix, such that prefix + '/' + filename equals the UTF-8
			-- representation of `a_path' using unix directory separator.
		local
			l_filename: STRING_8
			l_filename_prefix: STRING_8
			l_split_index: INTEGER
		do
			l_filename := unify_utf_8_path (a_path)
			l_filename_prefix := ""

			if l_filename.count > {TAR_HEADER_CONST}.name_length then
				l_split_index := l_filename.index_of ('/', l_filename.count - {TAR_HEADER_CONST}.name_length)
				if l_split_index = 1 then
					l_split_index := l_filename.index_of ('/', 2)
				end
				if l_split_index = 0 then
					l_filename_prefix := l_filename;
					l_filename := ""
				else
					l_filename_prefix := l_filename.substring (1, l_split_index - 1)
					l_filename := l_filename.substring (l_split_index +1 , l_filename.count)
				end
			end

			Result := [l_filename_prefix, l_filename]
		ensure
			correct_length: Result.filename.count <= {TAR_HEADER_CONST}.name_length
			correct_result_without_prefix: Result.filename_prefix.is_empty implies (Result.filename ~ unify_utf_8_path (a_path))
			correct_result_with_prefix: (not Result.filename_prefix.is_empty and not Result.filename.is_empty) implies (Result.filename_prefix + "/" + Result.filename ~ unify_utf_8_path (a_path))
			correct_result_with_prefix_without_filename: (not Result.filename_prefix.is_empty and Result.filename.is_empty) implies (Result.filename_prefix ~ unify_utf_8_path (a_path))
		end

feature {NONE} -- Utilities stolen from file_info

	file_owner (uid: INTEGER): STRING
			-- Convert UID to login name if possible.
		external
			"C signature (int): EIF_REFERENCE use %"eif_file.h%""
		alias
			"eif_file_owner"
		end

	file_group (gid: INTEGER): STRING
			-- Convert GID to group name if possible.
		external
			"C signature (int): EIF_REFERENCE use %"eif_file.h%""
		alias
			"eif_file_group"
		end

note
	copyright: "2015-2017, Nicolas Truessel, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
