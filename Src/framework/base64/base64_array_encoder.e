note
	description: "[
		Base64 encoder for encoding/decoding eiffel {STRING} objects to and from Base64.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	BASE64_ARRAY_ENCODER

inherit
	BASE64_ENCODER [NATURAL_8, ARRAY [NATURAL_8]]
		rename
			decode64 as decode64_to_buffer
		end

feature {NONE} -- Query

	item_to_code (a_item: NATURAL_8): NATURAL_8
			-- <Precursor>
		do
			Result := a_item
		end

	code_to_item (a_code: NATURAL_8): NATURAL_8
			-- <Precursor>
		do
			Result := a_code
		end

feature -- Conversion

	decode64 (a_data: READABLE_STRING_8): ARRAY [NATURAL_8]
			-- Decodes Base64 data back to a string.
			--
			-- `a_data': Base64 encoded data.
			-- `Result': A decode string.
		require
			a_data_attached: attached a_data
			not_a_data_is_empty: not a_data.is_empty
			a_data_is_valid_base64_data: is_valid_base64_data (a_data)
		do
			create Result.make_filled (0, 1, require_buffer_count (a_data))
			decode64_to_buffer (a_data, Result)
		ensure
			result_attached: attached Result
			result_count_set: Result.count = require_buffer_count (a_data)
			result_lower_is_default: Result.lower = 1
		end

;note
	copyright: "Copyright (c) 1984-2023, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
