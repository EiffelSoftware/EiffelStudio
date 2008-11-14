indexing
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	UNICODE_MARSHALING_UTILITIES_IMP

inherit
	UNICODE_MARSHALING_UTILITIES_I [WEL_STRING]

feature {UNICODE_MARSHALING_UTILITIES} -- Clean up

	free (a_obj: !WEL_STRING)
			-- <Precursor>
		do
			-- Do nothing because the GC will handled it.
		end

feature {UNICODE_MARSHALING_UTILITIES} -- Query

	pointer (a_obj: !WEL_STRING): POINTER
			-- <Precursor>
		do
			Result := a_obj.item
		end

	string (a_obj: !WEL_STRING): !STRING_32
			-- <Precursor>
		do
			Result := a_obj.string.as_attached
		end

feature {UNICODE_MARSHALING_UTILITIES} -- Factory

	new_string_handler (a_str: !STRING_GENERAL): !WEL_STRING
			-- <Precursor>
		do
			create Result.make (a_str)
		end

	new_string_handler_from_count (a_count: NATURAL): !WEL_STRING
			-- <Precursor>
		do
			create Result.make_empty (a_count.to_integer_32)
		end

	new_string_handler_from_pointer (a_ptr: POINTER; a_shared: BOOLEAN): !WEL_STRING
			-- <Precursor>
		do
			if a_shared then
				create Result.make_by_pointer (a_ptr)
			else
				create Result.share_from_pointer (a_ptr)
			end
		end

	new_string_handler_from_pointer_and_count (a_ptr: POINTER; a_count: NATURAL; a_shared: BOOLEAN): !WEL_STRING
			-- <Precursor>
		do
			if a_shared then
				create Result.make_by_pointer_and_count (a_ptr, a_count.to_integer_32)
			else
				create Result.share_from_pointer_and_count (a_ptr, a_count.to_integer_32)
			end
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
