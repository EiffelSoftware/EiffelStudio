note
	description: "[
			Generates a list of OUTPUT_ELEMENTS out of an input string 
			that can be handed over to ROOT_SERVLET_ELEMENT. It does that
			by passing the string to a chain of XB_PARSE_HANDLERs that each
			extract one tag.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XB_PREPROCESSOR

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `XB_PREPROCESSOR'.
		local
			l_output_call_parse: XB_PARSE_HANDLER_TAG_OUTPUT_CALL
			l_call_parse: XB_PARSE_HANDLER_TAG_CALL
			l_html_parse: XB_PARSE_HANDLER_HTML
		do
				-- Create parse handlers and create chain
			create l_output_call_parse.make
			create l_call_parse.make
			create l_html_parse.make
			first_parse_handler := l_output_call_parse
			l_output_call_parse.set_next (l_call_parse)
			l_call_parse.set_next (l_html_parse)
		end

feature -- Access

	first_parse_handler: XB_PARSE_HANDLER

feature -- Features yet to be named

	parse_string (a_string: STRING): LIST[OUTPUT_ELEMENT]
			-- Parses string with the list of parse tags.
		local
			l_output_elements:  LINKED_LIST [OUTPUT_ELEMENT]
		do
			create l_output_elements.make
			first_parse_handler.handle_string (l_output_elements, a_string)
				--there is probably a better way to do this instead of inverting the list...
			Result := invert_list (l_output_elements)
		end

	invert_list (a_in: LINKED_LIST[OUTPUT_ELEMENT]): LINKED_LIST [OUTPUT_ELEMENT]
			-- Inverts a linked list.
		do
			create Result.make
			from a_in.start until a_in.after loop
				Result.put_right (a_in.item)
				a_in.forth
			end
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
