note
	description: "[
		Base class for wrapping a dynamic library APIs using OS dynamic library load resolution policies.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	DYNAMIC_API

inherit
	DYNAMIC_API_BASE

feature -- Access

	module_name: READABLE_STRING_8
			-- The library module name, without an extension.
		deferred
		ensure
			result_attached: attached Result
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Access

	minimum_version: detachable READABLE_STRING_8
			-- The library module's minimum supported version.
		deferred
		ensure
			not_result_is_empty: attached Result implies not Result.is_empty
		end

feature {NONE} -- Basic operations

	load_library: POINTER
			-- <Precursor>
		do
			Result := api_loader.load_library (module_name, minimum_version)
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
