indexing
	description: "[
		An interface of the dynamic API loader for accessing libraries and loaded library API functions and variables.
		
		Note: This class is not indented for direct use as {DYNAMIC_API} providers a safer model. However direct access
		      to loading or querying for an API feature may be necessary, hence the interface is available.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	DYNAMIC_API_LOADER_I

feature -- Query

	api_pointer (a_hnd: POINTER; a_api_name: ?STRING_GENERAL): POINTER
			-- Retrieves a pointer to a library's API.
			--
			-- `a_hnd': A valid handle pointer to a loaded dynamic library.
			-- `a_api_name': The API feature name to fetch a pointer to.
			-- `Result': A pointer to an API feature or `default_pointer' if the API routine could not be
			--           found.
		require
			not_a_hnd_is_null: a_hnd /= default_pointer
			a_api_name_attached: a_api_name /= Void
			not_a_api_name_is_empty: not a_api_name.is_empty
		deferred
		end

feature -- Basic operations

	load_library (a_name: ?STRING_GENERAL; a_version: ?STRING_GENERAL): POINTER
			-- Attempts to loads a dynamic library using a library name.
			--
			-- `a_name': The name of a dynamic library, without an extension.
			-- `a_version': An optional version string of the library to load.
			-- `Result': A pointer to the loaded library module, or `default_pointer' if the library could not be loaded.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			not_a_version_is_empty: a_version /= Void implies not a_version.is_empty
		deferred
		end

	load_library_from_path (a_path: ?STRING_GENERAL): POINTER
			-- Attempts to loads a dynamic library from a path on disk.
			--
			-- `a_path': The path to a dynamic library.
			-- `Result': A pointer to the loaded library module, or `default_pointer' if the library could not be loaded.
		require
			a_path_attached: a_path /= Void
			not_a_path_is_empty: not a_path.is_empty
		deferred
		end

	unload_library (a_hnd: POINTER)
			-- Attempts to unloads a dynamic library using a library name.
			--
			-- `a_hnd': The module handle pointer returned from `load_library' or `load_library_from_path'.
		require
			not_a_hnd_is_null: a_hnd /= default_pointer
		deferred
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
