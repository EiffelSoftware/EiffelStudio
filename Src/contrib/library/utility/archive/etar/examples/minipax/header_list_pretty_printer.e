note
	description: "[
			Prettyprint a list of headers using an ls-like format
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HEADER_LIST_PRETTY_PRINTER

feature -- PP

	pretty_print (a_header_list: LIST [TAR_HEADER]): LIST [READABLE_STRING_GENERAL]
			-- Prettyprint `a_header_list'.
		do
			create {ARRAYED_LIST [READABLE_STRING_GENERAL]} Result.make (a_header_list.count)
			initialize_paddings (a_header_list)
			across
				a_header_list as l_cur
			loop
				Result.force (pretty_print_entry (l_cur.item))
			end
		end

feature {NONE} -- Implementation

	initialize_paddings (a_header_list: LIST [TAR_HEADER])
			-- Initialize all paddings such that `a_header_list' can be pretty-printed.
		do
			user_width := 0
			group_width := 0
			across
				a_header_list as l_cur
			loop
				user_width := user_width.max (l_cur.item.user_name.count)
				group_width := group_width.max (l_cur.item.group_name.count)
			end
		end

	pretty_print_entry (a_header: TAR_HEADER): READABLE_STRING_GENERAL
			-- Prettyprint a single header using the current padding settings.
		do
			Result := typeflag_string (a_header) + permissions_string (a_header) + " "
						+ user_string (a_header) + " " + group_string (a_header) + " "
						+ size_string (a_header) + " " + mtime_string (a_header) + " "
						+ filename_string (a_header)
		end

	typeflag_string (header: TAR_HEADER): READABLE_STRING_GENERAL
			-- Prettyprint `header's typeflag.
		do
			inspect header.typeflag
			when {TAR_CONST}.tar_typeflag_directory then
				Result := ("d")
			when {TAR_CONST}.tar_typeflag_block_special then
				Result := ("b")
			when {TAR_CONST}.tar_typeflag_character_special then
				Result := ("c")
			when {TAR_CONST}.tar_typeflag_fifo then
				Result := ("p")
			when {TAR_CONST}.tar_typeflag_symlink then
				Result := ("l")
			else
				Result := ("-")
			end
		end

	permissions_string (header: TAR_HEADER): READABLE_STRING_GENERAL
			-- Prettyprint `header's permissions/mode.
		do
				-- User
			if header.is_user_readable then
				Result := ("r")
			else
				Result := ("-")
			end
			if header.is_user_writable then
				Result := Result + ("w")
			else
				Result := Result + ("-")
			end
			if header.is_user_executable and header.is_setuid then
				Result := Result + ("s")
			elseif header.is_user_executable and not header.is_setuid then
				Result := Result + ("x")
			elseif not header.is_user_executable and header.is_setuid then
				Result := Result + ("S")
			else
				Result := Result + ("-")
			end

				-- Group
			if header.is_group_readable then
				Result := Result + ("r")
			else
				Result := Result + ("-")
			end
			if header.is_group_writable then
				Result := Result + ("w")
			else
				Result := Result + ("-")
			end
			if header.is_group_executable and header.is_setgid then
				Result := Result + ("s")
			elseif header.is_group_executable and not header.is_setgid then
				Result := Result + ("x")
			elseif not header.is_group_executable and header.is_setgid then
				Result := Result + ("S")
			else
				Result := Result + ("-")
			end

				-- Other
			if header.is_other_readable then
				Result := Result + ("r")
			else
				Result := Result + ("-")
			end
			if header.is_other_writable then
				Result := Result + ("w")
			else
				Result := Result + ("-")
			end
			if header.is_other_executable then
				Result := Result + ("x")
			else
				Result := Result + ("-")
			end
		end

	user_width: INTEGER
			-- Usernames are padded to this length.

	user_string (a_header: TAR_HEADER): READABLE_STRING_GENERAL
			-- Prettyprint `a_header's username if set, uid otherwise.
		local
			l_username: STRING
			l_padding: STRING
		do
			if not a_header.user_name.is_whitespace then
				l_username := a_header.user_name.twin
			else
				l_username := a_header.user_id.out
			end

				-- Pad
			if l_username.count < user_width then
				l_padding := " "
				l_padding.multiply (user_width - l_username.count)
				l_username.prepend (l_padding)
			end
			Result := l_username
		end

	group_width: INTEGER
			-- Groupnames are padded to this length.

	group_string (a_header: TAR_HEADER): READABLE_STRING_GENERAL
			-- Prettyprint `a_header's groupname if set, gid otherwise.
		local
			l_groupname: STRING
			l_padding: STRING
		do
			if not a_header.user_name.is_whitespace then
				l_groupname := a_header.group_name.twin
			else
				l_groupname := a_header.group_id.out
			end

				-- Pad
			if l_groupname.count < group_width then
				l_padding := " "
				l_padding.multiply (group_width - l_groupname.count)
				l_groupname.prepend (l_padding)
			end
			Result := l_groupname
		end


	size_string (a_header: TAR_HEADER): READABLE_STRING_GENERAL
			-- Prettyprint `a_header's size.
		local
			l_size: NATURAL_64
			i: INTEGER
			l_output: STRING
		do
			from
				l_size := a_header.size
				i := 0
			until
				l_size < 1024
			loop
				l_size := (l_size / 1024).rounded.as_natural_64
				i := i + 1
			end
			if l_size >= 1000 then
				l_size := 1
			end

				-- Fix width to 3 characters
			l_output := " "
			l_output.multiply (4 - l_size.out.count)
			l_output.remove (1)
			l_output.append (l_size.out)

				-- Unit
			inspect i
			when 0 then
				l_output.prepend (" ")
			when 1 then
				l_output.append ("K")
			when 2 then
				l_output.append ("M")
			when 3 then
				l_output.append ("G")
			else
				l_output.append ("T")
			end

			Result := l_output
		end

	mtime_string (a_header: TAR_HEADER): READABLE_STRING_GENERAL
			-- Prettyprint `a_header's timestamp.
		local
			l_mtime: DATE_TIME
		do
			create l_mtime.make_from_epoch (a_header.mtime.as_integer_32) -- Will fail in 2038
			Result := l_mtime.formatted_out ("yyyy-[0]mm-[0]dd [0]hh:[0]mi")
		end

	filename_string (a_header: TAR_HEADER): READABLE_STRING_GENERAL
			-- Prettyprint `a_header's filename (including link target).
		do
			Result := a_header.filename.name
			if a_header.typeflag = {TAR_CONST}.tar_typeflag_symlink or a_header.typeflag = {TAR_CONST}.tar_typeflag_hardlink then
				Result := Result + " -> " + a_header.linkname.name
			end
		end

note
	copyright: "2015-2016, Nicolas Truessel, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
