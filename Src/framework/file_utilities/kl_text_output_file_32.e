note
	description: "Same as {KL_TEXT_OUTPUT_FILE} with names in {STRING_32}."
	date: "$Date$"
	revision: "$Revision$"

class
	KL_TEXT_OUTPUT_FILE_32

inherit
	KL_TEXT_OUTPUT_FILE
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
			string_name
		end

	PLAIN_TEXT_FILE_32
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
			put_integer_8 as old_put_integer_8,
			put_integer_16 as old_put_integer_16,
			put_integer_32 as old_put_integer_32,
			put_integer_64 as old_put_integer_64,
			put_natural_8 as old_put_natural_8,
			put_natural_16 as old_put_natural_16,
			put_natural_32 as old_put_natural_32,
			put_natural_64 as old_put_natural_64,
			put_boolean as old_put_boolean,
			put_new_line as old_put_new_line,
			read_character as old_read_character,
			read_stream as old_read_stream,
			read_line as old_read_line,
			change_name_8 as old_change_name,
			flush as old_flush,
			close as old_close,
			delete as old_delete,
			reset_8 as old_reset,
			append as old_append
		export {NONE} all
		redefine
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

	string_name: STRING
			-- <Precursor>
;note
	copyright: "Copyright (c) 2012, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
