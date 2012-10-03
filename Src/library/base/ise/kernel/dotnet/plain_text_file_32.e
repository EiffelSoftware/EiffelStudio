note
	description: "Same as {PLAIN_TEXT_FILE} with names in {STRING_32}."
	date: "$Date$"
	revision: "$Revision$"

class
	PLAIN_TEXT_FILE_32

inherit

	FILE_32
		rename
			index as position
		undefine
			is_plain_text,
			new_line,
			put_character,
			put_new_line,
			put_string,
			putchar,
			putstring,
			read_character,
			read_stream,
			readchar,
			readstream
		end

	PLAIN_TEXT_FILE
		rename
			change_name as change_name_8,
			make as make_8,
			name as name_8,
			reset as reset_8
		export
			{NONE} all
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
			set_buffer
		end

create
	make

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
