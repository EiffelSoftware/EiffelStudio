note
	description: "[
		Factory for generating XML-RPC response objects from various kinds of other objects.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XRPC_RESPONSE_FACTORY

inherit
	ANY

	XRPC_SHARED_ERROR_CODES
		export
			{NONE} all
		end

	XRPC_SHARED_MARSHALLER
		export
			{NONE} all
		end

feature -- Query

	is_valid_value (a_value: ANY): BOOLEAN
			-- Determines if the value is a valid XML-RPC object.
			--
			-- `a_value': A object to test for validity.
			-- `Result': True if the object is valid; False otherwise.
		require
			a_value_attached: attached a_value
		do
			Result := marshaller.is_marshallable_object (a_value)
		ensure
			a_value_is_marshallable: Result implies marshaller.is_marshallable_object (a_value)
		end

	is_valid_error_code (a_code: INTEGER): BOOLEAN
			-- Determines if the error code is a valid code for this library.
			--
			-- `a_code': An error code.
			-- `Result': True if the error code is valid; False otherwise.
		do
			Result := error_codes.is_valid_error_code (a_code)
		ensure
			is_valid_error_code: Result implies error_codes.is_valid_error_code (a_code)
		end

feature -- Factory

	new_response_from_xml (a_xml: READABLE_STRING_8): detachable XRPC_RESPONSE
			-- Creates a new response object from an XML response string.
			--
			-- `a_xml': The XML response string to create an object for.
			-- `Result': A response object of Void if the XML was invalid.
		require
			a_xml_attached: attached a_xml
			not_a_xml_is_empty: not a_xml.is_empty
		do
			check not_implemented: False end
		end

	new_response_from_value (a_value: ANY): detachable XRPC_RESPONSE
			-- Creates a new response object from an Eiffel object.
			--
			-- `a_value': An Eiffel object, which can be automatically marshalled.
			-- `Result': A response object of Void if there was an error during marshalling.
		require
			a_value_attached: attached a_value
			a_valus_is_valid: is_valid_value (a_value)
		local
			l_result: detachable XRPC_VALUE
		do
			l_result := marshaller.marshal_from (a_value)
			if attached l_result then
				create {XRPC_VALUE_RESPONSE} Result.make (l_result)
			end
		end

	new_response_from_error_code (a_code: INTEGER): XRPC_FAULT_RESPONSE
			-- Creates a new response object from a XML-RPC error code (specific to this library.)
			--
			-- `a_code': The error code to generate a response object for,
			-- `Result': A response object.
		require
			a_code_is_valid_error_code: is_valid_error_code (a_code)
		do
			create Result.make (a_code, error_codes.message (a_code))
		end

	new_response_from_exception (a_exception: EXCEPTION): XRPC_FAULT_RESPONSE
			-- Creates a new response object from an Eiffel {EXCEPTION} object.
			--
			-- `a_exception': The exception to create a response object for.
			-- `Result': The fault response object.
		do
			create Result.make (-a_exception.code.abs, a_exception.meaning)
		ensure
			result_attached: attached Result
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
