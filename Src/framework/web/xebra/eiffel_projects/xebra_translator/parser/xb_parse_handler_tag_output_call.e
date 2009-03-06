note
	description: "Summary description for {XB_PARSE_TAG_OUTPUT_CALL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XB_PARSE_HANDLER_TAG_OUTPUT_CALL

inherit
	XB_PARSE_HANDLER_TAG

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
		end


feature -- Access

	start_tag: STRING
			-- The starting tag
		do
			Result := "<%%="
		end


	end_tag: STRING
			-- The ending tag
		do
			Result := "%%>"
		end

	name: STRING
		do
			Result := "<%%="
		end


feature -- Process

	process_inner (an_inner_string: STRING;  output_elements: LINKED_LIST [OUTPUT_ELEMENT];
			a_position: INTEGER )
			-- Knows what to do with the string inside a tag.
	do
			print ("-processing OUTP string '" + an_inner_string + "' at pos " + a_position.out + "%N")
			output_elements.put_right (create {OUTPUT_CALL_ELEMENT}.make (an_inner_string))
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
