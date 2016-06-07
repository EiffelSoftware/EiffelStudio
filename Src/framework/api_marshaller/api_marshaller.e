note
	description: "[
		A marshaller for converting Eiffel types to C types and vice-versa.
		
		Note: Using the facilities provided here caches the Eiffel and C data and must be used with
		      `free' in order to free both pieces of data.
		      
		      Automatic clean up can be performed using {API_MARSHALLED_DATA_AUTO_CLEANER}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	API_MARSHALLER

inherit
	ANY

feature {NONE} -- Access

	marshalled_data: HASH_TABLE [STRING_HANDLER, POINTER]
			-- Shared marshalled data
		note
			once_status: thread
		once
			create Result.make (13)
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

	is_unicode: BOOLEAN
			-- Indicates if the API is compiled for Unicode
		do
			Result := c_unicode_defined
		end

feature -- Conversion: To pointer

	string_to_unicode (a_str: READABLE_STRING_GENERAL): POINTER
			-- Marshals a string to a Unicode string.
			-- Note: Please call `free' on the returned pointer once you are finished with the marhalled
			--       reference. Failure to do so will cause a memory leak!
			--
			-- `a_str': The string to marshal.
			-- `Result': A pointer to a Unicode string.
		require
			a_str_attached: a_str /= Void
		local
			l_str: WEL_STRING
		do
			create l_str.make (a_str.to_string_8)
			Result := l_str.item
			check not_marshalled_data_has_result: multi_threader.test (agent marshalled_data.has (Result), False) end
			multi_threader.perform (agent marshalled_data.put (l_str, Result))
		ensure
			not_result_is_null: Result /= default_pointer
			a_ptr_is_pointer_managed: is_pointer_managed (Result)
		end

	string_to_ansi (a_str: READABLE_STRING_GENERAL): POINTER
			-- Marshals a string to an ANSI string.
			-- Note: Please call `free' on the returned pointer once you are finished with the marhalled
			--       reference. Failure to do so will cause a memory leak!
			--
			-- `a_str': The string to marshal.
			-- `Result': A pointer to an ANSI string.
		require
			a_str_attached: a_str /= Void
		local
			l_str: C_STRING
		do
			create l_str.make (a_str)
			Result := l_str.item
			check not_marshalled_data_has_result: multi_threader.test (agent marshalled_data.has (Result), False) end
			multi_threader.perform (agent marshalled_data.put (l_str, Result))
		ensure
			not_result_is_null: Result /= default_pointer
			a_ptr_is_pointer_managed: is_pointer_managed (Result)
		end

	string_to_tstring (a_str: READABLE_STRING_GENERAL): POINTER
			-- Marshals a string to a compiler selected ANSI/Unicode string.
			-- Note: Please call `free' on the returned pointer once you are finished with the marhalled
			--       reference. Failure to do so will cause a memory leak!
			--
			-- `a_str': The string to marshal.
			-- `Result': A pointer to a compiler selected ANSI/Unicode string.
		require
			a_str_attached: a_str /= Void
		do
			if is_unicode then
				Result := string_to_unicode (a_str)
			else
				Result := string_to_ansi (a_str)
			end
		ensure
			not_result_is_null: Result /= default_pointer
			a_ptr_is_pointer_managed: is_pointer_managed (Result)
		end

feature -- Conversion: From pointer

	unicode_to_string (a_ptr: POINTER): STRING_32
			-- Marshals a UNICODE string to an Eiffel string.
			-- Note: Please call `free' on the returned pointer once you are finished with the marhalled
			--       reference. Failure to do so will cause a memory leak!
			--
			-- `a_str': The string to marshal.
			-- `Result': A pointer to an ANSI string.
		require
			not_a_ptr_is_null: a_ptr /= default_pointer
		local
			l_str: WEL_STRING
		do
			if is_pointer_managed (a_ptr) and attached {READABLE_STRING_GENERAL} multi_threader.retrieve (agent marshalled_data.item (a_ptr)) as l_result then
				Result := l_result.as_string_32
			else
				create l_str.make_by_pointer (a_ptr)
				Result := l_str.string
			end
		ensure
			result_attached: Result /= Void
		end

	ansi_to_string (a_ptr: POINTER): STRING
			-- Marshals a string to a Unicode string.
			-- Note: Please call `free' on the returned pointer once you are finished with the marhalled
			--       reference. Failure to do so will cause a memory leak!
			--
			-- `a_str': The string to marshal.
			-- `Result': A pointer to a Unicode string.
		require
			not_a_ptr_is_null: a_ptr /= default_pointer
		local
			l_str: attached C_STRING
		do
			if is_pointer_managed (a_ptr) and attached {READABLE_STRING_GENERAL} multi_threader.retrieve (agent marshalled_data.item (a_ptr)) as l_result then
				Result := l_result.as_string_8
			else
				create l_str.make_by_pointer (a_ptr)
				Result := l_str.string
			end
		ensure
			result_attached: Result /= Void
		end

	tstring_to_string (a_ptr: POINTER): STRING
			-- Marshals a string to a compiler selected ANSI/Unicode string.
			-- Note: Please call `free' on the returned pointer once you are finished with the marhalled
			--       reference. Failure to do so will cause a memory leak!
			--
			-- `a_str': The string to marshal.
			-- `Result': A pointer to a compiler selected ANSI/Unicode string.
		require
			not_a_ptr_is_null: a_ptr /= default_pointer
		do
			if is_unicode then
				Result := unicode_to_string (a_ptr).as_string_8
			else
				Result := ansi_to_string (a_ptr)
			end
		ensure
			result_attached: Result /= Void
		end

	tstring_to_string_32 (a_ptr: POINTER): STRING_32
			-- Marshals a string to a compiler selected ANSI/Unicode string.
			-- Note: Please call `free' on the returned pointer once you are finished with the marhalled
			--       reference. Failure to do so will cause a memory leak!
			--
			-- `a_str': The string to marshal.
			-- `Result': A pointer to a compiler selected ANSI/Unicode string.
		require
			not_a_ptr_is_null: a_ptr /= default_pointer
		do
			if is_unicode then
				Result := unicode_to_string (a_ptr)
			else
				Result := ansi_to_string (a_ptr).as_string_32
			end
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Helpers

	unicode_marshaller: UNICODE_MARSHALING_UTILITIES
			-- Access to the Unicode string marshaller.
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

	multi_threader: MULTI_THREADER
			-- Access to a multi-threader helper class.
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature -- Factory

	new_unicode_string (a_len: NATURAL): POINTER
			-- Creates a new Unicode string.
			--
			-- `a_len': Length of the new Unicode string to create.
			-- `Result': A pointer to the new string.
		local
			l_str: WEL_STRING
		do
			create l_str.make_empty (a_len.to_integer_32)
			Result := l_str.item
			check not_marshalled_data_has_result: multi_threader.test (agent marshalled_data.has (Result), False) end
			multi_threader.perform (agent marshalled_data.put (l_str, Result))
		ensure
			not_result_is_null: Result /= default_pointer
			a_ptr_is_pointer_managed: is_pointer_managed (Result)
		end

	new_ansi_string (a_len: NATURAL): POINTER
			-- Creates a new ANSI string.
			--
			-- `a_len': Length of the new ANSI string to create.
			-- `Result': A pointer to the new string.
		local
			l_str: attached C_STRING
		do
			create l_str.make_empty (a_len.to_integer_32)
			Result := l_str.item
			check not_marshalled_data_has_result: multi_threader.test (agent marshalled_data.has (Result), False) end
			multi_threader.perform (agent marshalled_data.put (l_str, Result))
		ensure
			not_result_is_null: Result /= default_pointer
			a_ptr_is_pointer_managed: is_pointer_managed (Result)
		end

	new_tstring (a_len: NATURAL): POINTER
			-- Creates a new general string.
			--
			-- `a_len': Length of the new general string to create.
			-- `Result': A pointer to the new string.
		do
			if is_unicode then
				Result := new_unicode_string (a_len)
			else
				Result := new_ansi_string (a_len)
			end
		ensure
			not_result_is_null: Result /= default_pointer
			a_ptr_is_pointer_managed: is_pointer_managed (Result)
		end

feature -- Status report

	is_pointer_managed (a_ptr: POINTER): BOOLEAN
			-- Indicates if a pointer is managed by the API marshaller.
			--
			-- `a_ptr': A possible managed pointer.
			-- `Result': True if the pointer is manager; False otherwise.
		require
			not_a_ptr_is_null: a_ptr /= default_pointer
		do
			Result := multi_threader.test (agent marshalled_data.has (a_ptr), True)
		ensure
			marshalled_data_has_a_ptr: Result implies marshalled_data.has (a_ptr)
		end

feature -- Basic operations

	free (a_ptr: POINTER)
			-- Frees a marhalled reference.
			--
			-- `a_ptr': The pointer to free.
		require
			not_a_ptr_is_null: a_ptr /= default_pointer
			a_ptr_is_pointer_managed: is_pointer_managed (a_ptr)
		do
			multi_threader.perform (agent (ia_ptr: POINTER)
				local
					l_data: like marshalled_data
					l_handler: detachable STRING_HANDLER
				do
					l_data := marshalled_data
					if l_data.has (ia_ptr) then
						l_handler := l_data.item (ia_ptr)
						check l_handler_attached: l_handler /= Void end
						l_data.remove (ia_ptr)
						if unicode_marshaller.is_valid_string_handler (l_handler) then
								-- The string is a Unicode string so free it.
							unicode_marshaller.free (l_handler)
						else
							check not_freed: False end
						end
					end
				end (a_ptr))
		ensure
			not_is_pointer_managed: not is_pointer_managed (a_ptr)
		end

feature {NONE} -- Externals

	c_unicode_defined: BOOLEAN
			-- External to determine if Unicode symbol is defined.
		external
			"C inline"
		alias
			"return (sizeof (%"%") != sizeof (T(%" %")));"
		end

invariant
	marshalled_data_contains_attached_items:
		attached {LIST [detachable ANY]} marshalled_data.linear_representation as l_list and then
		not l_list.has (Void)

;note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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
