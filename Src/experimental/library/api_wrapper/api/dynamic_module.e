note
	description: "[
		Provices access to the raw API facilities of a dynamic module loaded using OS dynamic module
		loading policies.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	DYNAMIC_MODULE

inherit
	DYNAMIC_API
		rename
			make as make_api
		end

create
	make,
	make_with_version

feature {NONE} -- Initialize

	make (a_name: READABLE_STRING_8)
			-- Initialize the dynamic module.
			--
			-- `a_name': Name of the module to load, minus any file extension.
		require
			a_name_attached: attached a_name
			not_a_name_is_empty: not a_name.is_empty
		do
			create module_name.make_from_string (a_name)
			make_api
		ensure
			module_name_set: module_name.same_string (a_name)
		end

	make_with_version (a_name: READABLE_STRING_8; a_version: READABLE_STRING_8)
			-- Initialize the dynamic module with a specific version string.
			--
			-- `a_name': Name of the module to load, minus any file extension.
			-- `a_version': A minumum version of the library to load.
		require
			a_name_attached: attached a_name
			not_a_name_is_empty: not a_name.is_empty
			a_version_attached: attached a_version
			not_a_version_is_empty: not a_version.is_empty
		do
			create minimum_version.make_from_string (a_version)
			make (a_name)
		ensure
			module_name_set: module_name.same_string (a_name)
			minimum_version_attached: attached minimum_version
			minimum_version_set: minimum_version.same_string (a_version)
		end

	initialize
			-- <Precursor>
		do
		end

feature {NONE} -- Clean up

	clean_up
			-- <Precursor>
		do
		end

feature -- Access

	module_name: IMMUTABLE_STRING_8
			-- <Precursor>

	minimum_version: detachable IMMUTABLE_STRING_8
			-- <Precursor>
		note
			option: stable
		attribute
		end

feature -- Status report

	is_thread_safe: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

invariant
	module_name_attached: attached module_name
	not_module_name_is_empty: not module_name.is_empty
	not_minimum_version_is_empty: attached minimum_version implies not minimum_version.is_empty

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
