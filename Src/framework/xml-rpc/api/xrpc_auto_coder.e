note
	description: "[
		An automatic encoder/decoder, serializing object based on attribute names.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XRPC_AUTO_CODER

inherit
	XRPC_CODER

	XRPC_SHARED_MARSHALLER
		export
			{NONE} all
		end

feature {NONE} -- Helpers

	type_ids: XRPC_TYPE_IDS
			-- Shared access to {XRPC_TYPE_IDS}
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature -- Encoding

	encode_to_struct (a_struct: XRPC_STRUCT)
			-- <Precursor>
		local
			l_internal: like internal
			l_marshaller: like marshaller
			l_name: STRING
			l_value: detachable ANY
			l_type: TYPE [detachable ANY]
			l_struct: XRPC_STRUCT
			i, nb: INTEGER
		do
			l_internal := internal
			l_marshaller := marshaller
				from
				i := 1
				nb := l_internal.field_count (Current)
			until
				i > nb
			loop
				l_name := l_internal.field_name (i, Current)
				l_value := l_internal.field (i, Current)
				if l_value /= Void then
					l_type := l_value.generating_type
					if l_marshaller.is_marshallable_type (l_type) then
							-- Marshallable value.
						a_struct.put (l_marshaller.marshal_from (l_value), l_name)
					elseif attached {XRPC_CODER} l_value as l_coder then
							-- Coder object.
						create l_struct.make
						l_coder.encode_to_struct (l_struct)
						a_struct.put (l_struct, l_name)
					end
				end
				i := i + 1
			end
		end

feature -- Decoding

	decode_from_struct (a_struct: XRPC_STRUCT)
			-- <Precursor>
		local
			l_internal: like internal
			l_marshaller: like marshaller
			l_name: STRING
			l_value: XRPC_VALUE
			l_object: detachable ANY
			l_type: TYPE [detachable ANY]
			i, nb: INTEGER
		do
			l_internal := internal
			l_marshaller := marshaller
			from
				i := 1
				nb := l_internal.field_count (Current)
			until
				i > nb
			loop
				l_name := l_internal.field_name (i, Current)
				if a_struct.has_member (l_name) then
					l_value := a_struct[l_name]
					l_type := l_internal.type_of_type (l_internal.field_type (i, Current))
					if l_marshaller.is_marshallable_type (l_type) then
							-- Marshallable value.
						l_object := l_marshaller.marshal_to (l_type, l_value)
						if l_object /= Void then
							if attached {XRPC_VALUE} l_object then
								l_internal.set_reference_field (i, Current, l_object)
							else
								l_type := l_object.generating_type
								if l_type = type_ids.integer_8_type and then attached {INTEGER_8_REF} l_object as l_int then
									l_internal.set_integer_8_field (i, Current, l_int)
								elseif l_type = type_ids.integer_16_type and then attached {INTEGER_16_REF} l_object as l_int then
									l_internal.set_integer_16_field (i, Current, l_int)
								elseif l_type = type_ids.integer_32_type and then attached {INTEGER_32_REF} l_object as l_int then
									l_internal.set_integer_32_field (i, Current, l_int)
								elseif l_type = type_ids.integer_64_type and then attached {INTEGER_64_REF} l_object as l_int then
									l_internal.set_integer_64_field (i, Current, l_int)
								end
							end
						end
					elseif attached {XRPC_STRUCT} l_value as l_struct then
							-- Struct object.
						l_object := new_object_from_struct (l_name, l_struct)
						if l_object /= Void then
							l_internal.set_reference_field (i, Current, l_object)
						end
					end
				end
				i := i + 1
			end
		end

feature {NONE} -- Factory

	new_object_from_struct (a_name: READABLE_STRING_8; a_struct: XRPC_STRUCT): detachable XRPC_CODER
			-- Creates a new object from a XML-RPC struct.
			--
			-- `a_name': Field name to create an object for.
			-- `a_struct': The decoding struct to use to initialize the object.
			-- `Result': A new object or Void if the object could not be initialized.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			a_struct_attached: a_struct /= Void
			a_struct_is_valid: a_struct.is_valid
		deferred
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
