note
	description: "[
		Provides features to encode and decode messages
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_ENCODING_FACILITIES

create
	make

feature -- Initialization

	make
		do
		end

feature -- Conversion

	encode_natural(a_i: NATURAL; a_is_fragmented: BOOLEAN): NATURAL
			-- Leftshift of the natural (don't use numbers >= 2^31) and subsequent append of the flag bit.
			-- Use decode_natural and decode_flag for decoding.
		require
			no_too_big: a_i < 2147483648
		do
			Result := (a_i |<< 1) + a_is_fragmented.to_integer.as_natural_32
		end

	change_flag(a_i: NATURAL; a_new_flag: BOOLEAN): NATURAL
			-- Changes the flag to "new_flag" and doesn't change the encoded natural.
		do
			Result := (a_i & 0xFFFFFFFE) + a_new_flag.to_integer.as_natural_32
		end

	decode_natural_and_flag (a_i: NATURAL): TUPLE [NATURAL, BOOLEAN]
			-- Convenience feature which combines both decodings (natural and flag)
		do
			Result := [decode_natural (a_i), decode_flag (a_i)]
		end

	decode_natural  (a_i: NATURAL): NATURAL
			-- The natural that was encoded in {ENCODING_FACILITIES}.encode_natural.
		do
			Result := (a_i |>> 1)
		end

	decode_flag (a_i: NATURAL): BOOLEAN
			--`Result': the flag that was encoded in encode_natural
		do
			Result := (a_i.bit_and (1) = 1)
		end
note
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
