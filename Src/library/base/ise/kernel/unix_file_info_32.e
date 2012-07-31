note
	description: "Same as {UNIX_FILE_INFO} with names in {STRING_32}."
	date: "$Date$"
	revision: "$Revision$"

class
	UNIX_FILE_INFO_32

inherit
	UNIX_FILE_INFO
		rename
			file_name as file_name_8,
			update as update_8
		end

create
	make

feature -- Access

	file_name: detachable STRING_32
			-- Directory name
		local
			u: UTF_CONVERTER
		do
			if attached file_name_8 as n then
				Result := u.utf_8_string_8_to_string_32 (n)
			end
		end

feature -- Element change

	update (f_name: STRING_32)
			-- Update information buffer: fill it in with information
			-- from the inode of `f_name'.
		require
			{PLATFORM}.is_windows
		local
			n: like external_name_16
			u: UTF_CONVERTER
		do
			file_name_8 := u.string_32_to_utf_8_string_8 (f_name)
			n := external_name_16
			exists := eif_file_stat_16 ($n, $buffered_file_info, is_following_symlinks) = 0
		end

feature {NONE} -- Access

	external_name_16: detachable SPECIAL [NATURAL_16]
			-- UTF-16 representation of `file_name' with terminating zero.
		local
			u: UTF_CONVERTER
		do
			if attached file_name_8 as n then
					-- Convert to UTF-16 and add terminating zero.
				Result := u.utf_8_string_8_to_utf_16_0 (n)
			end
		end

feature {NONE} -- Access

	eif_file_stat_16 (name, stat_buf: POINTER; follow_symlinks: BOOLEAN): INTEGER
			-- Get information from file `name' into `stat_buf'
		require
			{PLATFORM}.is_windows
		external
			"C inline use %"eif_file.h%""
		alias
			"[
				#ifdef EIF_WINDOWS
					return eif_file_stat_16 ((EIF_NATURAL_16 *) $name, (rt_stat_buf *) $stat_buf, (int) $follow_symlinks);
				#else
					return -1;
				#endif
			]"
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
