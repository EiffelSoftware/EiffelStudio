indexing
	description: "Used in EiffelStudio to detect/convert text among encodings."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EC_ENCODING_CONVERTER

inherit
	ENCODING_CONVERTER

	EC_ENCODINGS
		export
			{NONE} all
		end

feature -- Access

	detected_encoding: ?ENCODING
			-- <Precursor>

	utf32_string (a_stream: STRING): STRING_32 is
			-- <Precursor>
		local
			l_encoding: like detected_encoding
		do
			detect_encoding (a_stream)
			l_encoding := detected_encoding
			l_encoding.convert_to (utf32, a_stream)
			if l_encoding.last_conversion_successful then
				Result := l_encoding.last_converted_string.as_string_32
			else
				Result := a_stream.as_string_32
			end
		end

feature -- Detection

	detect_encoding (a_str: ?STRING_GENERAL) is
			-- <Precursor>
		do
			encoding_detector.detect (a_str)
			if encoding_detector.last_detection_successful then
				detected_encoding := encoding_detector.detected_encoding
			else
				create detected_encoding.make ({CODE_PAGE_CONSTANTS}.utf8)
			end
		end

feature {NONE} -- Implementation

	encoding_detector: !ENCODING_DETECTOR is
			-- Encoding detector
		once
			create {EC_SIMPLE_ENCODING_DETECTOR}Result
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
