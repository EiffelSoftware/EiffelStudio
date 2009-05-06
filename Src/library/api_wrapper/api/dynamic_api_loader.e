note
	description: "[
		A dynamic API loader for accessing libraries and loaded library API functions and variables.
		
		Note: This class is not indented for direct use as {DYNAMIC_API} providers a safer model. However direct access
		      to loading or querying for an API feature may be necessary, hence the interface is available.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	DYNAMIC_API_LOADER

inherit
	ANY

	BRIDGE [DYNAMIC_API_LOADER_I]
		export
			{NONE} all
		end

	DYNAMIC_API_LOADER_I

feature -- Query

	api_pointer (a_hnd: POINTER; a_api_name: READABLE_STRING_8): POINTER
			-- <Precursor>
		do
			Result := bridge.api_pointer (a_hnd, a_api_name)
		end

	api_pointer_with_raise (a_hnd: POINTER; a_api_name: detachable READABLE_STRING_8): POINTER
			-- Retrieves a pointer to a library's API, and raises an exception if the API feature was not
			-- found.
			--
			-- `a_hnd': A valid handle pointer to a loaded dynamic library.
			-- `a_api_name': The API feature name to fetch a pointer to.
			-- `Result': A pointer to an API feature.
		require
			not_a_hnd_is_null: a_hnd /= default_pointer
			a_api_name_attached: a_api_name /= Void
			not_a_api_name_is_empty: not a_api_name.is_empty
		local
			l_exception: DYNAMIC_API_UNAVAILABLE_EXCEPTION
		do
			Result := api_pointer (a_hnd, a_api_name)
			if Result = default_pointer then
				create l_exception.make (a_api_name.as_string_8.as_attached)
				l_exception.raise
			end
		ensure
			not_result_is_null: Result /= default_pointer
		end

feature -- Basic operations

	load_library (a_name: READABLE_STRING_8; a_version: detachable READABLE_STRING_8): POINTER
			-- <Precursor>
		do
			Result := bridge.load_library (a_name, a_version)
		end

	load_library_from_path (a_path: READABLE_STRING_8): POINTER
			-- <Precursor>
		do
			Result := bridge.load_library_from_path (a_path)
		end

	unload_library (a_hnd: POINTER)
			-- <Precursor>
		do
			bridge.unload_library (a_hnd)
		end

feature {NONE} -- Factory

	new_bridge: attached DYNAMIC_API_LOADER_I
			-- <Precursor>
		do
			create {DYNAMIC_API_LOADER_IMP} Result
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
