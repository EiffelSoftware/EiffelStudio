note
	description: "[
		Most rudimentary implementation for handling loading of a dynamic module, and facilities to 
		query for dynamic APIs.
		
		Implementers should use {DYNAMIC_API} or {DYNAMIC_FILE_API}.
		
		Note: API-queries are cached to boost performace and are cached per-thread for safety. This does
		      not ensure any thread-safety when actually using the API.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	DYNAMIC_API_BASE

inherit
	DISPOSABLE
		export
			{NONE} dispose
		end

	SHARED_DYNAMIC_API_LOADER
		export
			{NONE} all
		end

feature {NONE} -- Initialize

	make
			-- Initialize the dynamic module by attempting to load it.
		do
			if api_loader.is_dynamic_library_supported then
				module_handle := load_library
				if module_handle /= default_pointer then
					initialize
				end
			end
		end

	initialize
			-- Initializes Current after the library has been successfully loaded.
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
			if not is_in_final_collect then
				unload
			end
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

feature {NONE} -- Access: cache

	api_pointer_cache: HASH_TABLE [HASH_TABLE [POINTER, READABLE_STRING_8], POINTER]
			-- Cached API pointer information for the module.
			--| Retain once-per-thread for thread-safety of cache.
		require
			is_interface_usable: is_interface_usable
		once
			create Result.make (3)
		ensure
			result_attached: Result /= Void
			result_consistent: Result = api_pointer_cache
		end

feature -- Status report

	is_interface_usable: BOOLEAN
			-- Indicates if the dynamic API interface can be used.
		do
			Result := module_handle /= default_pointer
		ensure then
			not_module_handle_is_null: Result implies module_handle /= default_pointer
		end

	is_thread_safe: BOOLEAN
			-- Indicates the thread-safety status of the wrapped library.
			--
			--|If the thread-saftey status is unknown then return False.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			is_thread_capable: Result implies {PLATFORM}.is_thread_capable
		end

feature -- Query

	api_pointer (a_api_name: READABLE_STRING_8): POINTER
			-- Retrieve an API function/variable pointer given an API name.
			--
			-- `a_api_name': An API function or variable name.
			-- `Result': A function/variable pointer or `default_pointer' if the function/variable was not
			--           found.
		require
			is_interface_usable: is_interface_usable
			a_api_name_attached: attached a_api_name
			not_a_api_name_is_empty: not a_api_name.is_empty
		local
			l_handle: like module_handle
			l_cache: like api_pointer_cache
			l_api_table: detachable HASH_TABLE [POINTER, READABLE_STRING_8]
			l_api_name_key: STRING
			l_cached: BOOLEAN
		do
			l_handle := module_handle
			l_cache := api_pointer_cache
			if
				l_cache.has (l_handle) and then
				attached l_cache.item (l_handle) as l_table
			then
				l_api_table := l_table
				if l_table.has (a_api_name) then
					Result := l_table.item (a_api_name)
						-- Using status flag in case the API does not exist.
					l_cached := True
				end
			else
					-- No cached table, created for caching after the pointer has been fetched.
				create l_api_table.make (1)
				l_cache.put (l_api_table, l_handle)
			end

			if not l_cached then
					-- No cached version, retrieve it.
				Result := api_loader.api_pointer_with_raise (module_handle, a_api_name)

					-- Add the cache.
					-- Note: If the above raises and exception then this code will not be executed.
					--       This is safe because we want the exception to be raised everytime.
				check l_api_table_attached: attached l_api_table end
				l_api_table.put (Result, create {STRING_8}.make_from_string (a_api_name))
			end
		ensure
			not_result_is_null: Result /= default_pointer
		end

feature {NONE} -- Basic operations

	load_library: POINTER
			-- Attempts to load a library from a module name and returns the loaded library module
			-- pointer.
		require
			is_dynamic_library_supported: api_loader.is_dynamic_library_supported
		deferred
		end

feature {DYNAMIC_SHARED_API} -- Externals

	module_handle: POINTER
			-- Initialized module handle

invariant
	not_module_handle_is_null: is_interface_usable implies module_handle /= default_pointer

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
