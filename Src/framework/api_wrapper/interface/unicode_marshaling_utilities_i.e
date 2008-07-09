indexing
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	UNICODE_MARSHALING_UTILITIES_I [G -> STRING_HANDLER]

feature {UNICODE_MARSHALING_UTILITIES} -- Clean up

	free (a_obj: !G)
			-- Frees the unmanaged data of the string handler object
			--
			-- `a_obj': The string handler object to free.
		require
			a_obj_is_valid_string_handler: is_valid_string_handler (a_obj)
			not_pointer_is_null: pointer (a_obj) /= default_pointer
		deferred
		end

feature {UNICODE_MARSHALING_UTILITIES} -- Query

	pointer (a_obj: !G): POINTER
			-- Retrieves a pointer from a string handler object.
			--
			-- `a_obj': A string handler object.
			-- `Result': A pointer.
		require
			a_obj_is_valid_string_handler: is_valid_string_handler (a_obj)
		deferred
		end

	string (a_obj: !G): !STRING_32
			-- Retrieves a unicode string from a string handler object.
			--
			-- `a_obj': A string handler object.
			-- `Result': A string representation of the data managed by the supplied string handler.
		require
			a_obj_is_valid_string_handler: is_valid_string_handler (a_obj)
		deferred
		end

feature {UNICODE_MARSHALING_UTILITIES} -- Status report

	is_valid_string_handler (a_obj: ?ANY): BOOLEAN
			-- Determines if a string handler object is valid for the current unicode string marshaller.
			--
			-- `a_obj': A string handler object.
			-- `Result': True of the string handler is valid; False otherwise.
		require
			a_obj_attached: a_obj /= Void
		do
			Result := {g: G} a_obj
		end

feature {UNICODE_MARSHALING_UTILITIES} -- Factory

	new_string_handler (a_str: !STRING_GENERAL): !G
			-- Creates a new unicode string handler from a given string.
			-- Note: Do not forget to call `free' when the object is no longer required.
			--
			-- `a_str': The string to initialize the string handler object with.
			-- `Result': A string handler to use with `pointer' and `string'.
		deferred
		ensure
			result_is_valid_string_handler: is_valid_string_handler (Result)
			string_set: a_str.as_string_32.is_equal (string (Result))
		end

	new_string_handler_from_count (a_count: NATURAL): !G
			-- Creates a new unicode string handler from a given string length.
			-- Note: Do not forget to call `free' when the object is no longer required.
			--
			-- `a_count': The character count of the string.
			-- `Result': A string handler to use with `pointer' and `string'.
		deferred
		ensure
			result_is_valid_string_handler: is_valid_string_handler (Result)
			string_count_set: string (Result).count = a_count
		end

	new_string_handler_from_pointer (a_ptr: POINTER; a_shared: BOOLEAN): !G
			-- Creates a new unicode string handler from a given a unmanaged pointer.
			-- Note: Do not forget to call `free' when the object is no longer required.
			--       Freeing is not strictly necessary for shared pointers, but it's good practice.
			--
			-- `a_ptr': The unmanaged pointer containing string data to create a string handler for.
			-- `a_shared': True to indicate the pointer's resources are managed else where; False to adopt
			--             resource management.
			-- `Result': A string handler to use with `pointer' and `string'.
		require
			not_a_ptr_is_null: a_ptr /= default_pointer
		deferred
		ensure
			result_is_valid_string_handler: is_valid_string_handler (Result)
			pointer_set: a_ptr = pointer (Result)
		end

	new_string_handler_from_pointer_and_count (a_ptr: POINTER; a_count: NATURAL; a_shared: BOOLEAN): !G
			-- Creates a new unicode string handler from a given a unmanaged pointer and string length.
			-- Note: Do not forget to call `free' when the object is no longer required.
			--       Freeing is not strictly necessary for shared pointers, but it's good practice.
			--
			-- `a_ptr': The unmanaged pointer containing string data to create a string handler for.
			-- `a_count': The character count of the string.
			-- `a_shared': True to indicate the pointer's resources are managed else where; False to adopt
			--             resource management.
			-- `Result': A string handler to use with `pointer' and `string'.
		deferred
		ensure
			result_is_valid_string_handler: is_valid_string_handler (Result)
			pointer_set: a_ptr = pointer (Result)
			string_count_set: string (Result).count = a_count
		end

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
