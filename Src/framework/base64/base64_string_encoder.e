note
	description: "[
		Base64 encoder for encoding/decoding eiffel {STRING} objects to and from Base64.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	BASE64_STRING_ENCODER

inherit
	BASE64_ENCODER [CHARACTER_8, STRING_8]
		rename
			decode64 as decode64_to_buffer
		redefine
			decode64_to_buffer
		end

	STRING_HANDLER

feature {NONE} -- Query

	item_to_code (a_item: CHARACTER_8): NATURAL_8
			-- <Precursor>
		do
			Result := a_item.code.as_natural_8
		end

	code_to_item (a_code: NATURAL_8): CHARACTER_8
			-- <Precursor>
		do
			Result := a_code.to_character_8
		end

feature -- Conversion

	decode64 (a_data: READABLE_STRING_8): STRING_8
			-- Decodes Base64 data back to a string.
			--
			-- `a_data': Base64 encoded data.
			-- `Result': A decode string.
		require
			a_data_attached: attached a_data
			not_a_data_is_empty: not a_data.is_empty
			a_data_is_valid_base64_data: is_valid_base64_data (a_data)
		do
			create Result.make (require_buffer_count (a_data))
			decode64_to_buffer (a_data, Result)
		ensure
			result_attached: attached Result
			result_count_set: Result.count = require_buffer_count (a_data)
		end

	decode64_to_buffer (a_data: READABLE_STRING_8; a_buffer: STRING_8)
			-- <Precursor>
		do
			a_buffer.set_count (require_buffer_count (a_data).max (a_buffer.count))
			Precursor (a_data, a_buffer)
		end

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
