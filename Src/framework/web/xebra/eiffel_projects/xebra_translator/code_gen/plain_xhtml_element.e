note
	description: "Summary description for {PLAIN_XHTML_ELEMENT}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

class
	PLAIN_XHTML_ELEMENT

inherit
	OUTPUT_ELEMENT

create
	make

feature -- Access

		html_text: STRING
				-- XHTML text that should be written to the response

feature -- Initialization

		make (a_html_text: STRING)
				-- `a_html_text': XHTML text that should be written to the response
			do
				make_empty
				html_text := a_html_text
			end

feature -- Processing

		serialize (buf: INDENDATION_STREAM)
				-- <Precursor>			
			do
				buf.put_string (response_name + ".append (%"[")
				buf.indent
				buf.put_string (html_text)
				buf.unindent
				buf.put_string ("]%")")
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
