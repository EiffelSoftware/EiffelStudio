note
	description: "Same as {RAW_FILE} with names in {STRING_32}."
	date: "$Date$"
	revision: "$Revision$"

class
	RAW_FILE_32

inherit
	FILE_32
		rename
			index as position
		undefine
			file_dopen,
			file_open,
			file_reopen,
			read_to_managed_pointer
		redefine
			eif_file_open_16
		end

	RAW_FILE
		rename
			change_name as change_name_8,
			make as make_8,
			name as name_8,
			reset as reset_8
		export {NONE} all
		undefine
			access_date,
			buffered_file_info,
			create_read_write,
			date,
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

create
	make

feature {NONE} -- Basic operation

	eif_file_open_16 (f_name: POINTER; how: INTEGER_32): POINTER
			-- File pointer for file `f_name', in mode `how'.
			-- (export status {NONE})
		external
			"C signature (EIF_NATURAL_16 *, int): EIF_POINTER use %"eif_file.h%""
		alias
			"eif_file_binary_open_16"
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
