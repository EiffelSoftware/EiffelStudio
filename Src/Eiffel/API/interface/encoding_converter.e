indexing
	description: "Interface of encoding converter with encoding detection."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ENCODING_CONVERTER

feature -- Conversion

	utf32_string (a_stream: STRING): STRING_32 is
			-- Detect encoding of `a_stream' and convert it into utf32.
		require
			a_stream_attached: a_stream /= Void
		deferred
		ensure
			utf32_string_attached: Result /= Void
			detected_encoding_attached: detected_encoding /= Void
		end

feature -- Detection

	detected_encoding: ?ANY
			-- Detected encoding
		deferred
		end

	detect_encoding (a_str: ?STRING_GENERAL) is
			-- Detect encoding of `a_str'
		require
			a_str_not_void: a_str /= Void
		deferred
		ensure
			detected_encoding_attached: detected_encoding /= Void
		end

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
