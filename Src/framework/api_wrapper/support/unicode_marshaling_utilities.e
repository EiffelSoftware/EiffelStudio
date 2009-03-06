note
	description: "[
		A string marshaller between C and Eiffel unicode strings.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	UNICODE_MARSHALING_UTILITIES

inherit
	BRIDGE [UNICODE_MARSHALING_UTILITIES_I [STRING_HANDLER]]

	UNICODE_MARSHALING_UTILITIES_I [STRING_HANDLER]
		export
			{API_MARSHALLER} all
		redefine
			is_valid_string_handler
		end

feature {API_MARSHALLER} -- Clean up

	free (a_obj: STRING_HANDLER)
			-- <Precursor>
		do
			bridge.free (a_obj)
		end

feature {API_MARSHALLER} -- Query

	pointer (a_obj: STRING_HANDLER): POINTER
			-- <Precursor>
		do
			Result := bridge.pointer (a_obj)
		end

	string (a_obj: STRING_HANDLER): STRING_32
			-- <Precursor>
		do
			Result := bridge.string (a_obj)
		end

feature {API_MARSHALLER} -- Status report

	is_valid_string_handler (a_obj: detachable ANY): BOOLEAN
			-- <Precursor>
		do
			Result := Precursor (a_obj) and then bridge.is_valid_string_handler (a_obj)
		end

feature {API_MARSHALLER} -- Factory

	new_string_handler (a_str: READABLE_STRING_GENERAL): STRING_HANDLER
			-- <Precursor>
		do
			Result := bridge.new_string_handler (a_str)
		end

	new_string_handler_from_count (a_count: NATURAL): STRING_HANDLER
			-- <Precursor>
		do
			Result := bridge.new_string_handler_from_count (a_count)
		end

	new_string_handler_from_pointer (a_ptr: POINTER; a_shared: BOOLEAN): STRING_HANDLER
			-- <Precursor>
		do
			Result := bridge.new_string_handler_from_pointer (a_ptr, a_shared)
		end

	new_string_handler_from_pointer_and_count (a_ptr: POINTER; a_count: NATURAL; a_shared: BOOLEAN): STRING_HANDLER
			-- <Precursor>
		do
			Result := bridge.new_string_handler_from_pointer_and_count (a_ptr, a_count, a_shared)
		end

feature {NONE} -- Factory

	new_bridge: attached UNICODE_MARSHALING_UTILITIES_I [STRING_HANDLER]
			-- <Precursor>
		do
			create {UNICODE_MARSHALING_UTILITIES_IMP} Result
		end

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
