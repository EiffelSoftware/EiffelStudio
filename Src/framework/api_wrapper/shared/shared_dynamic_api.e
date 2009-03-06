note
	description: "[
		Base class for classes wanting to shared usage of an already initialized wrapped dynamic library {DYNAMIC_API}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	SHARED_DYNAMIC_API

inherit
	USABLE_I

	DISPOSABLE
		rename
			dispose as clean_up
		end

	SHARED_DYNAMIC_API_LOADER
		export
			{NONE} all
		end

feature {NONE} -- Initialize

	make (a_api: like api)
			-- Initialize the dynamic module by attempting to load it.
			--
			-- `a_api': The API to share.
		require
			a_api_is_interface_usable: a_api.is_interface_usable
		do
			api := a_api
			if is_interface_usable then
				initialize
			end
		ensure
			api_set: api = a_api
		end

	initialize
			-- Initializes Current after the library has been loaded.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

feature -- Clean up

	clean_up
			-- Cleans up any resources or makes additional calls, to the loaded library, to
			-- perform correct clean up.
		deferred
		end

feature -- Access

	api: DYNAMIC_API
			-- Shared dynamic API.

feature -- Status report

	is_interface_usable: BOOLEAN
			-- <Precursor>
		do
			Result := api.is_interface_usable and then module_handle /= default_pointer
		ensure then
			api_is_interface_usable: Result implies api.is_interface_usable
			not_module_handle_is_null: Result implies module_handle /= default_pointer
		end

feature -- Query

	api_pointer (a_api_name: READABLE_STRING_GENERAL): POINTER
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

feature {NONE} -- Externals

	frozen module_handle: POINTER
			-- Initialized module handle.
		require
			api_is_interface_usable: api.is_interface_usable
		do
			Result := api.module_handle
		end

invariant
	api_attached: api /= Void
	api_is_interface_usable: is_interface_usable implies api.is_interface_usable

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
