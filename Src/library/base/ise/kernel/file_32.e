note
	description: "Same as {FILE} with names in {STRING_32}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	FILE_32

inherit
	FILE
		rename
			change_name as change_name_8,
			make as make_8,
			name as name_8,
			reset as reset_8
		export
			{NONE} all
			{ANY}
				close,
				count,
				date,
				deep_twin,
				descriptor,
				descriptor_available,
				end_of_file,
				extendible,
				go,
				is_closed,
				is_deep_equal,
				is_directory,
				is_empty,
				is_executable,
				is_open_append,
				is_open_read,
				is_open_write,
				is_plain,
				is_readable,
				is_writable,
				file_pointer,
				file_readable,
				flush,
				last_string,
				path_exists,
				position,
				put_boolean,
				put_character,
				put_new_line,
				put_string,
				readable,
				read_line,
				read_stream,
				retrieved,
				support_storable,
				standard_is_equal
		redefine
			buffered_file_info,
			create_read_write,
			delete,
			exists,
			is_creatable,
			open_append,
			open_read,
			open_read_append,
			open_read_write,
			open_write,
			path_exists,
			set_buffer
		end

feature {NONE} -- Creation

	make (fn: STRING_32)
			-- Create file object with `fn' as file name.
		require
			string_exists: fn /= Void
			string_not_empty: not fn.is_empty
		local
			u: UTF_CONVERTER
		do
				-- Encode name as UTF-8.
			make_8 (u.string_32_to_utf_8_string_8 (fn))
		ensure
			file_named: name.same_string (fn)
			file_closed: is_closed
		end

feature -- Access

	name: STRING_32
			-- File name.
		local
			u: UTF_CONVERTER
		do
			Result := u.utf_8_string_8_to_string_32 (name_8)
		end

feature -- Status report

	exists: BOOLEAN
			-- <Precursor>
		do
			if attached external_name_16 as n then
				Result := eif_file_exists_16 ($n)
			else
				Result := Precursor
			end
		end

	path_exists: BOOLEAN
			-- <Precursor>
		do
			if attached external_name_16 as n then
				Result := eif_file_path_exists_16 ($n)
			else
				Result := Precursor
			end
		end

	is_creatable: BOOLEAN
			-- Is file creatable in parent directory?
			-- (Uses effective UID to check that parent is writable
			-- and file does not exist.)
		do
			if attached external_name_16 as n then
					-- Take terminating 0 into account.
				Result := eif_file_creatable_16 ($n, n.count - 1)
			else
				Result := Precursor
			end
		end

feature -- Access

	open_read
			-- <Precursor>
		do
			if attached external_name_16 as n then
				file_pointer := eif_file_open_16 ($n, 0)
				mode := Read_file
			else
				Precursor
			end
		end

	open_write
			-- <Precursor>
		do
			if attached external_name_16 as n then
				file_pointer := eif_file_open_16 ($n, 1)
				mode := Write_file
			else
				Precursor
			end
		end

	open_append
			-- <Precursor>
		do
			if attached external_name_16 as n then
				file_pointer := eif_file_open_16 ($n, 2)
				mode := Append_file
			else
				Precursor
			end
		end

	open_read_write
			-- <Precursor>
		do
			if attached external_name_16 as n then
				file_pointer := eif_file_open_16 ($n, 3)
				mode := Read_write_file
			else
				Precursor
			end
		end

	create_read_write
			-- <Precursor>
		do
			if attached external_name_16 as n then
				file_pointer := eif_file_open_16 ($n, 4)
				mode := Read_write_file
			else
				Precursor
			end
		end

	open_read_append
			-- <Precursor>
		do
			if attached external_name_16 as n then
				file_pointer := eif_file_open_16 ($n, 5)
				mode := Append_read_file
			else
				Precursor
			end
		end

feature -- Modification

	reset (fn: STRING_32)
			-- Change file name to `fn' and reset
			-- file descriptor and all information.
		require
			valid_file_name: fn /= Void
		local
			u: UTF_CONVERTER
		do
				-- Encode name as UTF-8.
			reset_8 (u.string_32_to_utf_8_string_8 (fn))
		ensure
			file_renamed: name.same_string (fn)
			file_closed: is_closed
		end

	change_name (new_name: STRING_32)
			-- Change file name to `new_name'.
		require
			new_name_not_void: new_name /= Void
			new_name_not_empty: not new_name.is_empty
			file_exists: exists
		local
			nn: attached like external_name_16
			u: UTF_CONVERTER
		do
			if attached external_name_16 as on then
				nn := u.string_32_to_utf_16_0 (new_name)
				eif_file_rename_16 ($on, $nn)
				reset (new_name)
			else
				change_name_8 (u.string_32_to_utf_8_string_8 (new_name))
			end
		ensure
			name_changed: name ~ new_name
		end

feature -- Removal

	delete
			-- <Precursor>
		do
			if attached external_name_16 as n then
				eif_file_unlink_16 ($n)
			else
				Precursor
			end
		end

feature {NONE} -- Access

	external_name_16: detachable SPECIAL [NATURAL_16]
			-- UTF-16 representation of `name' with terminating zero
			-- if supported on the current platform.
		local
			u: UTF_CONVERTER
		do
			if is_utf_16 then
					-- Convert to UTF-16 and add terminating zero.
				Result := u.utf_8_string_8_to_utf_16_0 (name_8)
			end
		ensure
			result_attached: is_utf_16 implies attached Result
		end

feature {NONE} -- Status setting

	set_buffer
			-- <Precursor>
		do
			buffered_file_info.update (name)
		end

	buffered_file_info: UNIX_FILE_INFO_32
			-- <Precursor>
		once
			create Result.make
		end

feature {NONE} -- Status report

	eif_file_exists_16 (f_name: POINTER): BOOLEAN
			-- Does `f_name' exist.
		require
			{PLATFORM}.is_windows
		external
			"C signature (EIF_NATURAL_16 *): EIF_BOOLEAN use %"eif_file.h%""
		end

	eif_file_path_exists_16 (f_name: POINTER): BOOLEAN
			-- Does `f_name' exist.
		external
			"C signature (EIF_NATURAL_16 *): EIF_BOOLEAN use %"eif_file.h%""
		end

	eif_file_creatable_16 (f_name: POINTER; n: INTEGER): BOOLEAN
			-- Is `f_name' of count `n' creatable.
		external
			"C signature (EIF_NATURAL_16 *, EIF_INTEGER): EIF_BOOLEAN use %"eif_file.h%""
		end

feature {NONE} -- Modification

	eif_file_open_16 (f_name: POINTER; how: INTEGER): POINTER
			-- File pointer for file `f_name', in mode `how'.
		require
			{PLATFORM}.is_windows
		external
			"C signature (EIF_NATURAL_16 *, int): EIF_POINTER use %"eif_file.h%""
		end

	eif_file_rename_16 (old_name, new_name: POINTER)
			-- Change file name from `old_name' to `new_name'.
		require
			{PLATFORM}.is_windows
		external
			"C signature (EIF_NATURAL_16 *, EIF_NATURAL_16 *) use %"eif_file.h%""
		end

feature {NONE} -- Removal.

	eif_file_unlink_16 (fname: POINTER)
			-- Delete file `fname'.
		external
			"C signature (EIF_NATURAL_16 *) use %"eif_file.h%""
		end

feature {NONE} -- Platform

	is_utf_16: BOOLEAN
			-- Should UTF-16 encoding be used for external calls?
		do
			Result := {PLATFORM}.is_windows
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
