note
	description: "[
					Interface of EiffelStudio encoding converter with encoding detection.

					Encoding detection priority:
					1. If `a_encoding' is attached, use it as the encoding of `a_file'
					2. Detect BOM from `a_file', use the detected encoding.
					3. Use the encoding specified in the context of `a_class' (.ecf)
					4. Default to ASCII (ISO-8859-1) encoding.
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EC_ENCODING_CONVERTER

inherit
	ENCODING_CONVERTER
		redefine
			encoding_from_class
		end

create
	make

feature -- Access

	encoding_from_class (a_class: ANY): ENCODING
			-- Read encoding from .ecf of `a_class'.
		do
			if attached {CLASS_I} a_class as l_class then
				-- Read encoding from .ecf
			end
		end

;note
	copyright:	"Copyright (c) 1984-2011, Eiffel Software"
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
