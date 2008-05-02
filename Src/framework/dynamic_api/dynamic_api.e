indexing
	description: "[
		Base class for wrapping a dynamic library API.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	DYNAMIC_API

inherit
	DISPOSABLE
		export
			{NONE} all
		end

inherit {NONE}
	SHARED_DYNAMIC_API_LOADER
		export
			{NONE} all
		end

feature {NONE} -- Initialize

	make
			-- Initialize the dynamic module by attempting to load it.
		do
			module_handle := load_library (module_name)
			if module_handle /= default_pointer then
				initialize
			end
		end

	initialize
			-- Initializes Current after the library has been loaded
		require
			not_module_handle_is_null: module_handle /= default_pointer
		deferred
		end

feature -- Clean up

	unload
			-- Unloads the Current loaded library.
		local
			l_handle: like module_handle
		do
			l_handle := module_handle
			if l_handle /= default_pointer then
				clean_up
				api_loader.unload_library (l_handle)
				module_handle := default_pointer
			end
		ensure then
			module_handle_is_null: module_handle = default_pointer
			not_is_interface_usable: not is_interface_usable
		end

feature {NONE} -- Clean up

	frozen dispose
			-- <Precursor>
		do
			unload
		end

feature {NONE} -- Clean up

	clean_up
			-- Cleans up any resources or makes additional calls, to the loaded library, to
			-- perform correct clean up.
		require
			not_module_handle_is_null: module_handle /= default_pointer
		deferred
		ensure
			module_handle_unchanged: module_handle = old module_handle
		end

feature {NONE} -- Access

	module_name: !STRING_32
			-- The library module name, without an extension.
		deferred
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature -- Status report

	is_interface_usable: BOOLEAN
			-- Indicates if the API is usable.
		do
			Result := module_handle /= default_pointer
		ensure
			not_module_handle_is_null: Result implies module_handle /= default_pointer
		end

feature -- Query

	api_pointer (a_api_name: ?STRING_GENERAL): POINTER
			-- Retrieve an API function/variable pointer given an API name.
			--
			-- `a_api_name': An API function or variable name.
			-- `Result': A function/variable pointer of null if the function/variable was not found.
		require
			is_interface_usable: is_interface_usable
			a_api_name_attached: a_api_name /= Void
			not_a_api_name_is_empty: not a_api_name.is_empty
		do
			Result := api_loader.api_pointer_with_raise (module_handle, a_api_name)
		ensure
			not_result_is_null: Result /= default_pointer
		end

feature {NONE} -- Basic operations

	load_library (a_name: !STRING_32): POINTER
			-- Attempts to load a library from a module name.
			--
			--| Note: Redefine if the API needs to load a library using a path, or some other special
			--        manner.
			--
			-- `a_name': The name of the dynamic library.
			-- `Result': A module handle pointer of the loaded library or null if the library could
			--           not be loaded.
		require
			not_a_name_is_empty: not a_name.is_empty
		do
			Result := api_loader.load_library (a_name)
		end

feature {DYNAMIC_SHARED_API} -- Externals

	module_handle: POINTER
			-- Initialized module handle

invariant
	not_module_handle_is_null: is_interface_usable implies module_handle /= default_pointer

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
