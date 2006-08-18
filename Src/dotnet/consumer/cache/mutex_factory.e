indexing
	description: "A class for create mutexes"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MUTEX_FACTORY

feature -- Access

	new_mutex (a_name: STRING): SYSTEM_MUTEX is
			-- Instantiate new named mutex with name `a_name'.
			-- Grant full control to everyone so that multiple users can access
			-- the metadata cache concurrently.
		local
			l_security: MUTEX_SECURITY
			l_rule: MUTEX_ACCESS_RULE
		do
			create Result.make (False, a_name)
			l_security := Result.get_access_control
			create l_rule.make ("Everyone", {MUTEX_RIGHTS}.Full_control, {ACCESS_CONTROL_TYPE}.Allow)
			l_security.add_access_rule (l_rule)
			Result.set_access_control (l_security)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
