note
	description: "Shared encoding converter."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_ENCODING_CONVERTER

feature -- Access

	encoding_converter: ENCODING_CONVERTER
			-- Encoding converter
		do
			if attached encoding_converter_cell.item as l_converter then
				Result := l_converter
			else
				create Result.make
				set_encoding_converter (Result)
			end
		end

feature -- Query

	is_encoding_converter_set: BOOLEAN
			-- Is encoding converter set?
		do
			Result := attached encoding_converter_cell.item
		end

feature -- Element change

	set_encoding_converter (a_converter: like encoding_converter)
			-- Set `encoding_converter' with `a_converter'
		do
			encoding_converter_cell.put (a_converter)
		ensure
			set: encoding_converter_cell.item = a_converter
		end

feature {NONE} -- Implementation

	encoding_converter_cell: CELL [detachable ENCODING_CONVERTER]
			-- Cell to hold the converter.
		once
			create Result.put (Void)
		end

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
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
