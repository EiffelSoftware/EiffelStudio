note
	description: "[
		Emits an XML-RPC XML from the core set of XML-RPC data types and values, as well as XML-RPC
		responses.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XRPC_REQUEST_XML_EMITTER

inherit
	XRPC_REQUEST_VISITOR
		undefine
			process_array,
			process_boolean,
			process_double,
			process_integer,
			process_member,
			process_string,
			process_struct
		redefine
			process_method_call_request
		end

	XRPC_XML_EMITTER

create
	make

feature -- Processing operations

	process_method_call_request (a_name: READABLE_STRING_8; a_args: detachable ARRAY [XRPC_VALUE])
			-- <Precursor>
		local
			l_buffer: like buffer
			i, i_upper: INTEGER
		do
			l_buffer := buffer
			if is_pretty_printed then
				l_buffer.append_character ('%N')
			end
			append_opening_tag ({XRPC_CONSTANTS}.method_call_name, l_buffer, True)
			append_opening_tag ({XRPC_CONSTANTS}.method_name_name, l_buffer, False)
			append_indents (l_buffer)
			l_buffer.append (a_name)
			append_closing_tag ({XRPC_CONSTANTS}.method_name_name, l_buffer, True)
			if a_args /= Void and then not a_args.is_empty then
				append_opening_tag ({XRPC_CONSTANTS}.params_name, l_buffer, True)
				from
					i := a_args.lower
					i_upper := a_args.upper
				until
					i > i_upper
				loop
					append_opening_tag ({XRPC_CONSTANTS}.param_name, l_buffer, True)
					a_args[i].visit (Current)
					append_closing_tag ({XRPC_CONSTANTS}.param_name, l_buffer, True)
					i := i + 1
				end
				append_closing_tag ({XRPC_CONSTANTS}.params_name, l_buffer, True)
			end
			append_closing_tag ({XRPC_CONSTANTS}.method_call_name, l_buffer, True)
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
