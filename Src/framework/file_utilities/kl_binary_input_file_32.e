note
	description: "Same as {KL_BINARY_INPUT_FILE} with names in {STRING_32}."
	date: "$Date$"
	revision: "$Revision$"

class
	KL_BINARY_INPUT_FILE_32

inherit
	KL_BINARY_INPUT_FILE
		rename
			make as make_utf_8
		undefine
			access_date,
			buffered_file_info,
			create_read_write,
			date,
			is_creatable,
			old_delete,
			old_exists,
			old_open_append,
			old_open_read,
			old_open_write,
			open_read_append,
			open_read_write,
			path_exists,
			set_buffer
		redefine
			last_character,
			last_string,
			string_name
		end

	RAW_FILE_32
		rename
			change_name as change_name_32,
			make_8 as old_make,
			name_8 as string_name,
			name as name_32,
			reset as reset_32,
			count as old_count,
			exists as old_exists,
			is_readable as old_is_readable,
			is_open_read as old_is_open_read,
			is_open_write as old_is_open_write,
			end_of_file as old_end_of_file,
			is_closed as old_is_closed,
			open_read as old_open_read,
			open_write as old_open_write,
			open_append as old_open_append,
			put_character as old_put_character,
			put_string as old_put_string,
			put_integer as old_put_integer,
			put_boolean as old_put_boolean,
			put_new_line as old_put_new_line,
			read_character as old_read_character,
			read_stream as old_read_stream,
			read_line as old_read_line,
			read_to_string as old_read_to_string,
			change_name_8 as old_change_name,
			flush as old_flush,
			close as old_close,
			delete as old_delete,
			reset_8 as old_reset,
			append as old_append
		export {NONE} all
		undefine
			file_readable
		redefine
			last_character,
			last_string,
			make,
			string_name
		end

create
	make

feature {NONE} -- Creation

	make (n: like name_32)
			-- Create a new file named `n'.
		local
			u: UTF_CONVERTER
		do
			make_utf_8 (u.string_32_to_utf_8_string_8 (n))
		end

feature -- Access

	last_character: CHARACTER
			-- <Precursor>

	last_string: STRING
			-- <Precursor>

	string_name: STRING
			-- <Precursor>

;note
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
