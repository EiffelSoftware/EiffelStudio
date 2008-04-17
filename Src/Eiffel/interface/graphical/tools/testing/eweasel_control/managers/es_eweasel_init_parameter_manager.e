indexing
	description: "[
					Manager to set eWeasel command line parameters.
																					]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EWEASEL_INIT_PARAMETER_MANAGER

inherit
	ES_EWEASEL_SUB_MANAGER

create
	make

feature -- Command

	append_init_parameter (a_list: LIST [STRING]) is
			-- Append eWeasel process command line parameters.
		require
			not_void: a_list /= Void
		do
			a_list.extend ("-init")
			a_list.extend (manager.environment_manager.init)

			a_list.extend ("-output")
			a_list.extend (manager.environment_manager.output.as_string_8)

			-- eWeasel need `ISE_EIFFEL' and `ISE_PLATFORM' as paramters to find ec.exe
			a_list.extend ("-define")
			a_list.extend ("ISE_EIFFEL")
			a_list.extend (manager.environment_manager.ise_eiffel.as_string_8)

			a_list.extend ("-define")
			a_list.extend ("ISE_PLATFORM")
			a_list.extend (manager.environment_manager.ise_platform)

			a_list.extend ("-define")
			a_list.extend ("EWEASEL")
			a_list.extend (manager.environment_manager.eweasel)

			a_list.extend ("-define")
			a_list.extend ("INCLUDE")
			a_list.extend (manager.environment_manager.include)

			a_list.extend ("-define")
			a_list.extend ("EWEASEL_PLATFORM")
			a_list.extend (manager.environment_manager.eweasel_platform)

			a_list.extend ("-define")
			a_list.extend (manager.environment_manager.eweasel_platform)
			a_list.extend (manager.environment_manager.eweasel_platform_value)

			a_list.extend ("-define")
			a_list.extend ("PLATFORM_TYPE")
			a_list.extend (manager.environment_manager.platform_type)
		ensure
			added_two: old a_list.count < a_list.count
		end

indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
