note
	description: "[
			UNARCHIVER that generates a ls styled string for the current header
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HEADER_PRINT_UNARCHIVER

inherit
	SKIP_UNARCHIVER
		redefine
			default_create,
			do_internal_initialization
		end

feature {NONE} -- Initialization

	default_create
			-- Create new instance.
		do
			last_header_string := ""

			Precursor
		end

feature -- Access

	last_header_string: READABLE_STRING_GENERAL
			-- ls style string to last header.

feature {NONE} -- Implementation

	do_internal_initialization
			-- Internal initialization after initialize was called.
		do
			if attached active_header as l_header then
				last_header_string := typeflag_string (l_header) +
										permissions_string (l_header) + " " +
										user_string (l_header) + " " +
										group_string (l_header) + " " +
										size_string (l_header) + " " +
										mtime_string (l_header) + " " +
										l_header.filename.name
			end
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

	user_width_memo: INTEGER
			-- Stores the length of the longest username printed so far.

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
			if l_username.count < user_width_memo then
				l_padding := " "
				l_padding.multiply (user_width_memo - l_username.count)
				l_username.prepend (l_padding)
			end
			Result := l_username
			user_width_memo := l_username.count
		end

	group_width_memo: INTEGER
			-- Stores the length of the longest groupname printed so far.

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
			if l_groupname.count < group_width_memo then
				l_padding := " "
				l_padding.multiply (group_width_memo - l_groupname.count)
				l_groupname.prepend (l_padding)
			end
			Result := l_groupname
			group_width_memo := l_groupname.count
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

note
	copyright: "2015-2016, Nicolas Truessel, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
