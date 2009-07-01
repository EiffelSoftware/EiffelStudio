note
	description: "[
		Base exception for all marshalling orientated exceptions.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XRPC_MARSHAL_EXCEPTION

inherit
	XRPC_EXCEPTION

	XRPC_TYPE_IDS
		export
			{NONE} all
		undefine
			out
		end

feature -- Query

	type_simple_name (a_type: INTEGER): STRING
			-- Retrieves a simple type name (for interop) of the type.
			--
			-- `a_type': A type identifier.
			-- `Result': A simple description of the type.
		local
			l_sub_type: like type_simple_name
		do
			if a_type > 0 then
				if is_boolean (a_type) then
					Result := "boolean"
				elseif is_double (a_type) then
					Result := "double"
				elseif is_integer (a_type) then
					Result := "integer"
				elseif is_string (a_type) then
					Result := "string"
				elseif is_array_conform_from (a_type) or is_array_conform_to (a_type) then
					if a_type = array_any_type_id or a_type = xrpc_array_type_id then
						Result := "array"
					else
						if internal.generic_count_of_type (a_type) = 1 then
							l_sub_type := type_simple_name (internal.generic_dynamic_type_of_type (a_type, 1))
						else
							l_sub_type := type_simple_name (-1)
						end
						create Result.make (8 + l_sub_type.count)
						Result.append ("array (")
						Result.append (l_sub_type)
						Result.append_character (')')
					end
				else
					Result := "unsupported"
				end
			else
				Result := "unsupported"
			end
		ensure
			result_attached: attached Result
			not_result_is_empty: not Result.is_empty
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
